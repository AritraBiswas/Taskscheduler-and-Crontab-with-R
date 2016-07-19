Taskscheduler and Crontab with R
========================================================
author: Aritra Biswas 
date: 07/19/2016
autosize: true

Taskscheduler and Crontab with R
========================================================

From the point of view of a data scientist this is important to explore a phenomena over time. While conducting an experiment with social networking sites websites I've found these beautiful tools which can run r scripts automatically after a per specified time by the user. Here is a tutorial explaining task scheduling process for Windows 10 and Linux Debian Jessie (This is the latest OS for Raspberry Pi).


For windows:
========================================================

To demonstrate this process we need a small R script which will be executed after specific time (i.e. every 5 minutes) on windows using the dufault application Task scheduler. For demonstration purpose we are considering this code:


```r
time<-Sys.time();
df<-data.frame(time);
names(df)<-"SYSTEM_TIME";
write.csv(df,"systemtime.csv");
head(df)
```
Let us save the above code a file called systime.R. Note down the path of the folder which contains this file. In my case this case the file is saved the file in __`C:\Users\Aritra\Desktop`__.

========================================================
Now go to __Control Panel-> Administrative Tools -> Task Scheduler__.

Select Create Basic Task, provide a name and a description of the task so that this can be easily recognized later. Click on next.

