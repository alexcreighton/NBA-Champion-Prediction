-- NBA_Champs_qual
-- This file is used to understand the percentage of the past 30 champions that have qualified for important stats
-- This provides an insight into the number of stats that teams tend to fulfill, to provide a baseline for prediction

------ QUAL

-- open the dataset

SELECT *
FROM qual;


-- create case statements to add 1 to total number of stats that each team fulfills
-- 25 possible Ys
-- we use SELECT and CASE to provide a running total of qualified stats for each team

SELECT Team, Season, 
	(CASE WHEN Win_perc = 'Y' THEN 1 ELSE 0 END 
	+ CASE WHEN Scoring_diff_Rank = 'Y' THEN 1 ELSE 0 END 
	+ CASE WHEN Point_diff = 'Y' THEN 1 ELSE 0 END 
	+ CASE WHEN ORTG_Rank = 'Y' THEN 1 ELSE 0 END 
	+ CASE WHEN DRTG_Rank = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN eFG_Rank = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_eFG_Rank_8 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_eFG_Rank_15 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN Three_perc_Rank_10 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN Three_perc_Rank_15 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN Three_perc_Rank_20 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN Num_All_Stars = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN Home_Win_perc = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN Away_Win_perc = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_PPG_Rank_10 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_PPG_Rank_15 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_PPG_Rank_20 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_PPG = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_FG_perc_Rank_5 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_FG_perc_Rank_10 = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN OPP_FG_perc = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN FT_perc = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN TPG = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN STL = 'Y' THEN 1 ELSE 0 END
	+ CASE WHEN DRB = 'Y' THEN 1 ELSE 0 END) AS TotalY -- end result is variable TotalY which displays the number of stats fulfilled by each team
FROM qual;

-- use results for calculating average of TotalY variable 
-- we use a similar function as above to calculate the average number of stats that the past 30 champions have fulfilled

WITH results AS 
(
	SELECT Team, Season, 
		(CASE WHEN Win_perc = 'Y' THEN 1 ELSE 0 END 
		+ CASE WHEN Scoring_diff_Rank = 'Y' THEN 1 ELSE 0 END 
		+ CASE WHEN Point_diff = 'Y' THEN 1 ELSE 0 END 
		+ CASE WHEN ORTG_Rank = 'Y' THEN 1 ELSE 0 END 
		+ CASE WHEN DRTG_Rank = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN eFG_Rank = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_eFG_Rank_8 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_eFG_Rank_15 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN Three_perc_Rank_10 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN Three_perc_Rank_15 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN Three_perc_Rank_20 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN Num_All_Stars = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN Home_Win_perc = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN Away_Win_perc = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_PPG_Rank_10 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_PPG_Rank_15 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_PPG_Rank_20 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_PPG = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_FG_perc_Rank_5 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_FG_perc_Rank_10 = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN OPP_FG_perc = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN FT_perc = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN TPG = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN STL = 'Y' THEN 1 ELSE 0 END
		+ CASE WHEN DRB = 'Y' THEN 1 ELSE 0 END) AS TotalY
	FROM qual
)
SELECT AVG(TotalY) AS MeanY
FROM results;
-- might need to switch over to R/Python for this - doing it a smarter way


-- determine which stats are fulfilled the most
-- we use the below code to find the total count of fulfilled stats and the total count of each stat overall
-- this will be used to calculate the percentage of each stat that is fulfilled by the past 30 champions

-- probably a better way to do this than manually counting each stat
-- change to 'Y'

SELECT COUNT(Team) AS 'win_perc_total'
FROM qual
WHERE Win_perc = 'Y';

SELECT COUNT(Team) AS 'win_perc_count'
FROM qual
WHERE Win_perc = 'Y' 
	OR Win_perc = 'N';


SELECT COUNT(Team) AS 'Scoring_diff_Rank_total'
FROM qual
WHERE Scoring_Diff_Rank = 'Y';

SELECT COUNT(Team) AS 'Scoring_diff_Rank_count'
FROM qual
WHERE Scoring_Diff_Rank = 'Y'
	OR Scoring_diff_Rank = 'N';


SELECT COUNT(Team) AS 'Point_diff_total'
FROM qual
WHERE Point_diff = 'Y';

