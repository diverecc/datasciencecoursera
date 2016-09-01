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


