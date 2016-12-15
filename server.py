import os, sys, googlemaps, requests, yelp, itertools
import pandas, json, csv, math

from jinja2 import StrictUndefined

from flask import Flask, jsonify, render_template, redirect, request, flash, session, url_for, make_response
from flask_debugtoolbar import DebugToolbarExtension
from flask_sqlalchemy import SQLAlchemy

from model import *
from midpt_formula import *
from yelp_utils import *
from decimal import Decimal
from machine import *


app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "ABC"

# Normally, if you use an undefined variable in Jinja2, it fails
# silently. This is horrible. Fix this so that, instead, it raises an
# error.
app.jinja_env.undefined = StrictUndefined
app.jinja_env.auto_reload = True


@app.route('/')
def index():
    """ The search form is the homepage. """
    return render_template("search-form.html",
                           GMAPS_JS_KEY=os.environ['GMAPS_JS_KEY'])


@app.route('/search.json')
def search_process():
    """ Processes the request from AJAX to submit a search into the Yelp API. """

    # processing search parameters common to each person
    open_now = request.args.get("open_now")
    time = request.args.get("time")
    limit = request.args.get("limit")
    search_type = request.args.get("search-type")

    # person 1's search parameters
    term1 = request.args.get("term1")
    lat1 = float(request.args.get("lat1"))
    lng1 = float(request.args.get("lng1"))
    radius1 = request.args.get("radius1")
    price1 = str(request.args.get("price1"))
    # person 2's search parameters
    lat2 = float(request.args.get("lat2"))
    lng2 = float(request.args.get("lng2"))
    price2 = str(request.args.get("price2"))

    # uses the Google Maps API to geocode and functions written in midpt_formula.py
    # to find the midpoint of the two given addresses
    # loc1 = geocoding(st_address1, city1, state1)
    # loc2 = geocoding(st_address2, city2, state2)
    loc1 = [lat1, lng1]
    loc2 = [lat2, lng2]
    mid_lat, mid_lng = midpt_formula(loc1, loc2)

    if search_type == 'midpt':
        term2 = request.args.get("term2")
        radius2 = request.args.get("radius2")
        sort_by = request.args.get("sort_by")
        # sort only works for midpt because of the sets used in venn diagram calculations

        params_midpt = {'term': avoid_term_duplicates(term1, term2),
                        'latitude': mid_lat,
                        'longitude': mid_lng,
                        'radius': mi_to_m(stricter_radius(radius1, radius2)),
                        'sort_by': sort_by,
                        'limit': limit,
                        }

        if time:
            params_midpt['open_at'] = unix_time(time)
        elif open_now:
            params_midpt['open_now'] = open_now

        # results for Midpoint Formula calculation Yelp search
        responses = search_yelp(params_midpt)

    elif search_type == 'venn':
        # the dictionary of search parameters to submit to the Yelp API
        params_user1 = {'term': term1,
                        'latitude': loc1[0],
                        'longitude': loc1[1],
                        'radius': mi_to_m(radius1),
                        }
        # import pdb; pdb.set_trace()
        distance = calc_dist(tuple(loc1), tuple(loc2))
        params_user2 = {'term': term1,
                        'latitude': loc2[0],
                        'longitude': loc2[1],
                        'radius': distance,
                        }

        # adds the search parameter price if either user inputs a price
        if price1 or price2:
            params_user1['price'] = avoid_price_duplicates(price1, price2)
            params_user2['price'] = avoid_price_duplicates(price1, price2)

        # adds the business hours parameter if they specify whether they would want
        # to go to the business now or at a future time
        if time:
            params_user1['open_at'] = unix_time(time)
            params_user2['open_at'] = unix_time(time)
        elif open_now:
            params_user1['open_now'] = open_now
            params_user2['open_now'] = open_now

        # results for Venn Diagram calculation: two separate Yelp searches for both
        results1 = search_yelp(params_user1)
        results2 = search_yelp(params_user2)


        # finding the results common to both and adding them to a dictionary
        responses = {}
        responses['businesses'] = get_common_restaurants(results1, results2)

    responses['person1'] = loc1
    responses['person2'] = loc2
    return jsonify(responses)

    # sends the locations of each person for creating markers on the map

    # do a for loop for when I get more than 2 people meeting up


