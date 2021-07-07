-- prediction
-- This code utilizes the baseline figures that were determined using the previous files to provide a prediction for this year's
-- NBA champion
-- Explanation for the determination of qualifications is explained throughout the code

---------- DETERMINING QUALIFYING TEAMS

-- open the dataset

SELECT * 
FROM reg_season;


-- get teams who qualify for each stat individually
-- we use the same code as in NBA_champs to determine the teams from the 2020-21 playoffs that fulfill each stat

SELECT Team AS 'win_perc_count'
FROM reg_season
WHERE Win_perc >= 0.634;


SELECT Team AS 'Scoring diff rank top 8'
FROM reg_season
WHERE Scoring_Diff_Rank <= 8;


SELECT Team AS 'Scoring diff >= 3.9'
FROM reg_season
WHERE Point_Diff >= 3.9;


SELECT Team AS 'ORTG rank top 10'
FROM reg_season
WHERE ORTG_Rank <= 10;


SELECT Team AS 'DRTG rank top 12'
FROM reg_season
WHERE DRTG_Rank <= 12;


SELECT Team AS 'eFG rank top 6'
FROM reg_season
WHERE eFG_Rank <= 6;


SELECT Team AS 'OPP eFG% rank top 8'
FROM reg_season
WHERE OPP_eFG_Rank <= 8;


SELECT Team AS 'OPP eFG% rank top 15'
FROM reg_season
WHERE OPP_eFG_Rank <= 15;


SELECT Team AS '3P% rank top 10'
FROM reg_season
WHERE Three_perc_Rank <= 10;


SELECT Team AS '3P% rank top 15'
FROM reg_season
WHERE Three_perc_Rank <= 15;


SELECT Team AS '3P% rank top 20'
FROM reg_season
WHERE Three_perc_Rank <= 20;


SELECT Team AS '# All-Stars >= 1'
FROM reg_season
WHERE Num_All_Stars >= 1;


SELECT Team AS 'Home win perc >= .707'
FROM reg_season
WHERE Home_Win_perc >= .707;


SELECT Team AS 'Away win perc >= .500'
FROM reg_season
WHERE Away_Win_perc >= .500;


SELECT Team AS 'OPP PPG rank top 10'
FROM reg_season
WHERE OPP_PPG_Rank <= 10;


SELECT Team AS 'OPP PPG rank top 15'
FROM reg_season
WHERE OPP_PPG_Rank <= 15;


SELECT Team AS 'OPP PPG rank top 20'
FROM reg_season
WHERE OPP_PPG_Rank <= 20;


SELECT Team AS 'OPP PPG < League OPP PPG'
FROM reg_season
WHERE OPP_PPG < League_PPG;


SELECT Team AS 'OPP FG% rank top 5'
FROM reg_season
WHERE OPP_FG_perc_rank <= 5;


SELECT Team AS 'OPP FG% rank top 10'
FROM reg_season
WHERE OPP_FG_perc_rank <= 10;


SELECT Team AS 'OPP FG% < League OPP FG%'
FROM reg_season
WHERE OPP_FG_perc < League_FG_perc;


SELECT Team AS 'FT% > League FT%'
FROM reg_season
WHERE FT_perc > League_FT_perc;


SELECT Team AS 'TPG < League TPG'
FROM reg_season
WHERE TPG > League_TPG;


SELECT Team AS 'STL > League STL'
FROM reg_season
WHERE STL > League_STL;


SELECT Team AS 'DRB > League DRB'
FROM reg_season
WHERE DRB > League_DRB;


-- seeing if any teams fulfill every stat being evaluated
-- we use more code from NBA_champs to determine if any teams fulfill all stats

SELECT Team
FROM reg_season
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

-- we do not have any teams that fulfill each 


-- selecting just the columns that are being evaluated to predict champ
-- this is used for qual_20-21 file