![](http://aritrabiswas.in/wp-content/uploads/2016/07/1.jpg)
 
========================================================
Select __One time__ and click on next. This will create a one time job initially. Later on we will change the task so that it will be executed after a prespecified time. The time lag on which the script be executated (i.e. once a day, week or month) will be specified later.
![](http://aritrabiswas.in/wp-content/uploads/2016/07/2.jpg)

========================================================
__Select the date and time__ when the task will be executed for the first time. This is recommended to set the time a few minutes ahead from current time.

![](http://aritrabiswas.in/wp-content/uploads/2016/07/3.jpg)

========================================================
Under Action choose __Start a program, click on next__. 

![](http://aritrabiswas.in/wp-content/uploads/2016/07/4.jpg)

========================================================
Now, a .bat file has to be created. It will be executed from command prompt in windows. The analog of this .bat file in linux is .sh. Write the following lines of code in a notepad file: 

__`@echo off`__

__`R CMD BATCH C:\Users\Aritra\systime.R`__

Save this file as a .bat file. Here it is saved as systime.bat. To check whether this .bat file is working properly or not, one may simply click on the .bat file. This should execute the R script from command prompt and generate a .csv and a .Rout file. The.csv file should contain the system time of execusion of the R script and .Rout file should contain all the text printed out in R terminal. This may be useful to diagnose error if there is any. 

========================================================
Here the path __`"C:\Users\Aritra\systime.R"`__ is the location of my script, this path must be change with the file location of your r script.

![](http://aritrabiswas.in/wp-content/uploads/2016/07/5.jpg)

========================================================

In task scheduler, __Browse the .bat file__ in the field of Program Script. Click Next.

![](http://aritrabiswas.in/wp-content/uploads/2016/07/6.jpg)

========================================================

__Check in Open the Properties dialog__. Click on Finish.  

![](http://aritrabiswas.in/wp-content/uploads/2016/07/7.jpg)

========================================================
Under Gernel tab, __check in Run with highest priviliges__. 

![](http://aritrabiswas.in/wp-content/uploads/2016/07/8.jpg)

========================================================
__Change and shift to Triggers tab. Select task and click on edit.__

![](http://aritrabiswas.in/wp-content/uploads/2016/07/9.jpg)

========================================================
Check in Repeat task every and select duration. When you click on a time lag then you can simply change the value from keyboard. This will enable to execute task at and given time. Futher options such as Expire can be edited if required. If not, simply click on OK.  

![](http://aritrabiswas.in/wp-content/uploads/2016/07/10.jpg)

========================================================
This .csv file will be generated in the directory of rscript.

![](http://aritrabiswas.in/wp-content/uploads/2016/07/11.jpg)

========================================================
This .Rout file will be generated in the same directory. This will contain all the text printed in the R terminal. 

![](http://aritrabiswas.in/wp-content/uploads/2016/07/12.jpg)

For Linux:
========================================================
Now here we will create the same thing in a linux environment on raspberry pi. The OS in this device is Debian Jessie. In order to run R script in this device we need to create a .sh file which will contain the bash or terminal script to run R script.  At first create the systime.R file as mentioned earlier. 


```r
time<-Sys.time();
df<-data.frame(time);
names(df)<-"SYSTEM_TIME";
write.csv(df,"systemtime.csv");
head(df)
```

```
          SYSTEM_TIME
1 2016-07-19 13:49:11
```

Creating a shell executable script:
========================================================
Now save this file to into a location. Note down the path. This will be required later. I've save my file on Desktop. Now open terminal, change directory using cd. In my case,

__`cd Desktop`__

Now, open a text editor.  I'm going to use  Leafpad, which comes preinstalled with raspbian. Type the following line of codes:

__`#! /bin/bash`__

__`R CMD BATCH /home/pi/Desktop/systime.R`__


and save this file as systime.sh.

Changing permission:
========================================================
Now, make the .sh file executable by executing the following command from terminal

__`sudo chmod +x systime.sh`__

or simple right click on the script and go to __Properties -> Permissions -> Allow executing file as program__.

To verify the script is running simply click on the .sh file. The scrpit should be executed and the .csv and .Rout file should be generated.

Using crontab:
========================================================
As task scheduler in windows, linux has its own version of called crontab. To run it use the following command in terminal:

__`sudo crontab -e`__

If crontab is running for the first time, choose nano to edit the file. Add the following lines of code at the end of the file. # at the beging of a line means that the line is commented out. Those lines will not be executed. Do not put # in front of the line.

__`* * * * * /home/pi/Desktop/systime.sh`__

 

Using crontab:
========================================================
This line will direct the operating system to run the .sh file after everty one minute. There is a option to change this duration. To see how to change this time durtaion in crontab simply read the commented out lines printed in the terminal.

After the required changes save it using ctrl+X. Choose Yes, to save changes. 

Now the R script should run from terminal and the latest runtime of the scrpit should be saved in a .csv file and as well as in the .Rout file in the selected directory. 

Application in industry:
========================================================

Here i've used `get_video_data()` from the YouTubeR package to track the change in video statistics. What the function does is it downloads the data related to a video in a give period of time. Here I'm tracking videos posted in Times Now's Newhour debate on 12nd July. Here i've sucessfully obtained the change in  viewCount, likeCount, dislikeCount and commentCount for two videos posted in the channel on above mentioned date in 5 mins interval from 10 A.M..

A glimpese at the data:
========================================================
Here what the data looks like:

```
# A tibble: 4 x 8
     items.id
       <fctr>
1 e5MPn8q2v04
2 I9JBNpeNAhE
3 e5MPn8q2v04
4 I9JBNpeNAhE
# ... with 7 more variables: items.snippet.title <chr>,
#   items.snippet.channelTitle <chr>, items.statistics.viewCount <chr>,
#   items.statistics.likeCount <chr>, items.statistics.dislikeCount <chr>,
#   items.statistics.commentCount <chr>, time <time>
```
Visualization:
========================================================
Here, viewCount, likeCount, dislikeCount and commentCount has been plotted against time. The x-axis and y-axis represents time and count respectively. It shows change in count over time. 

![plot of chunk unnamed-chunk-4](Taskscheduler-and-Crontab-with-R-Pres-figure/unnamed-chunk-4-1.png)
EDA of the obtained data:
========================================================
Here, we are fitting a LM on viewCount w.r.t time. __Time=Current time-Published.At__ . Model does not fits the data well because of non-linearity, but it definately shows the way forward. 

![plot of chunk unnamed-chunk-5](Taskscheduler-and-Crontab-with-R-Pres-figure/unnamed-chunk-5-1.png)
It's just the beginning
========================================================
There are so many things can be done with this. This is hard to list them. Soon i'm going to share some of the applications based on this. 

<center>![](http://aritrabiswas.in/wp-content/uploads/2016/07/keep-calm.png)</center>

Reminder:
========================================================
My computer was turned off during 2PM to 11PM on that day that's why there a jump in the graph at the same time this can be considered as a remined that in order to obtain data continously __one must turn on a computer for a cetain period of time__. It is true for internet connectivity as well depending on the requirment of the programm.  

This is just a simple example of where crontab can be used. There are many more things can be done using crontab, shiny and R. I'm going to present some examples related this topic and shiny soon.
