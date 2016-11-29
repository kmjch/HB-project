# HB-project
Eat Together helps two people decide on a place to to share a meal together.

<img src="http://gifimgs.com/res/1116/583de71331479307869642.gif">

Eat Together, or ET for short, makes a Yelp search based on both of their locations and preferences.  You can choose whether you want to search from a midpoint of your two locations, or if you would rather have your friend come to your area.  The latter was a little bit harder to implement but interesting as was an opportunity to involve functional programming.

One of my favorite parts about creating ET was realizing I can do so much with the Yelp search results.  When you click the search button, an AJAX request sends your form inputs as search parameters to the Yelp API in Python. Yelp returns a JSON list of businesses that I then parse through to create this ordered list as well as these map markers.

This list consists of links to their respective Yelp sites.  When you hover on one of these links, a button to save this location shows up.  When you click it, you can save your visit to the PostgreSQL databases via SQLAlchemy.  And these markers are clickable, with the infoWindows holding restaurant information from Yelp.

The PostgreSQL databases include tables for keeping track of restaurant and visit information.  You can see your history of visits and ratings and get a recommendation for a restaurant that is similar to your highest rated restaurant.

<img src="http://gifimgs.com/img/1116/583de7f2229bb157081314-gif/">

I made this recommendation using euclidean distance on the quantifiable information from Yelp on each business.  To calculate this, I used the Python libraries Pandas and SciPy to analyze the PostgreSQL data and measure the ‘distance’ between each restaurant in terms of its attributes.  Whatever has the least differences in its attributes to the highly rated restaurant is then shown in green here.  I chose euclidean distance as it is one of the components of the k nearest neighbors algorithm from sklearn which I’ve been exploring and want to display in version 2 of ET.

Michelle Kim is a software engineer living in the San Francisco Bay Area.
