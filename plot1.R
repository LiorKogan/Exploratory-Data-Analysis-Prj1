# electric power consumption 
epc   <- read.table("household_power_consumption.txt", header=T, sep=";")

# calc time based on textual columns
dates <- paste(as.character(epc$Date), as.character(epc$Time))
dates <- strptime(dates, format= "%d/%m/%Y %H:%M:%S", tz="UTC")

# replace textual columns with one date-time column
epc$Date <- NULL
epc$Time <- dates

# remove temp var
remove(dates)

# remove dates which are not in range: 2007-02-01 and 2007-02-02
epc <- epc[ (as.Date(epc$Time) == "2007-02-01") | (as.Date(epc$Time) == "2007-02-02"), ]

# to numeric
epc$Global_active_power   <- as.double(as.character(epc$Global_active_power  ))
epc$Global_reactive_power <- as.double(as.character(epc$Global_reactive_power))
epc$Voltage               <- as.double(as.character(epc$Voltage              ))
epc$Sub_metering_1        <- as.double(as.character(epc$Sub_metering_1       ))
epc$Sub_metering_2        <- as.double(as.character(epc$Sub_metering_2       ))
epc$Sub_metering_3        <- as.double(as.character(epc$Sub_metering_3       ))

png(file="plot1.png",width=480,height=480)

# plot 1
hist(epc$Global_active_power, main="Global Active Power", xlab="Global Active Power (kiloWatts)", col="red")

dev.off()
