library(dplyr)
library(ggplot2)

if(!exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,destfile = "./data/ppm.zip")
unzip(zipfile="./data/ppm.zip",exdir="./data")
SCC <- readRDS("./data/Source_Classification_Code.rds")
NEI <- readRDS("./data/summarySCC_PM25.rds")

d <- NEI %>%
    filter(fips %in% c("24510", "06037") & type == "ON-ROAD") %>%
    group_by(year, fips) %>%
    summarize(total_emissions = sum(Emissions))

d$year <- as.factor(d$year)
d$county_name <- factor(d$fips, levels=c("06037", "24510"), labels=c("Los Angeles County", "Baltimore City")) 

ggplot(d, aes(x=year, y=total_emissions)) + 
    geom_bar(stat="identity", aes(fill=county_name), position = "dodge") +
    guides(fill=guide_legend(title=NULL)) +
    labs(x="Year", y="PM2.5 Emissions (tons)") +
    ggtitle("Vehicle PM2.5 Emissions - Baltimore City and LA County") +
    theme(legend.position="top")


dev.copy(png,'plot6.png')
dev.off()