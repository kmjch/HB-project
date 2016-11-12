import json
from unittest import TestCase
from model import *
from server import app
import server


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
        connect_to_db(app, "postgresql:///testdb")

        # Create tables and add sample data
        db.create_all()
        seed_data()

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()

    def test_login(self):
        """Test login page."""

        result = self.client.post("/login",
                                  data={"username": "testname", "password": "123"},
                                  follow_redirects=True)
        self.assertIn("Logged in", result.data)


class FlaskTestsLoggedIn(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        app.config['TESTING'] = True
        app.config['SECRET_KEY'] = 'key'
        self.client = app.test_client()

        with self.client as c:
            with c.session_transaction() as session:
                session['username'] = 'testname'

    def test_logged_in_home_page(self):
        """Test home page when logged in."""

        result = self.client.get("/")
        self.assertIn("Hi testname!", result.data)
        self.assertNotIn("Register here or log in!", result.data)

    def test_user_page(self):
        """Test user page."""

        result = self.client.get("/users/testname")
        self.assertIn("Update your phone number and addresses!", result.data)

    def test_add_user_details_page(self):
        """Test add user details page."""

        result = self.client.get("/add-user-details")
        self.assertIn("Add Profile Info", result.data)


class FlaskTestsLoggedOut(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        app.config['TESTING'] = True
        self.client = app.test_client()

    def test_save_visit_form(self):
        """Test that user can't save visits to database when logged out."""

        result = self.client.get("/")
        self.assertNotIn("Saved!", result.data)
        self.assertIn("Login to save", result.data)


if __name__ == "__main__":
    import unittest

    unittest.main()
