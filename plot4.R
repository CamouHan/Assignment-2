library(dplyr)
library(ggplot2)

if(!exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile = "./data/ppm.zip")
unzip(zipfile="./data/ppm.zip",exdir="./data")
SCC <- readRDS("./data/Source_Classification_Code.rds")
NEI <- readRDS("./data/summarySCC_PM25.rds")

coal_SCCs <- SCC %>%
    filter(grepl("coal", EI.Sector, ignore.case=TRUE)) %>%
    select(SCC)

d <- NEI %>%
    filter(SCC %in% coal_SCCs$SCC) %>%
    group_by(year) %>%
    summarize(total_emissions = sum(Emissions))

d$year <- as.factor(d$year)

ggplot(d, aes(x=year, y=total_emissions)) + geom_bar(stat="identity") + labs(x="Year", y="PM2.5 Emissions (tons)") + ggtitle("US PM2.5 Emissions from Coal Related Sources")

dev.copy(png,'plot4.png')
dev.off()