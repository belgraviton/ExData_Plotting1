## This script creates png histogram of global active power distribution
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
dataSubset$Global_active_power = as.numeric(dataSubset$Global_active_power)

## Creating histogram
png(filename = 'plot1.png', width = 480, height = 480, bg = "transparent")
with(dataSubset,hist(Global_active_power, col = 'red',main = 'Global active power', xlab = 'Global active power (kilowatts)'))
dev.off()