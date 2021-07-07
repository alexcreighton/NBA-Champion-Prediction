import pandas as pd

from sklearn.tree import DecisionTreeClassifier

from sklearn.model_selection import train_test_split

from sklearn import metrics

from sklearn.metrics import confusion_matrix

col_names = ['Team', 'Season', 'Champ', 'Games', 'Wins', 'Losses', 'Win_perc', 'Home_Wins', 'Home_Losses',
             'Home_Win_perc', 'Away_Wins', 'Away_Losses', 'Away_Win_perc', 'PPG', 'OPP_PPG', 'Point_diff',
             'ORTG', 'DRTG', 'eFG_perc', 'OPP_eFG_perc', 'Three_perc', 'OPP_FG_perc', 'FT_perc', 
             'TPG', 'SPG', 'DRB', 'TRB', 'DRB_perc', 'Num_All_Stars']

# load dataset
predict = pd.read_csv("/Users/alexcreighton/Desktop/Personal Projects/NBA Champs/past30_full.csv",
                   header=1, names=col_names)


#predict['Win_perc'].value_counts()

print(predict.head())



feature_cols = ['Win_perc', 'Home_Win_perc', 'Away_Win_perc', 'OPP_PPG', 'Point_diff',
             'ORTG', 'DRTG', 'eFG_perc', 'OPP_eFG_perc', 'Three_perc', 'OPP_FG_perc', 'FT_perc', 
             'TPG', 'SPG', 'DRB', 'TRB', 'DRB_perc', 'Num_All_Stars']

X = predict[feature_cols]

test = X.dtypes
print(test)

X.to_numpy()

y = predict.Champ

X_train, X_test, y_train, y_test = train_test_split(X, y,
                                            test_size=0.3, random_state=1) # 70% training and 30% test

clf = DecisionTreeClassifier()

# Train Decision Tree Classifer
clf = clf.fit(X_train,y_train)

#Predict the response for test dataset
y_pred = clf.predict(X_test)

print("Accuracy:",metrics.accuracy_score(y_test, y_pred))

#Confusion matrix
y_true = y_test

confused = confusion_matrix(y_true, y_pred)
print(confused)


