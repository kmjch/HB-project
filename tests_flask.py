import json
from unittest import TestCase
from model import *
import server
import requests


class FlaskTestsBasic(TestCase):
    """Flask tests."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        self.client = server.app.test_client()

        # Show Flask errors that happen during tests
        server.app.config['TESTING'] = True

    def test_index(self):
        """Test homepage page."""

        result = self.client.get("/")
        self.assertIn("Search term*", result.data)


class FlaskTestsDatabase(TestCase):
    """Flask tests that use the database."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        self.client = server.app.test_client()
        server.app.config['TESTING'] = True

        # Connect to test database
        connect_to_db(server.app, "postgresql:///meatup")

        with self.client as c:
            with c.session_transaction() as sess:
                sess['username'] = 'ajkdfsjal'

        # Create tables and add sample data
        db.create_all()
        seed_data()

    # def test_login(self):
    #     """Test login page."""

    #     result = self.client.post("/login",
    #                               data={"username": "firstone", "password": "hihi"},
    #                               follow_redirects=True)
    #     self.assertNotIn("log in", result.data)
    #     self.assertIn("Michelle's Account", result.data)
    # put into the other set of tests that test login function

    def test_add_visit(self):
        """Test whether adding a visit on the website interface adds it also to
        the database."""

        data = {'friend': 'hmcdonald1',
                'when': '2016-11-14',
                'rating': '2',
                'restaurant': 'McDonalds',
                'yelp_id': 'fake-yelp-McDonalds'}
        self.client.get("/add_visit.json", data=data)
        db_query = db.session.query.filter_by(yelp_id='fake-yelp-McDonalds')
        self.assertEqual(db_query.name, 'McDonalds')


    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()


class FlaskTestsSearch(TestCase):
    """Flask tests for the search function."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        self.client = server.app.test_client()

        # Show Flask errors that happen during tests
        server.app.config['TESTING'] = True

        def _mock_search_yelp(params):
            return "Beanstalk Cafe"

        server.search_yelp = _mock_search_yelp

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()

    def test_results(self):
        """Test whether search results will show up after clicking the button.
        Uses a mock API."""

        # data = {'term': 'cafe',
        #         'latitude': 37.788668,
        #         'longitude': -122.411499,
        #         'radius': mi_to_m(1),
        #         'limit': 20,
        #         }
        data = {'term1': 'cafe',
                'st_address1': '683 sutter st',
                'city1': 'sf',
                'state1': 'ca',
                'radius1': server.mi_to_m(.3),
                'limit': 20,
                'st_address2': 'embarcadero bart',
                'city2': 'sf',
                'state2': 'ca',
                'radius2': server.mi_to_m(2)
                }
        r = self.client.get("/search.json",
                            data=data)
        self.assertEqual(r.status_code, 200)
        self.assertIn("Beanstalk Cafe", result.data)


class FlaskTestsLoggedIn(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        # Get the Flask test client
        server.app.config['TESTING'] = True
        server.app.config['SECRET_KEY'] = 'key'
        self.client = server.app.test_client()

        # Connect to test database
        connect_to_db(server.app)

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

        server.app.config['TESTING'] = True
        self.client = server.app.test_client()

    # def test_save_visit_form(self):
    #     """Test that user can't save visits to database when logged out."""

    #     result = self.client.get("/")
    #     self.assertNotIn("Saved!", result.data)
    #     self.assertIn("Login to save", result.data)


if __name__ == "__main__":
    import unittest

    unittest.main()
