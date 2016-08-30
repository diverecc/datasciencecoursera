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
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
download.file(fileURL,destfile="./building.csv")
DT<-fread("building.csv")
