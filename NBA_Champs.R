library(dplyr)
library(ggplot2)
library(readxl)
library(waffle)
library(stringr)
library(tidyverse)

setwd("/Users/alexcreighton/Desktop/Personal Projects/NBA Champs")
NBA_champs<-read.csv("NBA Champs Data.csv")
qual<-read.csv("qual.csv")


#create new table of stats from NBA_champs in per game figures
#### CHAMPS 
PG_champ <- data.frame(NBA_champs$FGA, NBA_champs$Attempted.Threes,
                       NBA_champs$FTA, NBA_champs$ORB, NBA_champs$DRB,
                       NBA_champs$TRB, NBA_champs$STL, NBA_champs$TPG,
                       NBA_champs$PTS)

PG_champ <- PG_champ / NBA_champs$Games

PG_champ$season <- NBA_champs$Season


#### LEAGUE & OPPONENT 
opp_PPG <- NBA_champs$OPP.PTS / NBA_champs$Games


PG_league <- data.frame(NBA_champs$League.FGA, NBA_champs$League.3PA,
                        NBA_champs$League.FTA, NBA_champs$League.ORB,
                        NBA_champs$League.DRB, NBA_champs$League.TRB,
                        NBA_champs$League.STL, NBA_champs$League.TOV,
                        NBA_champs$League.PTS)

PG_league <- (PG_league / NBA_champs$League.Games) / 2 #divide by 2 because League.Games contains combined totals for both teams per game

PG_league$season <- NBA_champs$Season


#### REST OF STATS (non-per-game)
non_PG <- data.frame(NBA_champs$Team, NBA_champs$Season, NBA_champs$Games, NBA_champs$Record,
                     NBA_champs$Wins, NBA_champs$Losses, NBA_champs$Home.Wins,
                     NBA_champs$Home.Losses, NBA_champs$Playoff.Seed, NBA_champs$Point.Diff..per.48mins.,
                     NBA_champs$Scoring.Diff.Rank, NBA_champs$Off.Rtg.Rank, NBA_champs$Def.Rtg.Rank,
                     NBA_champs$eFG., NBA_champs$eFG..Rank, NBA_champs$OPP.eFG..Rank, 
                     NBA_champs$Off.Rtg, NBA_champs$Def.Rtg, NBA_champs$FG., NBA_champs$Percentage.Threes, 
                     NBA_champs$Percentage.Threes.Rank, NBA_champs$FT., NBA_champs$X..All.Stars, 
                     NBA_champs$OPP...All.Stars, NBA_champs$OPP.PTS.Rank, NBA_champs$OPP.FG., 
                     NBA_champs$OPP.FG..Rank, NBA_champs$League.ORTG, NBA_champs$League.FG., 
                     NBA_champs$League.3P., NBA_champs$League.FT.)

names(non_PG)[names(non_PG)=="NBA_champs.Season"] <- "season"


#### TABLE
#per game stats
per_game <- merge(PG_champ, PG_league, by='season')

#combine per game stats with all other stats
total <- merge(per_game, non_PG, by='season')
total$OPP_PPG <- opp_PPG

#rename columns
oldnames = c(
  'season', 'NBA_champs.FGA', 'NBA_champs.Attempted.Threes', 'NBA_champs.FTA', 
  'NBA_champs.ORB', 'NBA_champs.DRB', 'NBA_champs.TRB', 'NBA_champs.STL', 
  'NBA_champs.TPG', 'NBA_champs.PTS', 'NBA_champs.League.FGA', 'NBA_champs.League.3PA', 
  'NBA_champs.League.FTA', 'NBA_champs.League.ORB', 'NBA_champs.League.DRB', 
  'NBA_champs.League.TRB', 'NBA_champs.League.STL', 'NBA_champs.League.TOV', 
  'NBA_champs.League.PTS', 'NBA_champs.Team', 'NBA_champs.Games', 'NBA_champs.Record', 
  'NBA_champs.Wins', 'NBA_champs.Losses', 'NBA_champs.Home.Wins', 'NBA_champs.Home.Losses', 
  'NBA_champs.Playoff.Seed', 'NBA_champs.Point.Diff..per.48mins.', 
  'NBA_champs.Scoring.Diff.Rank', 'NBA_champs.Off.Rtg.Rank', 'NBA_champs.Def.Rtg.Rank', 
  'NBA_champs.eFG.', 'NBA_champs.eFG..Rank', 'NBA_champs.OPP.eFG..Rank', 
  'NBA_champs.Off.Rtg', 'NBA_champs.Def.Rtg', 'NBA_champs.FG.', 
  'NBA_champs.Percentage.Threes', 'NBA_champs.Percentage.Threes.Rank', 'NBA_champs.FT.', 
  'NBA_champs.X..All.Stars', 'NBA_champs.OPP...All.Stars', 'NBA_champs.OPP.PTS.Rank', 
  'NBA_champs.OPP.FG.', 'NBA_champs.OPP.FG..Rank', 'NBA_champs.League.ORTG', 
  'NBA_champs.League.FG.', 'NBA_champs.League.3P.', 'NBA_champs.League.FT.', 'OPP_PPG'
)

