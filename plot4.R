# import necessary libraries
library("dplyr")
library("lubridate")

#import and transform data
.household_power_consumption <- tbl_df(data = household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)) %>%
    mutate(Date = parse_date_time(Date,order = c("%d/%m/%y"))) %>%
    filter(Date == parse_date_time("2007-02-01", orders = c("y-m-d")) | Date == parse_date_time("2007-02-02", orders = c("y-m-d"))) %>%
    mutate(datetime = parse_date_time(paste(strftime(Date, format = "%d/%m/%y"), Time), orders = "%d/%m/%y %H:%M:%S"))

#set locale to use English
Sys.setlocale("LC_TIME", "English")

#set plot layout
par(mfcol = c(2,2))

#(1,1) plot
with(.household_power_consumption,plot(datetime,as.numeric(Global_active_power, na.rm = TRUE), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#(2,1) plot
with(.household_power_consumption,plot(datetime,as.numeric(Sub_metering_1, na.rm = TRUE), xlab = "", ylab = "Energy sub metering", type = "n", bg = "white"))
with(.household_power_consumption,lines(datetime, as.numeric(Sub_metering_1, na.rm = TRUE)))
with(.household_power_consumption,lines(datetime, as.numeric(Sub_metering_2, na.rm = TRUE), col = "red"))
with(.household_power_consumption,lines(datetime, as.numeric(Sub_metering_3, na.rm = TRUE), col = "blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), col=c("black","red","blue"), cex=0.7, bty = "n")

#(1,2) plot
with(.household_power_consumption,plot(datetime,as.numeric(Voltage, na.rm = TRUE), type = "l", ylab = "Voltage"))

#(2,2) plot
with(.household_power_consumption,plot(datetime,as.numeric(Global_reactive_power, na.rm = TRUE), type = "l", ylab = "Global_reactive_power"))

#generate png and close device
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