SELECT COUNT(Team) AS 'Point_diff_count'
FROM qual
WHERE Point_Diff = 'Y'
	OR Point_diff = 'N';


SELECT COUNT(Team) AS 'ORTG_total'
FROM qual
WHERE ORTG_Rank = 'Y';

SELECT COUNT(Team) AS 'ORTG_count'
FROM qual
WHERE ORTG_Rank = 'Y'
	OR ORTG_Rank = 'N';


SELECT COUNT(Team) AS 'DRTG_total'
FROM qual
WHERE DRTG_Rank = 'Y';

SELECT COUNT(Team) AS 'DRTG_count'
FROM qual
WHERE DRTG_Rank = 'Y'
	OR DRTG_Rank = 'N';


SELECT COUNT(Team) AS 'eFG_Rank_total'
FROM qual
WHERE eFG_Rank = 'Y';

SELECT COUNT(Team) AS 'eFG_Rank_count'
FROM qual
WHERE eFG_Rank = 'Y'
	OR eFG_Rank = 'N';


SELECT COUNT(Team) AS 'OPP_eFG_Rank_8_total'
FROM qual
WHERE OPP_eFG_Rank_8 = 'Y';

SELECT COUNT(Team) AS 'OPP_eFG_Rank_8_count'
FROM qual
WHERE OPP_eFG_Rank_8 = 'Y'
	OR OPP_eFG_Rank_8 = 'N';


SELECT COUNT(Team) AS 'OPP_eFG_Rank_15_total'
FROM qual
WHERE OPP_eFG_Rank_15 = 'Y';

SELECT COUNT(Team) AS 'OPP_eFG_Rank_15_count'
FROM qual
WHERE OPP_eFG_Rank_15 = 'Y'
	OR OPP_eFG_Rank_15 = 'N';


SELECT COUNT(Team) AS 'Three_perc_Rank_10_total'
FROM qual
WHERE Three_perc_Rank_10 = 'Y';

SELECT COUNT(Team) AS 'Three_perc_Rank_10_count'
FROM qual
WHERE Three_perc_Rank_10 = 'Y'
	OR Three_perc_Rank_10 = 'N';


SELECT COUNT(Team) AS 'Three_perc_Rank_15_total'
FROM qual
WHERE Three_perc_Rank_15 = 'Y';

SELECT COUNT(Team) AS 'Three_perc_Rank_15_count'
FROM qual
WHERE Three_perc_Rank_15 = 'Y'
	OR Three_perc_Rank_15 = 'N';


SELECT COUNT(Team) AS 'Three_perc_Rank_20_total'
FROM qual
WHERE Three_perc_Rank_20 = 'Y';

SELECT COUNT(Team) AS 'Three_perc_Rank_20_count'
FROM qual
WHERE Three_perc_Rank_20 = 'Y'
	OR Three_perc_Rank_20 = 'N';


SELECT COUNT(Team) AS 'Num_All_Stars_total'
FROM qual
WHERE Num_All_Stars = 'Y';

SELECT COUNT(Team) AS 'Num_All_Stars_count'
FROM qual
WHERE Num_All_Stars = 'Y'
	OR Num_All_Stars = 'N';


SELECT COUNT(Team) AS 'Home_Win_perc_total'
FROM qual
WHERE Home_Win_perc = 'Y';

SELECT COUNT(Team) AS 'Home_Win_perc_count'
FROM qual
WHERE Home_Win_perc = 'Y'
	OR Home_Win_perc = 'N';


SELECT COUNT(Team) AS 'Away_Win_perc_total'
FROM qual
WHERE Away_Win_perc = 'Y';

SELECT COUNT(Team) AS 'Away_Win_perc_count'
FROM qual
WHERE Away_Win_perc = 'Y'
	OR Away_Win_perc = 'N';


SELECT COUNT(Team) AS 'OPP_PPG_Rank_10_total'
FROM qual
WHERE OPP_PPG_Rank_10 = 'Y';

SELECT COUNT(Team) AS 'OPP_PPG_Rank_10_count'
FROM qual
WHERE OPP_PPG_Rank_10 = 'Y'
	OR OPP_PPG_Rank_10 = 'N';


