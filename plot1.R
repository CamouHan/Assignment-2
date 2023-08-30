library(dplyr)

if(!exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile = "./data/ppm.zip")
unzip(zipfile="./data/ppm.zip",exdir="./data")

SCC <- readRDS("./data/Source_Classification_Code.rds")
NEI <- readRDS("./data/summarySCC_PM25.rds")

a <- NEI %>% group_by(year)%>% summarize(Emissions= sum(Emissions))
barplot(a$Emissions,a$year,main="Emission Over Years",xlab="Years",ylab="Emissions",names.arg = a$year)

dev.copy(png,"plot1.png")
dev.off()