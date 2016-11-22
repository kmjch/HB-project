"""Models and database functions for Ratings project."""

from flask_sqlalchemy import SQLAlchemy
from random import randint
import json, datetime

# This is the connection to the PostgreSQL database; we're getting this through
# the Flask-SQLAlchemy helper library. On this, we can find the `session`
# object, where we do most of our interactions (like committing, etc.)

db = SQLAlchemy()


##############################################################################
# Creates the database tables for User, UserExperiences, Visits, and Restaurants

class User(db.Model):
    """User of app."""

    __tablename__ = "users"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    # the only required fields, on registration form
    fname = db.Column(db.String(64), nullable=False)
    lname = db.Column(db.String(64), nullable=False)
    email = db.Column(db.String(64), nullable=False)
    username = db.Column(db.String(64), nullable=False)
    password = db.Column(db.String(64), nullable=False)
    # separate fields for home address
    home_str = db.Column(db.String(64), nullable=True)
    home_cty = db.Column(db.String(64), nullable=True)
    home_sta = db.Column(db.String(20), nullable=True)
    home_zip = db.Column(db.String(15), nullable=True)
    # separate fields for work address
    work_str = db.Column(db.String(64), nullable=True)
    work_cty = db.Column(db.String(64), nullable=True)
    work_sta = db.Column(db.String(20), nullable=True)
    work_zip = db.Column(db.String(15), nullable=True)

    phone_num = db.Column(db.String(64), nullable=True)

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<User user_id=%s username=%s>" % (self.id, self.username)


class UserExp(db.Model):
    """ records more information about a visit from a user's perspective. """

    __tablename__ = "uservisits"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    visit_id = db.Column(db.Integer,
                         db.ForeignKey('visits.id'),
                         nullable=False)
    user_id = db.Column(db.Integer,
                        db.ForeignKey('users.id'),
                        nullable=False)
    rating = db.Column(db.Numeric, nullable=True)

    # define relationship to users--there are many user_exp's to one user
    user = db.relationship("User", backref='user_exps')

    # define relationship to visits--there are many user_exp's to one visit
    visit = db.relationship("Visit", backref='user_exps')

    def __repr__(self):
        """ Provide helpful representation when printed. """

        return "<UserExp id=%d visit_id=%d user_id=%d>" % (self.id, self.visit_id, self.user_id)


class Visit(db.Model):
    """ records when users visit and where. """

    __tablename__ = "visits"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    rest_id = db.Column(db.Integer,
                        db.ForeignKey('restaurants.id'),
                        nullable=False)
    date = db.Column(db.DateTime, nullable=True)

    # define relationship to restaurant--there are many visits to one restaurant
    restaurant = db.relationship("Restaurant", backref='visits')

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Visit id=%d rest_id=%s date=%s>" % (self.id, self.rest_id, self.date)


class Restaurant(db.Model):
    """ """

    __tablename__ = "restaurants"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    yelp_id = db.Column(db.String(64), nullable=False)
    name = db.Column(db.String(64), nullable=False)

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Restaurant id=%d name=%s>" % (self.id, self.name)


##############################################################################
# Seed sample data for above tables

def make_sample_user_data():
    """ Create some sample user data. """

    f = open('MOCK_DATA.json')
    data = json.load(f)

    users_exdata = [User(fname='Michelle', lname='Kim', email='hi@mail.com', username='firstone', password='hihi')]
    for user in data:
        users_exdata.append(User(fname=user['fname'],
                                 lname=user['lname'],
                                 email=user['email'],
                                 username=user['username'],
                                 password=user['password']))
    db.session.add_all(users_exdata)
    db.session.commit()


def add_sample_restaurants():
    """ Add some real restaurants from Berkeley to the database. """

    f = open('sample_restaurants.json')
    data = json.load(f)
    restaurants = []
    for restaurant in data['businesses']:
        restaurants.append(Restaurant(yelp_id=restaurant['id'],
                                      name=restaurant['name']))
    db.session.add_all(restaurants)
    db.session.commit()


def add_sample_visits():
    """ Add sample data regarding visits by multiple users to the same restaurant, currently for 2 people. """
    visits = []
    i = 0
    while i < 600:
        visits.append(Visit(rest_id=randint(1, 20), date=datetime.datetime.now()))
        i += 1
    db.session.add_all(visits)
    db.session.commit()


def make_sample_user_visits():
    """ Create some sample data about user visits. """
    visits = db.session.query(Visit.id).all()
    new_user_visits = []
    for visit_id in visits:
        uv1 = UserExp(visit_id=visit_id, user_id=randint(1, 351), rating=randint(1, 5))
        uv2 = UserExp(visit_id=visit_id, user_id=randint(1, 351), rating=randint(1, 5))
        if uv1.user_id != uv2.user_id:
            new_user_visits = [uv1, uv2]
            db.session.add_all(new_user_visits)
    db.session.commit()


def seed_data():
    make_sample_user_data()
    add_sample_restaurants()
    add_sample_visits()
    make_sample_user_visits()


##############################################################################
# Helper functions

def connect_to_db(app, db_uri="postgresql:///meatup"):
    """Connect the database to our Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app
    connect_to_db(app)
    db.create_all()
    print "Connected to DB."