def search_yelp(params):
    """Make a get request to Yelp API with given parameters from user's form inputs."""
    url = 'https://api.yelp.com/v3/businesses/search'
    headers = {'Authorization': 'Bearer ' + os.environ['YELP_KEY']}
    resp = requests.get(url=url, params=params, headers=headers)
    responses = resp.json()
    return responses


def process_price(price_lvl):
    dict_prices = {'$': 1, '$$': 2, '$$$': 3, '$$$$': 4, '$$$$$': 5}
    return dict_prices[price_lvl]


@app.route('/add_visit.json')
# change to post
def add_visit():
    """ Adds the visit to the database. """

    # checks to see if user is logged in

    if session.get('username'):
        username = session['username']
        user = User.query.filter_by(username=username).first()

        # finds the friend searched for on the database
        friend = request.args.get("friend")
        friend_user = User.query.filter_by(username=friend).first()

        when = request.args.get("when")
        user_rating = Decimal(request.args.get("rating"))

        # finds the restaurant's ID, adds the restaurant to the database if not in yet
        restaurant = request.args.get("name")
        yelp_id = request.args.get("id")
        avg_rating = request.args.get("avg_rating")
        price_lvl = request.args.get("price")
        review_count = request.args.get("rc")
        categs = request.args.get("categs")
        list_categs = categs.split(",")

        if not Restaurant.query.filter_by(name=restaurant).all():
            new_restaurant = Restaurant(yelp_id=yelp_id,
                                        name=restaurant,
                                        rating=avg_rating,
                                        price=process_price(price_lvl),
                                        review_count=review_count)
            db.session.add(new_restaurant)
            db.session.commit()

        rest_id = db.session.query(Restaurant.id).filter_by(yelp_id=yelp_id).first()[0]
        if not Category.query.filter_by(rest_id=rest_id).all():
            if len(list_categs) == 3:
                categ1, categ2, categ3 = list_categs
            elif len(list_categs) == 2:
                categ1, categ2 = list_categs
                categ3 = None
            else:
                categ1 = list_categs
                categ2 = None
                categ3 = None
            new_categs = Category(rest_id=rest_id,
                                  categ1=categ1,
                                  categ2=categ2,
                                  categ3=categ3)
            db.session.add(new_categs)
            db.session.commit()

        # Adding to the visits and uservisits tables
        new_visit = Visit(rest_id=rest_id, date=when)
        db.session.add(new_visit)
        db.session.commit()
        new_visit_id = db.session.query(Visit.id).filter_by(rest_id=rest_id,
                                                            date=when).order_by(Visit.date.desc()).first()[0]
        new_visit_exp = UserExp(visit_id=new_visit_id,
                                user_id=user.id,
                                rating=user_rating)
        f_new_visit_exp = UserExp(visit_id=new_visit_id,
                                  user_id=friend_user.id)
        db.session.add(new_visit_exp)
        db.session.add(f_new_visit_exp)
        db.session.commit()
        return "  <span class='label label-success'>Saved!</span>"

    # if not logged in, cannot save
    else:
        return "  <a href='/login'><span class='label label-default'>Login to save</span></a>"



# Other pages

@app.route('/register')
def show_register_form():
    """ Display the signup form. """
    return render_template("register-form.html")