SELECT Team, Win_perc, Scoring_Diff_Rank, Point_Diff, ORTG_Rank, DRTG_Rank, 
	eFG_Rank, OPP_eFG_Rank, Three_perc_Rank, Num_All_Stars, Home_Win_perc, 
	Away_Win_perc, OPP_PPG_Rank, OPP_PPG, League_PPG, OPP_FG_perc_Rank, OPP_FG_perc,
	League_FG_perc, FT_perc, League_FT_perc, TPG, League_TPG, STL, League_STL, 
	DRB, League_DRB
FROM reg_season;

-- similarly to NBA_champs, we evaluate the fulfillment for each stat and create a dataset with Y/N values in each statistic
-- this indicates whether a team has fulfilled stats; we use the dataset (qual_20-21) for prediction below

	
------ QUAL
-- After evaluating the datasets and the fulfillment rates of the stats from the past 30 champions, I determined that 
-- the three qualifications that a team from the 2020-21 season must have to be champion are:
-- 1) Fulfills at least same number of stats as average number from past 30 champs (20.5 stats)
-- 2) Top 5 in number of stats fulfilled
-- 3) Fulfills each of top stats from past 30 champs (stats with at least 90% fulfillment rate)

-- we are able to determine which teams qualify using the code below

-- open the dataset

SELECT *
FROM 'qual_20-21';


-- create case statements to add 1 to total number of stats that each team fulfills
-- 25 possible Ys
-- we use code from NBA_Champs_qual to provide a total of the number of stats that each team from the 2020-21 regular season fulfills

SELECT Team,
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
FROM 'qual_20-21'
ORDER BY TotalY DESC;

-- this returns a list of the 2020-21 season's playoff teams and the number of stats (of the 25 possible) that they each fulfilled
-- in descending order

-- from this we are able to determine which teams have greater than the minimum number of stats (20.5) fulfilled, 
-- as well as the teams who are ranked in the top 5 of stats fulfilled


-- use results for calculating average of TotalY variable 
-- we use code from NBA_Champs_qual to find the average number of stats fulfilled for the 2020-21 regular season

WITH results AS 
(
	SELECT Team, 
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
	FROM 'qual_20-21'
)
SELECT AVG(TotalY) AS MeanY
FROM results;
-- might need to switch over to R/Python for this - doing it a smarter way


--determine which teams fulfill the 14 stats that >= 90% of each of past 30 champs fulfilled
-- we use conditional WHERE with AND to select the teams that fulfill each of the stats with over 90% fulfillment from
-- the past 30 champions

SELECT Team AS 'Top 90% Stats'
FROM 'qual_20-21'
WHERE Scoring_diff_Rank = 'Y' AND
OPP_eFG_Rank_15 = 'Y' AND
Away_Win_perc = 'Y' AND
Win_perc = 'Y' AND
DRTG_Rank = 'Y' AND
Num_All_Stars = 'Y' AND
Home_Win_perc = 'Y' AND
OPP_PPG_Rank_20 = 'Y' AND
OPP_PPG_Rank_15 = 'Y' AND
OPP_FG_perc = 'Y' AND
Point_diff = 'Y' AND
Three_perc_Rank_20 = 'Y' AND
OPP_PPG = 'Y' AND
DRB = 'Y';

-- this provides a list of the teams that have fulfilled each of the stats


-- determine which stats are fulfilled the most

-- probably a better way to do this than manually counting each stat
-- change to 'Y'

SELECT Team AS 'win_perc_total'
FROM 'qual_20-21'
WHERE Win_perc = 'Y';

SELECT Team AS 'win_perc_count'
FROM 'qual_20-21'
WHERE Win_perc = 'Y' 
	OR Win_perc = 'N';


SELECT Team AS 'Scoring_diff_Rank_total'
FROM 'qual_20-21'
WHERE Scoring_Diff_Rank = 'Y';

SELECT Team AS 'Scoring_diff_Rank_count'
FROM 'qual_20-21'
WHERE Scoring_Diff_Rank = 'Y'
	OR Scoring_diff_Rank = 'N';


