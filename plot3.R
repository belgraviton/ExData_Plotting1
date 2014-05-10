## This script creates png plot of energy sub metering time dependence
## Data file 'household_power_consumption.txt' should be in current R directory

## Reading all data
data = read.table(file = 'household_power_consumption.txt', header = TRUE, sep = ';')

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
dataSubset$Sub_metering_1 = as.numeric(dataSubset$Sub_metering_1)
dataSubset$Sub_metering_2 = as.numeric(dataSubset$Sub_metering_2)
dataSubset$Sub_metering_3 = as.numeric(dataSubset$Sub_metering_3)

## Creating plot
png(filename = 'plot3.png', width = 480, height = 480)
with(dataSubset,plot(DateTime,Sub_metering_1, 'l',col = 'black', main = '', xlab = '', ylab = 'Energy sub metering'))
with(dataSubset,points(DateTime,Sub_metering_2, 'l',col = 'red'))
with(dataSubset,points(DateTime,Sub_metering_3, 'l',col = 'blue'))
legend('topright',pch = '-', pt.cex = 0.5,  col = c('black','red','blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
dev.off()