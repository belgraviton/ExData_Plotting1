## This script creates png file with plot of household global minute-averaged active power time dependence,
## plot of minute-averaged voltage time dependence,
## plot of energy sub metering time dependence,
## plot of household global minute-averaged reactive power time dependence

## Data file 'household_power_consumption.txt' should be in current R directory

## Reading all data
data = read.table(file = 'household_power_consumption.txt', header = TRUE, sep = ';', colClasses = "character")

## Adding new column DateTime = Date + ' ' + Time
data$DateTime = paste(data$Date, data$Time, sep=' ')
## Converting column DateTime to Time format
data$DateTime = strptime(data$DateTime,format = '%d/%m/%Y %H:%M:%S')

## Boundaries dates
date1 = as.POSIXlt('2007-02-01')
date2 = as.POSIXlt('2007-02-03') ## This time is end of day 2007-02-02

## Lets find correct date data
dataSubset = subset(data,DateTime > date1 & DateTime < date2)
## Converting data to numeric type
dataSubset$Global_active_power = as.numeric(dataSubset$Global_active_power)
dataSubset$Global_reactive_power = as.numeric(dataSubset$Global_reactive_power)
dataSubset$Voltage = as.numeric(dataSubset$Voltage)
dataSubset$Sub_metering_1 = as.numeric(dataSubset$Sub_metering_1)
dataSubset$Sub_metering_2 = as.numeric(dataSubset$Sub_metering_2)
dataSubset$Sub_metering_3 = as.numeric(dataSubset$Sub_metering_3)

## Creating plot
png(filename = 'plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
## Subplot (1,1)
with(dataSubset,plot(DateTime,Global_active_power, 'l',main = '', xlab = '', ylab = 'Global active power'))
## Subplot (1,2)
with(dataSubset,plot(DateTime,Voltage, 'l',main = '', xlab = '', ylab = 'Voltage'))
## Subplot (2,1)
with(dataSubset,plot(DateTime,Sub_metering_1, 'l',col = 'black', main = '', xlab = '', ylab = 'Energy sub metering'))
with(dataSubset,points(DateTime,Sub_metering_2, 'l',col = 'red'))
with(dataSubset,points(DateTime,Sub_metering_3, 'l',col = 'blue'))
legend('topright',pch = '-', col = c('black','red','blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), box.lwd = 0)
## Subplot (2,2)
with(dataSubset,plot(DateTime,Global_reactive_power, 'l',main = '', xlab = '', ylab = 'Global reactive power'))
dev.off()