SELECT Team AS 'Point_diff_total'
FROM 'qual_20-21'
WHERE Point_diff = 'Y';

SELECT Team AS 'Point_diff_count'
FROM 'qual_20-21'
WHERE Point_Diff = 'Y'
	OR Point_diff = 'N';


SELECT Team AS 'ORTG_total'
FROM 'qual_20-21'
WHERE ORTG_Rank = 'Y';

SELECT Team AS 'ORTG_count'
FROM 'qual_20-21'
WHERE ORTG_Rank = 'Y'
	OR ORTG_Rank = 'N';


SELECT Team AS 'DRTG_total'
FROM 'qual_20-21'
WHERE DRTG_Rank = 'Y';

SELECT Team AS 'DRTG_count'
FROM 'qual_20-21'
WHERE DRTG_Rank = 'Y'
	OR DRTG_Rank = 'N';


SELECT Team AS 'eFG_Rank_total'
FROM 'qual_20-21'
WHERE eFG_Rank = 'Y';

SELECT Team AS 'eFG_Rank_count'
FROM 'qual_20-21'
WHERE eFG_Rank = 'Y'
	OR eFG_Rank = 'N';


SELECT Team AS 'OPP_eFG_Rank_8_total'
FROM 'qual_20-21'
WHERE OPP_eFG_Rank_8 = 'Y';

SELECT Team AS 'OPP_eFG_Rank_8_count'
FROM 'qual_20-21'
WHERE OPP_eFG_Rank_8 = 'Y'
	OR OPP_eFG_Rank_8 = 'N';


SELECT Team AS 'OPP_eFG_Rank_15_total'
FROM 'qual_20-21'
WHERE OPP_eFG_Rank_15 = 'Y';

SELECT Team AS 'OPP_eFG_Rank_15_count'
FROM 'qual_20-21'
WHERE OPP_eFG_Rank_15 = 'Y'
	OR OPP_eFG_Rank_15 = 'N';


SELECT Team AS 'Three_perc_Rank_10_total'
FROM 'qual_20-21'
WHERE Three_perc_Rank_10 = 'Y';

SELECT Team AS 'Three_perc_Rank_10_count'
FROM 'qual_20-21'
WHERE Three_perc_Rank_10 = 'Y'
	OR Three_perc_Rank_10 = 'N';


SELECT Team AS 'Three_perc_Rank_15_total'
FROM 'qual_20-21'
WHERE Three_perc_Rank_15 = 'Y';

SELECT Team AS 'Three_perc_Rank_15_count'
FROM 'qual_20-21'
WHERE Three_perc_Rank_15 = 'Y'
	OR Three_perc_Rank_15 = 'N';


SELECT Team AS 'Three_perc_Rank_20_total'
FROM 'qual_20-21'
WHERE Three_perc_Rank_20 = 'Y';

SELECT Team AS 'Three_perc_Rank_20_count'
FROM 'qual_20-21'
WHERE Three_perc_Rank_20 = 'Y'
	OR Three_perc_Rank_20 = 'N';


SELECT Team AS 'Num_All_Stars_total'
FROM 'qual_20-21'
WHERE Num_All_Stars = 'Y';

SELECT Team AS 'Num_All_Stars_count'
FROM 'qual_20-21'
WHERE Num_All_Stars = 'Y'
	OR Num_All_Stars = 'N';


SELECT Team AS 'Home_Win_perc_total'
FROM 'qual_20-21'
WHERE Home_Win_perc = 'Y';

SELECT Team AS 'Home_Win_perc_count'
FROM 'qual_20-21'
WHERE Home_Win_perc = 'Y'
	OR Home_Win_perc = 'N';


SELECT Team AS 'Away_Win_perc_total'
FROM 'qual_20-21'
WHERE Away_Win_perc = 'Y';

