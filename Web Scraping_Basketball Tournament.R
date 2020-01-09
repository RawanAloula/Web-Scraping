# Basketball_Tournament


# Setup
library (rvest)
Page <- read_html("https://en.wikipedia.org/wiki/2019_NCAA_Division_I_Men%27s_Basketball_Tournament")


# Extract text in the first header of the page
Page %>%
  html_nodes ("h1") %>%
  html_text()


# Find all links listed on the page. 
Page %>%
  html_nodes("a") %>% 
  html_attr("href") %>%
  grep("http", ., value=TRUE) %>%
  length() 


# Scrape all tables 
Tbls <- Page %>%
  html_nodes ("table") %>%
  html_table (fill = TRUE) %>%      #length(Tbls) = 57  
  .[c(3,5,6,7,8,53)]   #select the valid ones only  after invistigating using str(Tbls)
  
length(Tbls)

# first 10 rows of the first table.
first_table <- Tbls[[1]]

head(first_table,10)


# Scrape all paragraphs
Prg <- Page %>%
  html_nodes ("p") %>%
  html_text()

length (Prg)             # this dosent look right. 



library(stringr)

Prgtxt <- Page %>%
  html_nodes ("p") %>%
  html_text () %>%
  
  # Cleaning 
  str_replace_all (pattern = "\n", replacement = " ") %>%
  str_replace_all (pattern = "[\\^]", replacement = " ") %>%
  str_replace_all (pattern = "\"", replacement = " ") %>%
  str_trim (side = "both") %>%                         # remove white space
  grep("^.{0,100}$",., value = TRUE, invert = TRUE)    # only return lines with at least 100 characters (qualifies for paragraph) 

paste("The true number of paragraph is = ",length(Prgtxt))



# Extract the text 
Prgtxt[1:10]


# Return paragraphs with the word “championship” 
grep("championship", Prgtxt, value = TRUE, ignore.case = TRUE)




#The top right side of the webpage has a box had a title the reads “2019 NCAA Division I”

# on Safari use Develop -> Show Web inspector to find the following corresponding html text and copy it here.  
#<th colspan="2" style="text-align:center;font-size:125%;font-weight:bold;font-size:100%">2019 NCAA Division I<br>Men's Basketball Tournament</th>
# the node name "th" is used to target that text

Page %>%
  html_node("th") %>%
  html_text(.) %>%
  gsub("Men's Basketball Tournament", replacement = "", .)


  