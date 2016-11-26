# read our dataset in and figure out which columns are present
import pandas, json, csv, math

# json_file = open('sample_restaurants.json')
# json_str = json_file.read()
# res = json.loads(json_str)
# write_csv = csv.writer(open("test.csv", "w"))

# write_csv.writerow(['name', 'rating', 'price', 'review_count'])


# for i in range(len(res['businesses'])):
#     write_csv.writerow([res['businesses'][i]['name'],
#                         res['businesses'][i]['rating'],
#                         res['businesses'][i]['price'],
#                         res['businesses'][i]['review_count']])


# write utf-8 in csv file
# classes provided for me in python docs to write in specific encoding
# import csv, codecs, cStringIO
# all I need is UnicodeWriter
with open('test.csv') as csvfile:
    results = pandas.read_csv(csvfile, header=0)
# The names of all the columns in the data.
print results.columns.values


# Select gather from our dataset
selected_restaurant = results[results['name'] == 'Gather'].iloc[0]
# selected_restaurant = res['businesses'][0]['name']

# # Choose only the numeric columns (we'll use these to compute euclidean distance)
distance_columns = ['rating', 'price', 'review_count']

# # rating: results['businesses'][i]['rating']
# # price: results['businesses'][i]['price']
# # review_count: results['businesses'][i]['review_count']

# # name: results['businesses'][i]['name']
# # categories: results['businesses'][i]['categories'][j]['alias']
# # categories: results['businesses'][i]['categories'][j]['title']


def euclidean_distance(row):
    """A simple euclidean distance function"""
    inner_value = 0
    for k in distance_columns:
        inner_value += (row[k] - selected_restaurant[k]) ** 2
    return math.sqrt(inner_value)

# Find the distance from each restaurant in the dataset to gather.
gather_distance = results.apply(euclidean_distance, axis=1)

# Select only the numeric columns from the restaurant results dataset
res_numeric = results[distance_columns]

# Normalize all of the numeric columns
res_normalized = (res_numeric - res_numeric.mean()) / res_numeric.std()

from scipy.spatial import distance

# Fill in NA values in res_normalized
res_normalized.fillna(0, inplace=True)

# Find the normalized vector for gather.
gather_normalized = res_normalized[results["name"] == "Gather"]

# Find the distance between gather and everywhere else.
euclidean_distances = res_normalized.apply(lambda row: distance.euclidean(row, gather_normalized), axis=1)

# Create a new dataframe with distances.
distance_frame = pandas.DataFrame(data={"dist": euclidean_distances, "idx": euclidean_distances.index})
distance_frame.sort("dist", inplace=True)

# Find the most similar restaurant to gather (the lowest distance to gather is
# gather, the second smallest is the most similar non-gather restaurant)
second_smallest = distance_frame.iloc[1]["idx"]
most_similar_to_gather = results.loc[int(second_smallest)]["name"]


import random
from numpy.random import permutation

# Randomly shuffle the index of results.
random_indices = permutation(results.index)
# Set a cutoff for how many items we want in the test set (in this case 1/3 of the items)
test_cutoff = math.floor(len(results)/3)
# Generate the test set by taking the first 1/3 of the randomly shuffled indices.
test = results.loc[random_indices[1:test_cutoff]]

# Generate the train set with the rest of the data.
train = results.loc[random_indices[test_cutoff:]]

# The columns that we will be making predictions with.
x_columns = ['rating', 'price', 'review_count']
# The column that we want to predict.
y_column = ["user_rating"]
# need to make this

from sklearn.neighbors import KNeighborsRegressor
# Create the knn model.
# Look at the five closest neighbors.
knn = KNeighborsRegressor(n_neighbors=5)
# Fit the model on the training data.
knn.fit(train[x_columns], train[y_column])
# Make point predictions on the test set using the fit model.
predictions = knn.predict(test[x_columns])
