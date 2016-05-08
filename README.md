# xgboost based solution for the Digit Recognition challenge on Kaggle
The Kaggle Digit Recognition practice challenge and the data sets are at: https://www.kaggle.com/c/digit-recognizer

This solution is based on xgboost and scores in the top 30% of the Kaggle leaderboard. The only algorithms that outperform it and have been made publicly available are Neural Networks and Support Vector Clustering.

Open and run in this order:

- data_munging.R. This script loads the data, turns the pixels into categorical variables, creates variables that count the number of pixels turned on in each row and column, computes the width in rows and columns of each image, and the total area of the image. It shows that the width in rows and columns is at most 19 pixels for every single image.

- data_reduction.R. This script reduces all images to a format of 19x19 since none of them is larger than this. It may take a while to run (1 to 2 hours). It creates the file "reduced_data.csv".

- data_munging_2.R. This script performs similar actions as data_munging.R, on the reduced data. It also calculates the perimeter of the figure, and additional features that record how many lines cross a row and a column in each figure. "border_comparison.R" and "row_column_changes.R" need to be in the same folder.

- xgb_predictions.R. Loads the data set and uses extreme gradient boosting to make predictions on the test set.
