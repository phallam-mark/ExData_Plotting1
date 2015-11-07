library(dplyr)

## PREPARE THE DATA
# read the file into a data frame called hpc_df
hpc_df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = F)

#filter out the rows we want and assign result to hpc_df2
hpc_df2 <- filter(hpc_df, hpc_df$Date %in% c("1/2/2007", "2/2/2007"))

#combine Date and Time into one column
hpc_df3 = mutate(hpc_df2, Date_Time = paste(Date, Time, sep = " "))

#get rid of the Date and Time columns
hpc_df4 <- select(hpc_df3, -Date, -Time)

#format the Date_Time column as POSIXlt
hpc_df4$Date_Time <- strptime(hpc_df4$Date_Time, format = "%d/%m/%Y %H:%M:%S", tz="")

## CREATE PLOT 4
#re-direct output from windows device to a png file
png('plot4.png')

#set up the plot window for two rows/two plots side-by-side on each row
par(mfrow=c(2,2))

##create the graphs
## create Plot 4.1
plot(hpc_df4$Date_Time, hpc_df4$Global_active_power, type = "l", col="black", ylab="Global Active Power", xlab="")

## create Plot 4.2
plot(hpc_df4$Date_Time, hpc_df4$Voltage, type = "l", col="black", ylab="Voltage", xlab="datetime")


## create Plot 4.3
plot(hpc_df4$Date_Time, type="n", hpc_df4$Sub_metering_1, ylab="Energy sub metering", xlab="")
points(hpc_df4$Date_Time, hpc_df4$Sub_metering_1, col="black", type = "l")
points(hpc_df4$Date_Time, hpc_df4$Sub_metering_2, col="red", type = "l")
points(hpc_df4$Date_Time, hpc_df4$Sub_metering_3, col="blue", type = "l")
legend("topright",lty=c(1,1,1), cex=0.3, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

## create Plot 4.4
plot(hpc_df4$Date_Time, hpc_df4$Global_reactive_power, type = "l", col="black", ylab="Global_reactive_power", xlab="datetime")

#close the png graphics device
dev.off()