SELECT COUNT(Team) AS 'OPP_PPG_Rank_15_total'
FROM qual
WHERE OPP_PPG_Rank_15 = 'Y';

SELECT COUNT(Team) AS 'OPP_PPG_Rank_15_count'
FROM qual
WHERE OPP_PPG_Rank_15 = 'Y'
	OR OPP_PPG_Rank_15 = 'N';


SELECT COUNT(Team) AS 'OPP_PPG_Rank_20_total'
FROM qual
WHERE OPP_PPG_Rank_20 = 'Y';

SELECT COUNT(Team) AS 'OPP_PPG_Rank_20_count'
FROM qual
WHERE OPP_PPG_Rank_20 = 'Y'
	OR OPP_PPG_Rank_20 = 'N';


SELECT COUNT(Team) AS 'OPP_PPG_total'
FROM qual
WHERE OPP_PPG = 'Y';

SELECT COUNT(Team) AS 'OPP_PPG_count'
FROM qual
WHERE OPP_PPG = 'Y'
	OR OPP_PPG = 'N';


SELECT COUNT(Team) AS 'OPP_FG_perc_Rank_5_total'
FROM qual
WHERE OPP_FG_perc_rank_5 = 'Y';

SELECT COUNT(Team) AS 'OPP_FG_perc_Rank_5_count'
FROM qual
WHERE OPP_FG_perc_rank_5 = 'Y'
	OR OPP_FG_perc_Rank_5 = 'N';


SELECT COUNT(Team) AS 'OPP_FG_perc_Rank_10_total'
FROM qual
WHERE OPP_FG_perc_rank_10 = 'Y';

SELECT COUNT(Team) AS 'OPP_FG_perc_Rank_10_count'
FROM qual
WHERE OPP_FG_perc_rank_10 = 'Y'
	OR OPP_FG_perc_Rank_10 = 'N';


SELECT COUNT(Team) AS 'OPP_FG_perc_total'
FROM qual
WHERE OPP_FG_perc = 'Y';

SELECT COUNT(Team) AS 'OPP_FG_perc_count'
FROM qual
WHERE OPP_FG_perc = 'Y'
	OR OPP_FG_perc = 'N';


SELECT COUNT(Team) AS 'FT_perc_total'
FROM qual
WHERE FT_perc = 'Y';

SELECT COUNT(Team) AS 'FT_perc_count'
FROM qual
WHERE FT_perc = 'Y'
	OR FT_perc = 'N';


SELECT COUNT(Team) AS 'TPG_total'
FROM qual
WHERE TPG = 'Y';

SELECT COUNT(Team) AS 'TPG_count'
FROM qual
WHERE TPG = 'Y'
	OR TPG = 'N';


SELECT COUNT(Team) AS 'STL_total'
FROM qual
WHERE STL = 'Y';

SELECT COUNT(Team) AS 'STL_count'
FROM qual
WHERE STL = 'Y'
	OR STL = 'N';


SELECT COUNT(Team) AS 'DRB_total'
FROM qual
WHERE DRB = 'Y';

SELECT COUNT(Team) AS 'DRB_count'
FROM qual
WHERE DRB = 'Y'
	OR DRB = 'N';

-- we use the results from this code to create a dataset (qual_counts) that calculates the percentage fulfillment rate for each stat
	
	
------ QUAL COUNTS
-- using the qual_counts dataset we determine which statistics have the highest fulfillment by the past 30 champions
-- this will be used to determine the "most important" of these stats to use for prediction

-- open the dataset

SELECT *
FROM qual_counts;


-- using SELECT and WHERE, we are able to find every stat that is fulfilled over a certain rate

SELECT *
FROM qual_counts
WHERE percentage >= 0.95;

SELECT *
FROM qual_counts
WHERE percentage >= 0.90
ORDER BY percentage DESC;

SELECT *
FROM qual_counts
WHERE percentage >= 0.85
ORDER BY percentage DESC;

SELECT *
FROM qual_counts
WHERE percentage >= 0.80;

-- using these results, we determine which minimum percentage level of fulfillment we want for prediction
-- stats for the 2020-21 regular season are compiled and utilized in the prediction file to determine which of this
-- year's teams qualify to win

