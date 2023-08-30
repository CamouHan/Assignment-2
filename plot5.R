library(dplyr)
library(ggplot2)

if(!exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile = "./data/ppm.zip")
unzip(zipfile="./data/ppm.zip",exdir="./data")
SCC <- readRDS("./data/Source_Classification_Code.rds")
NEI <- readRDS("./data/summarySCC_PM25.rds")

e <- NEI %>%
    filter(fips == "24510" & type == "ON-ROAD") %>%
    group_by(year) %>%
    summarize(total_emissions = sum(Emissions))

e$year <- as.factor(e$year)

ggplot(e, aes(x=year, y=total_emissions)) + geom_bar(stat="identity") + labs(x="Year", y="PM2.5 Emissions (tons)") + ggtitle("Baltimore City PM2.5 Emissions from Vehicle Related Sources")

dev.copy(png,'plot5.png')
dev.off()

getwd()
