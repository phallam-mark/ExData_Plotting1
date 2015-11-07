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

## CREATE PLOT 2
#re-direct output from windows device to a png file
png('plot2.png')

#create the line graph
plot(hpc_df4$Date_Time, hpc_df4$Global_active_power, type = "l", col="black", ylab="Global Active Power (kilowatts)", xlab="")

# close the png graphics device
dev.off()