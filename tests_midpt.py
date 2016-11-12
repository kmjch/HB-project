from midpt_formula import *
import unittest

class MidptTest(unittest.TestCase):
    """Unit tests for the calculations behind the making of the midpoint between
    two user locations."""

    def test_mi_to_m(self):
        assert mi_to_m(3) == 4828

    def test_stricter_radius(self):
        self.assertEqual(stricter_radius(3, 2), 2)
        # which form is better? it seems like this is better because it uses self

    def test_geocoding(self):
        self.assertEqual(geocoding("683 Sutter St", "San Francisco", "CA"), [37.7886679, -122.4114987])

    def test_midpt_formula(self):
        self.assertEqual(midpt_formula([37.86408, -122.254124],
                                       [37.8684539, -122.259389]),
                         [37.866266949999996, -122.2567565])

if __name__ == '__main__':
    # If called like a script, run our tests
    unittest.main()
