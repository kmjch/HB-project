import os
import googlemaps


"""All the calculations needed for finding the midpoint between two given addresses.
Needed if user chooses the midpoint way of finding search results, which is the only
way so far."""

# must run 'source secrets.sh' before running this file to make
# sure the environmental var's are set
gmaps = googlemaps.Client(key=os.environ['GMAPS_KEY'])
gmaps_dist = googlemaps.Client(key=os.environ['GMAPS_DIST_KEY'])


def mi_to_m(radius):
    """Converts miles to meters, rounded to the nearest whole number."""
    return int(float(radius) * 1609.34)


def stricter_radius(radius1, radius2):
    """Chooses the smaller radius given from either person."""
    if radius1 > radius2:
        return radius2
    return radius1


def geocoding(st_address, city, state):
    """Turns the given address into a list containing latitude and longitude."""
    geocoded_address = gmaps.geocode(", ".join([st_address, city, state]))
    coords = geocoded_address[0]['geometry']['location'].values()
    return coords


def midpt_formula(loc1, loc2):
    """Takes two coordinate pairs and returns a coordinate pair that is midway."""
    xm = (loc1[0] + loc2[0])/2.0
    ym = (loc1[1] + loc2[1])/2.0
    return [xm, ym]


def calc_dist(loc1, loc2):
    """Calculates the distance between two given coordinates."""
    matrix = googlemaps.distance_matrix.distance_matrix(client=gmaps_dist, origins=loc2, destinations=loc1)
    # import pdb; pdb.set_trace()
    return matrix['rows'][0]['elements'][0]['distance']['value']

# def rev_geocoding(coords):
