import os
import googlemaps

"""All the calculations needed for finding the midpoint between two given addresses.
Needed if user chooses the midpoint way of finding search results, which is the only
way so far."""

# must run 'source secrets.sh' before running this file to make
# sure the environmental var's are set
gmaps = googlemaps.Client(key=os.environ['GMAPS_KEY'])


def mi_to_m(radius):
    return int(float(radius) * 1609.34)


def stricter_radius(radius1, radius2):
    if radius1 > radius2:
        return radius2
    return radius1


def geocoding(st_address, city, state):
    """Turns the given address into a list containing latitude and longitude."""
    geocoded_address = gmaps.geocode(", ".join([st_address, city, state]))
    coords_list = geocoded_address[0]['geometry']['location'].values()
    return coords_list


def combine_coordinates_for_midpt(coords_list1, coords_list2):
    """ Preps two coordinate pairs for the midpoint formula calculation. """
    return coords_list1 + coords_list2


def midpt_formula(coordinates):
    """Takes two coordinate pairs and returns a coordinate pair that is midway."""
    xm = (coordinates[0] + coordinates[2])/2.0
    ym = (coordinates[1] + coordinates[3])/2.0
    return [xm, ym]
