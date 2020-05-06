
rm(list=ls())

## By right click on the statement "Dataset: Electric power consumption [20Mb]", we can get the url for dataset
## Then using that url, download the dataset and unzip as shown in the below codes

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()		# this is the temperaory destination file to save the data 
download.file(url, temp)

data <- fread(unzip(temp, files = "household_power_consumption.txt"))
rm(temp)				# after assign the unziped data to 'data', temp won't be required and hence removed

dim(data)
head(data)
tail(data)
str(data)


## Subsetting the data by dates 1st and 2nd Feb 2007 ##
data2 <- as.data.frame(data[data$Date %in% c("1/2/2007","2/2/2007") ,])
dim(data2)
head(data2)


## Create date/time variable using strptime() function 
datetime <- strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
g_active_power <- as.numeric(data2$Global_active_power)
str(g_active_power)


## Constructing Line Plot for Global Active Power versus Datetime ##
png("plot2.png", width=480, height=480)
plot(datetime, g_active_power, type='l', xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
