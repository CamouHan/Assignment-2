library(dplyr)

if(!exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile = "./data/ppm.zip")
unzip(zipfile="./data/ppm.zip",exdir="./data")

SCC <- readRDS("./data/Source_Classification_Code.rds")
NEI <- readRDS("./data/summarySCC_PM25.rds")

b <- NEI %>% group_by(year,fips="24510") %>% summarize(Emissions=sum(Emissions))

barplot(b$Emissions,b$year,main="Emissions by Year in Baltimore City",xlab="Years",ylab="Emissions",names.arg = b$year)

dev.copy(png,"plot2.png")
dev.off()