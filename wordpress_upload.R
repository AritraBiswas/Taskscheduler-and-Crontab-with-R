library(XMLRPC)
library(RWordPress)
library(knitr)
options(WordpressLogin = c(username = "password"), WordpressURL = "yourpath/xmlrpc.php")
knit2wp("C:\\Users\\Aritra\\Documents\\R\\Taskscheduler-and-Crontab-with-R\\Taskscheduler_Crontab.Rmd", title = 'Taskscheduler and Crontab with R', publish = FALSE)