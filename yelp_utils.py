# yelp helper functions

import time
from datetime import datetime

def unix_time(time_str):
    """ If the user specifies a time "later" on the form, converts the given time into
    unix for Yelp API """
    print "making unix time"
    if time_str:
        d = datetime.strptime(str(time_str), "%Y-%m-%dT%H:%M")
        unix = time.mktime(d.timetuple())
        return int(unix)


# Cleaning up price and term values for the Yelp API search


def avoid_price_duplicates(price1, price2):
    print "avoiding price duplicates"
    return ','.join(list(set(price1 + price2)))


def avoid_term_duplicates(term1, term2):
    print "avoiding term duplicates"
    if term1.lower() == term2.lower():
        return term1
    return term1 + ", " + term2
