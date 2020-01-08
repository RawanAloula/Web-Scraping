

#load the page
nets1819 <- readLines("http://www.espn.com/nba/team/schedule/_/name/bkn",warn = FALSE) 

# take a lot at it 
head(nets1819,15)
tail(nets1819,20)
nets1819[100:108]


# number of lines 
length(nets1819)

# number of characters 
nchar(nets1819)
total_char <- sum(nchar(nets1819))

# maximum number of characters in single line
max_char <- max(nchar(nets1819))



# Extract date of game 
pattern1 <- "[A-Z][a-z]{2},\\s[A-Z][a-z]{2}\\s[0-9]+"

grep(pattern1, nets1819)   # which lines?
regmatches(nets1819, regexpr(pattern1, nets1819))   # check first match 

date <- regmatches(nets1819[65], gregexpr(pattern1, nets1819[65]))   # get all matches from the line 

date <- unlist(date)
length(date)   # check length 
head(date,6)



# Extract time of the game 
pattern2 <- "[0-9]:[0-9]{2}\\sPM"      

grep(pattern2, nets1819)   # which lines?
regmatches(nets1819, regexpr(pattern2, nets1819))   # check first match 

Time <- regmatches(nets1819[65], gregexpr(pattern2, nets1819[65]))   # get all matches from the line 

Time <- unlist(Time)
length(Time)   # check length 
head(Time,6)

time <- c(rep(NA,67), Time)    #for the final datafram
head(time,6)
length(time)


# Is the game at home or away? (this is schudaled as @ or vs where @ = away, vs = home)
pattern3 <- ":[[:punct:]]@|vs[[:punct:]],"  

grep(pattern3, nets1819)   # which lines?
regmatches(nets1819, regexpr(pattern3, nets1819))   # check first match 

HOME <- regmatches(nets1819[66], gregexpr(pattern3, nets1819[66]))   # get all matches from the line 

HOME <- unlist(HOME)
length(HOME)   # check length 
tail(HOME,15)

home1 <- ifelse(HOME == ":\"@" , 0, 1)
head(home1,6)

length(home1)

home <- c(home1[16:82], home1[1:15]) 
length(home)
head(home,6)
tail(home,6)



# Extract opponent
pattern4 <- "title=\"[^0-9]+\""
  
grep(pattern4, nets1819)   # which lines?
regmatches(nets1819, regexpr(pattern4, nets1819))   # check first match 

Opponent <- regmatches(nets1819[65], gregexpr(pattern4, nets1819[65]))   # get all matches from the line 

Opponent <- unlist(Opponent)
length(Opponent)   # check length 

pattern4.1  <- "[A-Z][a-z]*\\s[A-Z][a-z]*|[A-Z][A-Z]*[a-z]*"

grep(pattern4.1, Opponent) 
opponent<- regmatches(Opponent, regexpr(pattern4.2, Opponent))   # check first match 
length(opponent)
head(opponent,6)


# Create a data frame 
DataFram <- data.frame(date, time, opponent, home, stringsAsFactors = FALSE)
head(DataFram)
