# import necessary libraries
library("dplyr")
library("lubridate")

#import and transform data
.household_power_consumption <- tbl_df(data = household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)) %>%
    mutate(Date = parse_date_time(Date,order = c("%d/%m/%y"))) %>%
    filter(Date == parse_date_time("2007-02-01", orders = c("y-m-d")) | Date == parse_date_time("2007-02-02", orders = c("y-m-d"))) %>%
    mutate(Date_Time = parse_date_time(paste(strftime(Date, format = "%d/%m/%y"), Time), orders = "%d/%m/%y %H:%M:%S"))

#set locale to use English
Sys.setlocale("LC_TIME", "English")

#make plot
with(.household_power_consumption,plot(Date_Time,as.numeric(Global_active_power, na.rm = TRUE), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#generate png and close device
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
