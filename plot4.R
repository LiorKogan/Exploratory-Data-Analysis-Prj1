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

png(file="plot4.png",width=480,height=480)

# plot 4
par(mfrow=c(2,2))

###
with (epc, plot(Time, Global_active_power  , type="l", xlab="", ylab="Global Active Power"))

###
with (epc, plot(Time, Voltage              , type="l", xlab="datetime"                            ))

###
epc_colors= c                         ("black"       , "red"        , "blue"          )
epc_data  = with(epc, cbind.data.frame(Sub_metering_1, Sub_metering_2, Sub_metering_3))
plot(range(epc$Time), range(epc$Sub_metering_1), type="n", xlab="", ylab="Energy sub metering")
lines(epc$Time, epc_data[,1], type="l", col= epc_colors[1])
lines(epc$Time, epc_data[,2], type="l", col= epc_colors[2])
lines(epc$Time, epc_data[,3], type="l", col= epc_colors[3])
legend("topright", colnames(epc_data), lty=c(1,1,1), col=epc_colors)

###
with (epc, plot(Time, Global_reactive_power, type="l", xlab="datetime"                            ))

dev.off()
