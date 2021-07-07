-- NBA_champs
-- This file is used to gain insight into the previous 30 NBA champions
-- The figures found using this code will be used to establish a baseline for predicting future champions

-- The minimum stat levels for "qualification" were determined using research on relevant team statistics
-- that indicate the potential to become champion, as well as using my knowledge of basketball


--open the dataset 

SELECT * 
FROM champs;


-- get count of teams who qualify for each stat individually
-- we set the minimum qualifications for each important statistic being evaluated 
-- and return the count of the number of teams who fulfill each stat

SELECT COUNT(Team) AS 'win_perc_count'
FROM champs
WHERE Win_perc >= 0.634;


SELECT COUNT(Team) AS 'Scoring diff rank top 8'
FROM champs
WHERE Scoring_Diff_Rank <= 8;


SELECT COUNT(Team) AS 'Scoring diff >= 3.9'
FROM champs
WHERE Point_Diff >= 3.9;


SELECT COUNT(Team) AS 'ORTG rank top 10'
FROM champs
WHERE ORTG_Rank <= 10;


SELECT COUNT(Team) AS 'DRTG rank top 12'
FROM champs
WHERE DRTG_Rank <= 12;


SELECT COUNT(Team) AS 'eFG rank top 6'
FROM champs
WHERE eFG_Rank <= 6;


SELECT COUNT(Team) AS 'OPP eFG% rank top 8'
FROM champs
WHERE OPP_eFG_Rank <= 8;


SELECT COUNT(Team) AS 'OPP eFG% rank top 15'
FROM champs
WHERE OPP_eFG_Rank <= 15;


SELECT COUNT(Team) AS '3P% rank top 10'
FROM champs
WHERE Three_perc_Rank <= 10;


SELECT COUNT(Team) AS '3P% rank top 15'
FROM champs
WHERE Three_perc_Rank <= 15;


SELECT COUNT(Team) AS '3P% rank top 20'
FROM champs
WHERE Three_perc_Rank <= 20;


SELECT COUNT(Team) AS '# All-Stars >= 1'
FROM champs
WHERE Num_All_Stars >= 1;


SELECT COUNT(Team) AS 'Home win perc >= .707'
FROM champs
WHERE Home_Win_perc >= .707;


SELECT COUNT(Team) AS 'Away win perc >= .500'
FROM champs
WHERE Away_Win_perc >= .500;


SELECT COUNT(Team) AS 'OPP PPG rank top 10'
FROM champs
WHERE OPP_PPG_Rank <= 10;


SELECT COUNT(Team) AS 'OPP PPG rank top 15'
FROM champs
WHERE OPP_PPG_Rank <= 15;


SELECT COUNT(Team) AS 'OPP PPG rank top 20'
FROM champs
WHERE OPP_PPG_Rank <= 20;


SELECT COUNT(Team) AS 'OPP PPG < League OPP PPG'
FROM champs
WHERE OPP_PPG < League_PPG;


SELECT COUNT(Team) AS 'OPP FG% rank top 5'
FROM champs
WHERE OPP_FG_perc_rank <= 5;


SELECT COUNT(Team) AS 'OPP FG% rank top 10'
FROM champs
WHERE OPP_FG_perc_rank <= 10;


SELECT COUNT(Team) AS 'OPP FG% < League OPP FG%'
FROM champs
WHERE OPP_FG_perc < League_FG_perc;


SELECT COUNT(Team) AS 'FT% > League FT%'
FROM champs
WHERE FT_perc > League_FT_perc;


SELECT COUNT(Team) AS 'TPG < League TPG'
FROM champs
WHERE TPG > League_TPG;


SELECT COUNT(Team) AS 'STL > League STL'
FROM champs
WHERE STL > League_STL;


SELECT COUNT(Team) AS 'DRB > League DRB'
FROM champs
WHERE DRB > League_DRB;


-- seeing if any teams fulfill every stat being evaluated
-- we use a WHERE statement with AND to determine if any teams fulfill every important stat that we evaluate

SELECT Team, Season
FROM champs
WHERE Win_perc >= 0.634 AND
Scoring_Diff_Rank <= 8 AND
Point_Diff >= 3.9 AND
ORTG_Rank <= 10 AND
eFG_Rank <= 6 AND
Three_perc_Rank <= 20 AND
--Three_perc_Rank <= 10 AND
DRTG_Rank <= 12 AND
OPP_eFG_Rank <= 15 AND
--OPP_eFG_Rank <= 8 AND
Num_All_Stars >= 1 AND
Home_Win_perc >= .707 AND
Away_Win_perc >= .500 AND
OPP_PPG < League_PPG AND
OPP_PPG_Rank <= 20 AND
--OPP_PPG_Rank <= 15 AND
--OPP_PPG_Rank <= 10 AND
OPP_FG_perc < League_FG_perc AND
OPP_FG_perc_rank <= 10 AND
--OPP_FG_perc_rank <= 5 AND
FT_perc > League_FT_perc AND
TPG > League_TPG AND
STL > League_STL AND
DRB > League_DRB;


-- selecting just the columns that are being evaluated to predict champ
-- this is used for qual file

SELECT Team, Season, Win_perc, Scoring_Diff_Rank, Point_Diff, ORTG_Rank, DRTG_Rank, 
	eFG_Rank, OPP_eFG_Rank, Three_perc_Rank, Num_All_Stars, Home_Win_perc, 
	Away_Win_perc, OPP_PPG_Rank, OPP_PPG, League_PPG, OPP_FG_perc_Rank, OPP_FG_perc,
	League_FG_perc, FT_perc, League_FT_perc, TPG, League_TPG, STL, League_STL, 
	DRB, League_DRB
FROM champs;


-- we use the above selection of data to create a new dataset (qual) that contains Y/N 
-- this indicates whether the teams have fulfilled each stat or not
-- analysis on the qual dataset is done in NBA_Champs_qual