SELECT Team AS 'Away_Win_perc_count'
FROM 'qual_20-21'
WHERE Away_Win_perc = 'Y'
	OR Away_Win_perc = 'N';


SELECT Team AS 'OPP_PPG_Rank_10_total'
FROM 'qual_20-21'
WHERE OPP_PPG_Rank_10 = 'Y';

SELECT Team AS 'OPP_PPG_Rank_10_count'
FROM 'qual_20-21'
WHERE OPP_PPG_Rank_10 = 'Y'
	OR OPP_PPG_Rank_10 = 'N';


SELECT Team AS 'OPP_PPG_Rank_15_total'
FROM 'qual_20-21'
WHERE OPP_PPG_Rank_15 = 'Y';

SELECT Team AS 'OPP_PPG_Rank_15_count'
FROM 'qual_20-21'
WHERE OPP_PPG_Rank_15 = 'Y'
	OR OPP_PPG_Rank_15 = 'N';


SELECT Team AS 'OPP_PPG_Rank_20_total'
FROM 'qual_20-21'
WHERE OPP_PPG_Rank_20 = 'Y';

SELECT Team AS 'OPP_PPG_Rank_20_count'
FROM 'qual_20-21'
WHERE OPP_PPG_Rank_20 = 'Y'
	OR OPP_PPG_Rank_20 = 'N';


SELECT Team AS 'OPP_PPG_total'
FROM 'qual_20-21'
WHERE OPP_PPG = 'Y';

SELECT Team AS 'OPP_PPG_count'
FROM 'qual_20-21'
WHERE OPP_PPG = 'Y'
	OR OPP_PPG = 'N';


SELECT Team AS 'OPP_FG_perc_Rank_5_total'
FROM 'qual_20-21'
WHERE OPP_FG_perc_rank_5 = 'Y';

SELECT Team AS 'OPP_FG_perc_Rank_5_count'
FROM 'qual_20-21'
WHERE OPP_FG_perc_rank_5 = 'Y'
	OR OPP_FG_perc_Rank_5 = 'N';


SELECT Team AS 'OPP_FG_perc_Rank_10_total'
FROM 'qual_20-21'
WHERE OPP_FG_perc_rank_10 = 'Y';

SELECT Team AS 'OPP_FG_perc_Rank_10_count'
FROM 'qual_20-21'
WHERE OPP_FG_perc_rank_10 = 'Y'
	OR OPP_FG_perc_Rank_10 = 'N';


SELECT Team AS 'OPP_FG_perc_total'
FROM 'qual_20-21'
WHERE OPP_FG_perc = 'Y';

SELECT Team AS 'OPP_FG_perc_count'
FROM 'qual_20-21'
WHERE OPP_FG_perc = 'Y'
	OR OPP_FG_perc = 'N';


SELECT Team AS 'FT_perc_total'
FROM 'qual_20-21'
WHERE FT_perc = 'Y';

SELECT Team AS 'FT_perc_count'
FROM 'qual_20-21'
WHERE FT_perc = 'Y'
	OR FT_perc = 'N';


SELECT Team AS 'TPG_total'
FROM 'qual_20-21'
WHERE TPG = 'Y';

SELECT Team AS 'TPG_count'
FROM 'qual_20-21'
WHERE TPG = 'Y'
	OR TPG = 'N';


SELECT Team AS 'STL_total'
FROM 'qual_20-21'
WHERE STL = 'Y';

SELECT Team AS 'STL_count'
FROM 'qual_20-21'
WHERE STL = 'Y'
	OR STL = 'N';


SELECT Team AS 'DRB_total'
FROM 'qual_20-21'
WHERE DRB = 'Y';

SELECT Team AS 'DRB_count'
FROM 'qual_20-21'
WHERE DRB = 'Y'
	OR DRB = 'N';
	

-- using this code, we are able to determine which teams qualify for prediction as the 2020-21 NBA champion, based on the
-- set minimum requirements
-- explanation and further details are provided in the written report 
	
	