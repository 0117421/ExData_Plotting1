# import necessary libraries
library("dplyr")
library("lubridate")

#import and transform data
.household_power_consumption <- tbl_df(data = household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)) %>%
    mutate(Date = parse_date_time(Date,order = c("%d/%m/%y")), Time = parse_date_time(Time,order = c("%H:%M:%S"))) %>%
    filter(Date == parse_date_time("2007-02-01", orders = c("y-m-d")) | Date == parse_date_time("2007-02-02", orders = c("y-m-d")))

#make the plot
with(.household_power_consumption,hist(as.numeric(Global_active_power, na.rm = TRUE),xlab = "Global Active Power (kilowatts)",col = "red", main = "Global Active Power"))

#generate the png and close the device
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
