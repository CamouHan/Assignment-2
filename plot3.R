library(dplyr)
library(ggplot2)

if(!exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile = "./data/ppm.zip")
unzip(zipfile="./data/ppm.zip",exdir="./data")

SCC <- readRDS("./data/Source_Classification_Code.rds")
NEI <- readRDS("./data/summarySCC_PM25.rds")

c <- NEI %>% group_by(year,fips="24510",type) %>% summarize(Emissions=sum(Emissions))
c$year <- as.factor(c$year)
ggplot(c, aes(x=year, y=Emissions)) + geom_bar(stat="identity") + facet_grid(. ~ type) + labs(x="Year", y="PM2.5 Emissions (tons)") + ggtitle("Baltimore City PM2.5 Emissions by Type")

dev.copy(png,"plot3.png")
dev.off()