newnames = c(
    'Season', 'FGA', '3PA', 'FTA', 'ORB', 'DRB', 'TRB', 'STL', 'TPG', 'PPG', 
    'League_FGA', 'League_3PA', 'League_FTA', 'League_ORB', 'League_DRB', 'League_TRB', 'League_STL', 
    'League_TPG', 'League_PPG', 'Team', 'Games', 'Record', 'Wins', 'Losses', 'Home_Wins', 'Home_Losses', 
    'Playoff_Seed', 'Point_Diff', 'Scoring_Diff_Rank', 'ORTG_Rank', 'DRTG_Rank', 'eFG_perc', 
    'eFG_Rank', 'OPP_eFG_Rank', 'ORTG', 'DRTG', 'FG_perc', '3P_perc', '3P_perc_Rank', 'FT_perc', 
    'Num_All_Stars', 'OPP_Num_All_Stars', 'OPP_PPG_Rank', 'OPP_FG_perc', 'OPP_FG_perc_Rank', 
    'League_ORTG', 'League_FG_perc', 'League_3P_perc', 'League_FT_perc', 'OPP_PPG'
)

colnames(total) <- newnames

#calculate win %s
total$Win_perc <- total$Wins/total$Games
total$Home_Win_perc <- total$Home_Wins / (total$Home_Wins+total$Home_Losses)
total$Away_Win_perc <- (total$Wins - total$Home_Wins) / (total$Games - (total$Home_Wins+total$Home_Losses))


#reorder columns
total <- total[c(
  'Team', 'Season', 'Games', 'Record', 'Wins', 'Losses', 'Win_perc', 'Home_Wins', 'Home_Losses',
  'Home_Win_perc', 'Away_Win_perc', 'Playoff_Seed','Point_Diff', 'Scoring_Diff_Rank', 'ORTG', 
  'ORTG_Rank', 'League_ORTG', 'DRTG', 'DRTG_Rank', 'PPG', 'League_PPG', 'OPP_PPG', 'OPP_PPG_Rank', 
  'eFG_perc', 'eFG_Rank', 'OPP_eFG_Rank', 'FGA', 'FG_perc', 'League_FGA', 'League_FG_perc', 
  'OPP_FG_perc', 'OPP_FG_perc_Rank', '3PA', '3P_perc', '3P_perc_Rank', 'League_3PA', 'League_3P_perc', 
  'FTA', 'FT_perc', 'League_FTA', 'League_FT_perc', 'ORB', 'DRB', 'TRB', 'League_ORB', 'League_DRB', 
  'League_TRB', 'STL', 'League_STL', 'TPG', 'League_TPG', 'Num_All_Stars', 'OPP_Num_All_Stars'
)]



#descriptive stats of per game figures
summary(total)

summary_stat <- do.call(cbind, lapply(total, summary))

summary_stats <- data.frame(unclass(summary(total)), check.names = FALSE, stringsAsFactors = FALSE)


#plots
p <- ggplot(data = total, aes(x=Team, y='3P_perc')) + 
  geom_boxplot(aes(fill='3P_perc'))
p + facet_wrap( ~ Team, scales="free")






