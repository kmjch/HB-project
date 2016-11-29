# # read our dataset in and figure out which columns are present
import pandas, json, csv, math
from sqlalchemy import create_engine
import psycopg2 as pg
import pandas.io.sql as psql

# # json_file = open('sample_restaurants.json')
# # json_str = json_file.read()
# # res = json.loads(json_str)
# # write_csv = csv.writer(open("test.csv", "w"))

# # write_csv.writerow(['name', 'rating', 'price', 'review_count'])


# # for i in range(len(res['businesses'])):
# #     write_csv.writerow([res['businesses'][i]['name'],
# #                         res['businesses'][i]['rating'],
# #                         res['businesses'][i]['price'],
# #                         res['businesses'][i]['review_count']])


# # write utf-8 in csv file
# # classes provided for me in python docs to write in specific encoding
# # import csv, codecs, cStringIO
# # all I need is UnicodeWriter


# # engine = create_engine('postgresql://meatup')

# # connection = pg.connect("dbname=meatup user=vagrant")
# # results = psql.read_sql("SELECT * FROM restaurants", connection)

# # \COPY restaurants TO '/home/vagrant/src/HB-project/restaurant.csv' DELIMITER ',' CSV HEADER;
def predict_restaurant(highest_rated_restaurant):
    with open('test.csv') as csvfile:
        res_data = pandas.read_csv(csvfile, header=0)
        # change to read from psql meatup
    # The names of all the columns in the data.
    print res_data.columns.values

    # Select gather from our dataset
    selected_restaurant = res_data[res_data['name'] == highest_rated_restaurant].iloc[0]
    # selected_restaurant = res['businesses'][0]['name']

    # # Choose only the numeric columns (we'll use these to compute euclidean distance)
    distance_columns = ['rating', 'price', 'review_count', 'user_rating']

    def euclidean_distance(row):
        """A simple euclidean distance function"""
        inner_value = 0
        for k in distance_columns:
            inner_value += (row[k] - selected_restaurant[k]) ** 2
        return math.sqrt(inner_value)

    # Find the distance from each restaurant in the dataset to hrr.
    hrr_distance = res_data.apply(euclidean_distance, axis=1)

    # Select only the numeric columns from the restaurant res_data dataset
    res_numeric = res_data[distance_columns]

    # Normalize all of the numeric columns
    res_normalized = (res_numeric - res_numeric.mean()) / res_numeric.std()
    print 'res_normalized: ', res_normalized

    from scipy.spatial import distance

    # Fill in NA values in res_normalized
    res_normalized.fillna(0, inplace=True)
    print 'res_normalized: after filling in NA values ', res_normalized

    # Find the normalized vector for the most highly rated restaurant.
    highest_rated_restaurant_normalized = res_normalized[res_data["name"] == highest_rated_restaurant]

    # Find the distance between gather and everywhere else.
    euclidean_distances = res_normalized.apply(lambda row: distance.euclidean(row, highest_rated_restaurant_normalized), axis=1)

    # Create a new dataframe with distances.
    distance_frame = pandas.DataFrame(data={"dist": euclidean_distances, "idx": euclidean_distances.index})
    distance_frame.sort("dist", inplace=True)

    # Find the most similar restaurant to gather (the lowest distance to gather is
    # gather, the second smallest is the most similar non-gather restaurant)
    second_smallest = distance_frame.iloc[1]["idx"]
    most_similar_to_highest_rated_restaurant = res_data.loc[int(second_smallest)]["name"]

    import random
    from numpy.random import permutation

    # Randomly shuffle the index of res_data.
    random_indices = permutation(res_data.index)
    # Set a cutoff for how many items we want in the test set (in this case 1/3 of the items)
    test_cutoff = math.floor(len(res_data)/3)
    # Generate the test set by taking the first 1/3 of the randomly shuffled indices.
    test = res_data.loc[random_indices[1:test_cutoff]]

    # Generate the train set with the rest of the data.
    train = res_data.loc[random_indices[test_cutoff:]]

    # The columns that we will be making predictions with.
    x_columns = ['rating', 'price', 'review_count']
    # The column that we want to predict.
    y_column = ['user_rating']

    from sklearn.neighbors import KNeighborsRegressor
    # Create the knn model.
    # Look at the five closest neighbors.
    knn = KNeighborsRegressor(n_neighbors=5)
    # Fit the model on the training data.
    knn.fit(train[x_columns], train[y_column])
    # Make point predictions on the test set using the fit model.
    predictions = knn.predict(test[x_columns])

    # Get the actual values for the test set.
    actual = test[y_column]

    # Compute the mean squared error of predictions.
    mse = (((predictions - actual) ** 2).sum()) / len(predictions)
    return most_similar_to_highest_rated_restaurant
