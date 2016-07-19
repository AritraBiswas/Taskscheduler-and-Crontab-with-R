time<-Sys.time();
df<-data.frame(time);
names(df)<-"SYSTEM_TIME";
write.csv(df,"systemtime.csv");
head(df)