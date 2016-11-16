import json
from unittest import TestCase
from model import *
from server import *


class FlaskTestsBasic(TestCase):
    """Flask tests."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        self.client = app.test_client()

        # Show Flask errors that happen during tests
        app.config['TESTING'] = True

    def test_index(self):
        """Test homepage page."""

        result = self.client.get("/")
        self.assertIn("Search term*", result.data)


class FlaskTestsDatabase(TestCase):
    """Flask tests that use the database."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        self.client = app.test_client()
        app.config['TESTING'] = True

        # Connect to test database
        connect_to_db(app)

        # Create tables and add sample data
        db.create_all()
        seed_data()

    def test_add_visit(self):
        """Test whether adding a visit on the website interface adds it also to
        the database."""

        data = {'friend': 'hmcdonald1',
                'when': '2016-11-14',
                'rating': '2',
                'restaurant': 'McDonalds',
                'yelp_id': 'fake-yelp-McDonalds'}
        r = requests.get("http://localhost:5000/add_visit.json",
                         data=data)
        return r

    def test_login(self):
        """Test login page."""

        result = self.client.post("/login",
                                  data={"username": "firstone", "password": "hihi"},
                                  follow_redirects=True)
        self.assertNotIn("log in", result.data)
        self.assertIn("Michelle's Account", result.data)

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()


class FlaskTestsSearch(TestCase):
    """Flask tests for the search function."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        self.client = app.test_client()

        # Show Flask errors that happen during tests
        app.config['TESTING'] = True

    def test_results(self):
        """Test whether search results will show up after clicking the button.
        Uses a mock API."""

        f = open('sample_restaurants.json')
        data = json.load(f)
        r = requests.get("http://localhost:5000/search.json",
                         data=data)
        return r  # this json can't be decoded
        # think I need to do something js-related here too


class FlaskTestsLoggedIn(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        app.config['TESTING'] = True
        app.config['SECRET_KEY'] = 'key'
        self.client = app.test_client()

        # Connect to test database
        connect_to_db(app)

        # Create tables and add sample data
        db.create_all()
        seed_data()

        with self.client as c:
            with c.session_transaction() as session:
                session['username'] = 'firstone'

    def test_logged_in_home_page(self):
        """Test home page when logged in."""

        result = self.client.get("/")
        self.assertIn("Hi firstone!", result.data)
        self.assertNotIn("Register here or log in!", result.data)

    def test_user_page(self):
        """Test user page."""

        result = self.client.get("/users/firstone")
        self.assertIn("Update your phone number and addresses!", result.data)

    def test_add_user_details_page(self):
        """Test add user details page."""

        result = self.client.get("/add-user-details")
        self.assertIn("Add Profile Info", result.data)

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()


class FlaskTestsLoggedOut(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        app.config['TESTING'] = True
        self.client = app.test_client()

    # def test_save_visit_form(self):
    #     """Test that user can't save visits to database when logged out."""

    #     result = self.client.get("/")
    #     self.assertNotIn("Saved!", result.data)
    #     self.assertIn("Login to save", result.data)


if __name__ == "__main__":
    import unittest

    unittest.main()