@app.route('/register-process', methods=["POST"])
def register_process():
    """Process registration of new user."""

    # Get form variables
    fname = request.form.get("fname")
    lname = request.form.get("lname")
    email = request.form.get("email")
    username = request.form.get("username")
    password = request.form.get("password")

    # check if already in the database
    check_email = User.query.filter_by(email=email).all()
    check_username = User.query.filter_by(username=username).all()

    if check_email == [] and check_username == []:

        new_user = User(fname=fname, lname=lname, email=email, username=username,
                        password=password)

        db.session.add(new_user)
        db.session.commit()

        flash("Welcome to ET, %s!" % fname)
        return redirect("/users/%s" % new_user.username)

    ################

    elif check_email != []:
        flash("Email already taken. Do you mean to log in?")
        return render_template("register-form.html")
    elif check_username != []:
        flash("Username already taken. Do you mean to log in?")
        return render_template("register-form.html")


@app.route('/login', methods=['GET'])
def show_login_form():
    """Show login form."""

    return render_template("login-form.html")


@app.route('/login', methods=['POST'])
def login_process():
    """Process login."""

    # Get form variables
    username = request.form["username"]
    password = request.form["password"]

    user = User.query.filter_by(username=username).first()

    if not user:
        flash("We don't recognize your username. Want to register?")
        return redirect("/login")

    if user.password != password:
        flash("Incorrect password")
        return redirect("/login")

    session["username"] = user.username

    flash("Logged in")
    return redirect("/users/%s" % user.username)


@app.route('/logout')
def logout():
    """Log out."""

    del session["username"]
    flash("Logged Out.")
    return redirect("/")




@app.route("/users/<username>")
def user_detail(username):
    """Show info about user."""

    user = User.query.filter_by(username=username).one()
    if user.user_exps:
        list_ratings = [(user.user_exps[i].rating, user.user_exps[i].visit.restaurant.name) for i in range(len(user.user_exps))]
        sorted_ratings = sorted(list_ratings, reverse=True)
        highest_rated_restaurant = sorted_ratings[0][1]
        most_sim = predict_restaurant(highest_rated_restaurant)
    session['username'] = user.username

    # from sqlalchemy import create_engine
    # engine = create_engine('postgresql://meatup')
    # df_users = pandas.read_sql_query('select * from "users"', con=engine)
    # df_visits = pandas.read_sql_query('select * from "visits"', con=engine)
    # import pdb; pdb.set_trace()

    return render_template("user.html",
                           user=user,
                           sorted_ratings=sorted_ratings,
                           highest_rated=highest_rated_restaurant,
                           most_sim=most_sim)


@app.route('/add-user-details')
def show_user_detail_form():
    """ Shows form for inputting more details and reads cookie. """

    return render_template("add-user-details.html")


@app.route('/process-user-details', methods=["POST"])
def process_user_details():
    """Process user details."""

    u = User.query.filter_by(username=session['username']).one()

    # Get form variables and set them to the user's attributes
    u.phone_num = request.form["phone_num"]
    u.home_str = request.form["home_str"]
    u.home_cty = request.form["home_cty"]
    u.home_sta = request.form["home_sta"]
    u.home_zip = request.form["home_zip"]
    u.work_str = request.form["work_str"]
    u.work_cty = request.form["work_cty"]
    u.work_sta = request.form["work_sta"]
    u.work_zip = request.form["work_zip"]

    db.session.add(u)
    db.session.commit()

    flash("Updated your profile!")
    return redirect("/users/%s" % session['username'])


@app.route("/error")
def error():
    raise Exception("Error!")


# a function for showing nothing instead of 'None' if any of the fields are NULL, generalizing the variables so that any of the fields can use this same function


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True

    connect_to_db(app, os.environ.get("DATABASE_URL"))

    # Use the DebugToolbar
    # DebugToolbarExtension(app)

    # Use the Flask Login Library
    # login_manager = LoginManager()
    # login_manager.init_app(app)

    PORT = int(os.environ.get("PORT", 5000))
    DEBUG = "NO_DEBUG" not in os.environ
    app.run(host="0.0.0.0", port=PORT, debug=DEBUG)
