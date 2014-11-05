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

#make the plot, adding the three different sub_metering values
with(.household_power_consumption,plot(Date_Time,as.numeric(Sub_metering_1, na.rm = TRUE), xlab = "", ylab = "Energy sub metering", type = "n", bg = "white"))
with(.household_power_consumption,lines(Date_Time, as.numeric(Sub_metering_1, na.rm = TRUE)))
with(.household_power_consumption,lines(Date_Time, as.numeric(Sub_metering_2, na.rm = TRUE), col = "red"))
with(.household_power_consumption,lines(Date_Time, as.numeric(Sub_metering_3, na.rm = TRUE), col = "blue"))

#add the legend to the plot
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), col=c("black","red","blue"), cex=0.7)

#generate the png and close the device
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
