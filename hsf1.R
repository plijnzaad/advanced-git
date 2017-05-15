setwd("/Users/philip/Desktop/RSGworkshop/")

hsf1 <- read.table("hsf1.type.txt", stringsAsFactors=TRUE)
## Data from de Jonge et al., EMBO J. 2016. Rownames are names of target
## genes (yeast), M is log2(fold-change ratio of mRNA expression) in
## response to Hsf1-depeletion, binding is Hsf1-binding to target genes,
## promoter.type is the class of promoter this gene has. Data is also in
## https://pastebin.com/WxamLAWZ http://tinyurl.com/hsf1data

plot(data=hsf1, M ~ binding)
with(hsf1[hsf1$promoter.type=='SAGA',],
     {points(M ~ binding, col='red',pch=19)})
with(hsf1[hsf1$promoter.type=='TFIID',],
     {points(M ~ binding, col='blue',pch=19)})

## t.test
with(hsf1, t.test(M ~ promoter.type))
with(hsf1, t.test(binding ~ promoter.type))
## Box plots, of M (and/or binding)
## to use plot, hsf1$promoter.type must be a factor!
with(hsf1, plot(M ~ promoter.type))
boxplot(M ~ promoter.type, data=hsf1)
## (replace M with binding for same on the binding data)

## Extra: to add the points themselves, use x=1 for saga, x = 2 for TFIID
saga <- hsf1[ hsf1$promoter.type == "SAGA", "M"]
tfiid <- hsf1[ hsf1$promoter.type == "TFIID", "M"]
points(x=jitter(rep(1, length.out=length(saga))), y=saga, col="red", pch=19)
points(x=jitter(rep(2, length.out=length(tfiid))), y=tfiid, col="blue", pch=19)

plot(data=hsf1, M ~ binding)
with(hsf1[hsf1$promoter.type=='SAGA',],
     {points(M ~ binding, col='red',pch=19)})
with(hsf1[hsf1$promoter.type=='TFIID',],
     {points(M ~ binding, col='blue',pch=19)})
lm <- lm(M~binding,data=hsf1)
abline(lm,  col="black",lty=2)
lm <- lm(M~binding,data=hsf1[hsf1$promoter.type=="SAGA",])
abline(lm,  col="red",lty=2)
lm <- lm(M~binding,data=hsf1[hsf1$promoter.type=="TFIID",])
abline(lm,  col="blue",lty=2)

## slope difference ancova!
summary(lm(M ~ binding + promoter.type + binding:promoter.type, data=hsf1))

## 
spans <- c(red=0.9, orange=0.7, brown=0.5, purple=0.3)
for(color in names(spans)) 
  with(hsf1, lines(lowess(M ~ binding, f=spans[color]), col=color))

## ------------------------------------------------------------------------
