"""Models and database functions for Ratings project."""

from flask_sqlalchemy import SQLAlchemy
import json

# This is the connection to the PostgreSQL database; we're getting this through
# the Flask-SQLAlchemy helper library. On this, we can find the `session`
# object, where we do most of our interactions (like committing, etc.)

db = SQLAlchemy()


##############################################################################
# Model definitions

class User(db.Model):
    """User of app."""

    __tablename__ = "users"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    # the only required fields: email, username, password
    email = db.Column(db.String(64), nullable=False)
    username = db.Column(db.String(64), nullable=False)
    password = db.Column(db.String(64), nullable=False)
    # separate fields for home address
    home_st = db.Column(db.String(64), nullable=True)
    home_cty = db.Column(db.String(64), nullable=True)
    home_state = db.Column(db.String(20), nullable=True)
    home_zip = db.Column(db.String(15), nullable=True)
    # separate fields for work address
    work_st = db.Column(db.String(64), nullable=True)
    work_cty = db.Column(db.String(64), nullable=True)
    work_state = db.Column(db.String(20), nullable=True)
    work_zip = db.Column(db.String(15), nullable=True)

    ph_num = db.Column(db.Integer, nullable=True)


    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<User user_id=%s username=%s>" % (self.user_id, self.username)


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
    rating = db.Column(db.Integer, nullable=True)

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


def example_data():
    """ Create some sample data. """

    f = open('MOCK_DATA.json')
    data = json.load(f)

    users_exdata = [User(username='kmich', password='hihi', email='hi@gmail.com')]
    for user in data:
        users_exdata.append(User(username=user['username'], password=user['password'], email=user['email']))
    db.session.add_all(users_exdata)
    db.session.commit()

##############################################################################
# Helper functions

def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///meatup'
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
