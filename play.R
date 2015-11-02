library(pitchRx)
library(dplyr)
library(RSQLite)

setwd("C:/Users/Bryan/Documents/GitHub/Baseball")

batterID <- c("408234") #Cabrera's batting ID is 408234.
data(gids, package = "pitchRx")
det13 <- gids[grepl("det", gids) & grepl("2013", gids)] #selection criteria for detroit, 2013
my_db <-  src_sqlite("pitchRx.sqlite3", create = TRUE)
scrape(game.ids = det13[], connect = my_db$con) #runs pitchRx scrape for det13 game.ids criteria

data <- filter(tbl(my_db, 'atbat'), batter==batterID) #creates query for batterID
pitches <- tbl(my_db, 'pitch') #crates query from pitch data
Cabrera13 = inner_join(pitches, data, by = c('num', 'gameday_link')) #joins atbat data with pitch data
df_Cab13=collect(Cabrera13) #converts to table and dataframe

save.image("C:\\Users\\Bryan\\Documents\\GitHub\\Baseball\\v01-Cabrera") #save image of workspace for restore

df_Cab13 = df_Cab13[which(is.na(df_Cab13$z0)==FALSE),] #Remove missing PitchFX data

save.image("C:\\Users\\Bryan\\Documents\\GitHub\\Baseball\\v02-Cabrera") #save image of workspace for restore


#Check for NA in columns
for (ii in 1:ncol(df_Cab13) ) {
cat(sum(is.na(df_Cab13[,ii])),", ",names(df_Cab13[,ii]),", ",ii,"\n")
#table(df_Cab13[,ii], useNA = "ifany")
}
