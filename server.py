import os
import sys
import googlemaps
import requests
import yelp

from jinja2 import StrictUndefined

from flask import Flask, jsonify, render_template, redirect, request, flash, session, url_for, make_response
from flask_debugtoolbar import DebugToolbarExtension
from flask_sqlalchemy import SQLAlchemy

from model import connect_to_db, db, User, UserExp, Visit, Restaurant
from midpt_formula import *


app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "ABC"

# Normally, if you use an undefined variable in Jinja2, it fails
# silently. This is horrible. Fix this so that, instead, it raises an
# error.
app.jinja_env.undefined = StrictUndefined
app.jinja_env.auto_reload = True

# must run 'source secrets.sh' before running this file to make
# sure the environmental var's are set
gmaps = googlemaps.Client(key=os.environ['GMAPS_KEY'])

@app.route('/')
def index():
    """ I have only the form so far, so it'll be the homepage. """

    if not request.args.get('submitting-search-form'):
        return render_template("search-form.html", result=None)
    else:
        # Get form variables
        term1 = request.args.get("term1")
        st_address1 = request.args.get("st_address1")
        city1 = request.args.get("city1")
        state1 = request.args.get("state1")
        radius1 = request.args.get("radius1")
        categories1 = request.args.get("categories1")

        term2 = request.args.get("term2")
        st_address2 = request.args.get("st_address2")
        city2 = request.args.get("city2")
        state2 = request.args.get("state2")
        radius2 = request.args.get("radius2")
        categories2 = request.args.get("categories2")

        # should I replace this with a for loop for variable # of people to meet up?

        latitude, longitude = midpt_formula(combine_coordinates_for_midpt(geocoding(st_address1, city1, state1), geocoding(st_address2, city2, state2)))

        params_midpt = {'term': term1 + ", " + term2,
                        'latitude': latitude,
                        'longitude': longitude,
                        'radius': mi_to_m(stricter_radius(radius1, radius2))}

        params_user1 = {'term': term1,
                        'latitude': geocoding(st_address1, city1, state1)[0],
                        'longitude': geocoding(st_address1, city1, state1)[1],
                        'radius': mi_to_m(radius1)}

        params_user2 = {'term': term2,
                        'latitude': geocoding(st_address2, city2, state2)[0],
                        'longitude': geocoding(st_address2, city2, state2)[1],
                        'radius': mi_to_m(radius2)}

        url = 'https://api.yelp.com/v3/businesses/search'
        resp = requests.get(url=url, params=params_midpt, headers={'Authorization': 'Bearer ' + os.environ['YELP_KEY']})
        responses = resp.json()

        name_of_first_search_result = responses['businesses'][0]['name']

        return render_template("search-form.html", result=name_of_first_search_result,
                               logged_in=session['username'])


@app.route('/search-results')
def show_search_results():
    return render_template("search-results.html")


@app.route('/register')
def show_register_form():
    return render_template("register-form.html")


@app.route('/register-process', methods=["POST"])
def register_process():
    """Process registration."""

    # Get form variables
    fname = request.form["fname"]
    lname = request.form["lname"]
    email = request.form["email"]
    username = request.form["username"]
    password = request.form["password"]

    new_user = User(fname=fname, lname=lname, email=email, username=username,
                    password=password)

    db.session.add(new_user)
    db.session.commit()

    flash("Welcome to ET, %s!" % fname)
    return redirect("/users/%s" % new_user.username)


@app.route('/login', methods=['GET'])
def login_form():
    """Show login form."""

    return render_template("login-form.html")


@app.route('/login', methods=['POST'])
def login_process():
    """Process login."""

    # Get form variables
    username = request.form["username"]
    password = request.form["password"]
    print "\n\n\n\n", username, "\n\n\n\n\n"

    user = User.query.filter_by(username=username).first()

    if not user:
        flash("We don't recognize your username. Want to register?")
        return redirect("/login")

    if user.password != password:
        flash("Incorrect password")
        return redirect("/login")

    session["username"] = user.username
    print "\n\n\n\n\n", session['username']

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

    session['username'] = username
    user = User.query.filter_by(username=username).one()
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

    u.phone_num
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



# doesn't work
# def show_toolbar(request):
#     return True
# DEBUG_TOOLBAR_CONFIG = {
#     "SHOW_TOOLBAR_CALLBACK" : show_toolbar,
# }

if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")
