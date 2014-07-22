getwd()
setwd("/home/brian/Projects/Coursera/Explore/")



myapp = oauth_app("github",
                  key="7e5a097f25bc9170c7e0",secret="270159fac5e3452e2482de38980913ce88a45e6c")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.github.com/users/jtleek/repos", sig)


##test for obtaining data from seattle colleges:
install.packages("httr")
library(httr)


pg1<-GET("https://inside.seattlecolleges.com/enrollment/content/displayReport.aspx?col=063&q=B452&qn=FALL%2014&nc=false&in=&cr=",authenticate("bholt","fuckD1strict!"))
objects(pg1)

pg1$headers


library(sqldf)


