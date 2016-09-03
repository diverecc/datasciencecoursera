##
## week 1
##
mydata<-read.csv("getdata%2Fdata%2Fss06hid.csv")
vdata<-mydata[which(mydata$VAL==24),]
nrow(vdata)

##question 4
mydata<-xmlTreeParse("getdata%2Fdata%2Frestaurants.xml")
r<-xmlRoot(mydata)
xpathSApply(r,"//zipcode",xmlValue)
nt<-t[which(t==21231)]
length(nt)

##question 5
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL,destfile="./building.csv")
DT<-fread("building.csv")
close(fileURL)

##
## week 2
##

##question 1
h=GET("https://api.github.com/users/jtleek/repos")
j=content(h)
j2=jsonlite::fromJSON(jsonlite::toJSON(j))
j2$created_at[10]

##question 2
acs=read.csv("getdata%2Fdata%2Fss06pid.csv")

##question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
h = readLines(con)
close(con)
r<-c(h[10],h[20],h[30],h[100])
nchar(r)

##question 5
library(data.table)
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileURL,destfile="./cpc.for")
data=read.fwf("./cpc.for",widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4),skip=4)
sum(data[4])

##
## week 3
##

##question 1
library(dplyr)
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL,destfile="./acs.csv")
r=read.csv("acs.csv")
r[which(r$ACR=="3" & r$AGS=="6"),1:3]

##question 2
library(jpeg)
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileURL,destfile="./jeff.jpg")
r=readJPEG("./jeff.jpg",native=TRUE)
quantile(r,c(.3,.8))

##question 3
library(dplyr)
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL,destfile="./gdp.csv")
rgdp<-read.csv("gdp.csv", skip=4) %>%
    filter(X!="")


fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileURL,destfile="./edu.csv")
redu<-read.csv("edu.csv")

rm <- merge(x=rgdp,y=redu,by.x="X",by.y="CountryCode",all=TRUE) %>%
    mutate(X.1=as.numeric(as.character(X.1)))

sum(!is.na(unique(rm$X.1)))

rmo<-rm[order(rm$X.1,decreasing=T),]


##question 4
ho <- filter(rm,Income.Group=="High income: OECD")
hn <- filter(rm,Income.Group=="High income: nonOECD")
c(mean(ho$X.1,na.rm=TRUE), mean(hn$X.1,na.rm=TRUE))

## question 5
rmo$quantile <-cut(rmo$X.1,5)
rt<-rmo[which(rmo$Income.Group=="Lower middle income"),]

##
## week 4
##

##question 1
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL,destfile="./acs4.csv")
racs<-read.csv("acs4.csv",stringsAsFactors=FALSE)
vnames<-names(racs)
sp<-strsplit(vnames,"wgtp")
sp[123]

##question 2
rgdp<-read.csv("gdp.csv", skip=4, nrow=190, stringsAsFactors=FALSE)
rstrip <- mutate(rgdp,X.4=as.numeric(gsub(pattern=",",replacement="",x=X.4)))
avg <- mean(rstrip$X.4,na.rm=T)

##question 3
grep("^United",rstrip$X.3) 

##question 4
rgdp<-read.csv("gdp.csv", skip=4, nrow=190, stringsAsFactors=FALSE)
redu<-read.csv("edu.csv",stringsAsFactors=FALSE)
rm <- merge(x=rgdp,y=redu,by.x="X",by.y="CountryCode",all=TRUE) 

#Look at Special.Notes column "Fiscal year end: Month Day;
length(grep("^Fiscal year end: June .*$",rm$Special.Notes))

##question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

f <- function() {
r2012<-0
r2012Monday <- 0
for (i in 1:length(sampleTimes)) {
    d<-sampleTimes[i]
    if (year(d)==2012) {
        r2012 <- r2012+1
        if (weekdays(d)=="Montag"){
            r2012Monday <-  r2012Monday+1
            }
        }
}
print (r2012)
print (r2012Monday)
}


