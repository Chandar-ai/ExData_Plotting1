
rm(list=ls())

## By right click on the statement "Dataset: Electric power consumption [20Mb]", we can get the url for dataset
## Then using that url, download the dataset and unzip as shown in the below codes

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()		# this is the temperaory destination file to save the data 
download.file(url, temp)

data <- fread(unzip(temp, files = "household_power_consumption.txt"))
rm(temp) 	  # after assign the unziped data to 'data', temp won't be required and hence removed

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

sub_metering1 <- as.numeric(data2$Sub_metering_1)
sub_metering2 <- as.numeric(data2$Sub_metering_2)
sub_metering3 <- as.numeric(data2$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime, sub_metering1, xlab="", ylab="Energy Sub metering", type="l",)
lines(datetime, sub_metering2, type="l", col="red")
lines(datetime, sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

