---
title: "Shopping made easy with RPushbullet"
layout: post
tags: ["R","RPushbullet"]
---

Recently [Dirk Eddelbuettel](http://dirk.eddelbuettel.com/) released the new R package [RPushbullet](http://dirk.eddelbuettel.com/code/rpushbullet.html) to allow for pushing via [pushbullet](https://www.pushbullet.com/) from R. This package is great if you want to know when some long slow running model has finished going through all the loops etc.. However, recently I have been trying to buy new forks for my mountain bike off a fourm over on [single track](http://singletrackworld.com/forum/forum/classifieds). The great thing about single track sales is the price but there is one slight problem. People generally get in quick and snap up the bargins well before I get a chance. This is where RPushbullet comes in to save me.

By combining the XML, stringr and the RPushBullet packages I can download the titles of all the recent posts and search for the key word of the shocks I want. If the script finds anything interesting it will push it to my phone using RPushbullet.

The script is below. It also includes a log of post titles that have already been sent to my phone to ensure I don't get flooded repetitively.


{% highlight r %}
# Load the required packages
library(XML)
library(RPushbullet)
library(stringr)
# Check to see if there is a log file on the system and load it.
if(sum(str_detect(dir("/Users/USERNAME/"), "singletrack.Rdata"))==0){
  log <- ""
} else {
  load("/Users/USERNAME/singletrack.Rdata")
}
# assign the forums url
theurl <- "http://singletrackworld.com/forum/forum/classifieds"
# rip the forum titles as a table
tables <- readHTMLTable(theurl)
# reformat the table structure
post_titles <- as.character(tables[[1]][,1])

# Create an index of posts that match what I am after
index <- str_detect(tolower(post_titles), "rockshox")
if(sum(index)&gt;0){
  # Subset the posts that match the keyword
  posts <- (1:length(index))[index==1]
  # Loop through the matches and check to see if they are in the log. 
  # if not then push it to the phone, and add it to the log file.
  for(i in posts){
    if(!any(str_detect(tolower(log), tolower(post_titles[i])))){
      log <- c(log, tolower(post_titles[i]))
      pbPost("link", post_titles[i], url="http://singletrackworld.com/forum/forum/classifieds")
    }
  }
 # Update the log file for the next round. 
  save(log, file="/Users/USERNAME/singletrack.Rdata")
}
{% endhighlight %}

With the script completed and saved as something like searchSingleTrack.R I can now use crontab on my mac to get the script to run every 30 minutes. I didn't have any previous crontab jobs up and running so I had to set everything up from scratch. This is all fairly easy stuff. In a terminal window:

```bash
sudo touch /etc/crontab
crontab -e
```

This will open up the crontab file. Within this you need to add the following (press i [for insert]):

```bash
0,30 * * * * Rscript /Users/USERNAME/searchSingleTrack.R
```

That should be it (press ESC then :w [for write] then :q [for quit]). The R script will now automatically check the forum every 30 minutes and if it finds anything push it to my phone.
