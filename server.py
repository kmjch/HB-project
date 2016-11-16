import os
import sys
import googlemaps
import requests
import yelp

from jinja2 import StrictUndefined

from flask import Flask, jsonify, render_template, redirect, request, flash, session, url_for, make_response
from flask_debugtoolbar import DebugToolbarExtension
from flask_sqlalchemy import SQLAlchemy

from model import *
from midpt_formula import *
from yelp_utils import *


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

    # processing search parameters for person 1
    term1 = request.args.get("term1")
    st_address1 = request.args.get("st_address1")
    city1 = request.args.get("city1")
    state1 = request.args.get("state1")
    radius1 = request.args.get("radius1")
    price1 = str(request.args.get("price1"))

    # processing search parameters for person 2
    term2 = request.args.get("term2")
    st_address2 = request.args.get("st_address2")
    city2 = request.args.get("city2")
    state2 = request.args.get("state2")
    radius2 = request.args.get("radius2")
    price2 = str(request.args.get("price2"))

    # processing search parameters common to each person
    open_now = request.args.get("open_now")
    time = request.args.get("time")
    sort_by = request.args.get("sort_by")
    limit = request.args.get("limit")

    # uses the Google Maps API to geocode and functions written in midpt_formula.py
    # to find the midpoint of the two given addresses
    p1_loc = geocoding(st_address1, city1, state1)
    p2_loc = geocoding(st_address2, city2, state2)
    mid_lat, mid_lng = midpt_formula(p1_loc, p2_loc)

    

    # the dictionary of search parameters to submit to the Yelp API
    params_midpt = {'term': avoid_term_duplicates(term1, term2),
                    'latitude': mid_lat,
                    'longitude': mid_lng,
                    'radius': mi_to_m(stricter_radius(radius1, radius2)),
                    'sort_by': sort_by,
                    'limit': limit}

    # adds the search parameter price if either user inputs a price
    if price1 or price2:
        params_midpt['price'] = avoid_price_duplicates(price1, price2)

    # adds the business hours parameter if they specify whether they would want
    # to go to the business now or at a future time
    if time:
        params_midpt['open_at'] = unix_time(time)
    elif open_now:
        params_midpt['open_now'] = open_now

    params_user1 = {'term': term1,
                    'latitude': geocoding(st_address1, city1, state1)[0],
                    'longitude': geocoding(st_address1, city1, state1)[1],
                    'radius': mi_to_m(radius1),
                    }

    params_user2 = {'term': term2,
                    'latitude': geocoding(st_address2, city2, state2)[0],
                    'longitude': geocoding(st_address2, city2, state2)[1],
                    'radius': mi_to_m(radius2),
                    }

    # Yelp API request
    url = 'https://api.yelp.com/v3/businesses/search'
    resp1 = requests.get(url=url, params=params_user1, headers={'Authorization': 'Bearer ' + os.environ['YELP_KEY']})
    results1 = resp1.json()
    print "\n\n\n\nresults1: ", results1
    resp2 = requests.get(url=url, params=params_user2, headers={'Authorization': 'Bearer ' + os.environ['YELP_KEY']})
    results2 = resp2.json()
    print "\n\n\n\nresults2: ", results2

    def get_id(business):
        return business['id']
    def get_common(results1, results2):
        list1 = map(get_id, results1['businesses'])
        list2 = map(get_id, results2['businesses'])
        return set(list1) & set(list2)

    def get_common_restaurants(results1, results2):
        new_list = []
        for business in results1['businesses']:
            if business['id'] in get_common(results1, results2):
                new_list.append(business)
        return new_list

    new_dictionary = {}
    new_dictionary['person1'] = p1_loc
    new_dictionary['person2'] = p2_loc
    new_dictionary['businesses'] = get_common_restaurants(results1, results2)

    return jsonify(new_dictionary)

    # import pdb; pdb.set_trace()


    # # sends the locations of each person for creating markers on the map
    # results1['person1'] = p1_loc

    # # do a for loop for when I get more than 2 people meeting up

    # return jsonify(results)


@app.route('/add_visit.json')
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
        rating = request.args.get("rating")

        # finds the restaurant's ID, adds the restaurant to the database if not in yet
        restaurant = request.args.get("restaurant")
        r_yelp_id = request.args.get("yelp_id")

        if not Restaurant.query.filter_by(name=restaurant).all():
            new_restaurant = Restaurant(yelp_id=r_yelp_id, name=restaurant)
            db.session.add(new_restaurant)
            db.session.commit()
        rest_id = db.session.query(Restaurant.id).filter_by(yelp_id=r_yelp_id).first()[0]

        # Adding to the visits and uservisits tables
        new_visit = Visit(rest_id=rest_id, date=when)
        db.session.add(new_visit)
        db.session.commit()
        new_visit_id = db.session.query(Visit.id).filter_by(rest_id=rest_id, date=when).order_by(Visit.date.desc()).first()[0]
        new_visit_exp = UserExp(visit_id=new_visit_id, user_id=user.id, rating=rating)
        f_new_visit_exp = UserExp(visit_id=new_visit_id, user_id=friend_user.id)
        db.session.add(new_visit_exp)
        db.session.add(f_new_visit_exp)
        db.session.commit()
        return " Saved!"

    # if not logged in, cannot save
    else:
        return "    [<a href='/login'>Login to save</a>]"



# Other pages

@app.route('/register')
def show_register_form():
    """ Display the signup form. """
    return render_template("register-form.html")


@app.route('/register-process', methods=["POST"])
def register_process():
    """Process registration of new user."""

    # Get form variables
    fname = request.form["fname"]
    lname = request.form["lname"]
    email = request.form["email"]
    username = request.form["username"]
    password = request.form["password"]

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

    # need to change these, but will do later because this is not a priority


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

    session['username'] = user.username

    return render_template("user.html", user=user)


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
    # print u.username

    flash("Updated your profile!")
    return redirect("/users/%s" % session['username'])


# a function for showing nothing instead of 'None' if any of the fields are NULL, generalizing the variables so that any of the fields can use this same function


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    # Use the Flask Login Library
    # login_manager = LoginManager()
    # login_manager.init_app(app)

    app.run(debug=True, host="0.0.0.0")
