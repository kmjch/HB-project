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


# Processing Person 1 and Person 2's json results for Venn Diagram search
def get_id(business):
    return business['id']


def get_common_ids(results1, results2):
    list1 = map(get_id, results1['businesses'])
    list2 = map(get_id, results2['businesses'])
    return set(list1) & set(list2)


def get_common_restaurants(results1, results2):
    new_list = []
    for business in results1['businesses']:
        if business['id'] in get_common_ids(results1, results2):
            new_list.append(business)
    return new_list
