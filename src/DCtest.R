#compare the network and restored in res/dc.csv to a real network
true<-read.table("../data/Dream3/Yeast10/True.txt",header=F)
true<-as.matrix(true)
dc<-read.csv("res/dc.csv",header=T)
dc<-as.matrix(dc)

library(minet)
#use MRNET algorithm
mr<-mrnet(dc)
#use CLR algorithm
clr<-clr(dc)

#compare with real network
mr.tbl<-validate(mr,true)
clr.tbl<-validate(clr,true)
dc.tbl<-validate(dc,true)


#compute roc area
auc.roc(mr.tbl)
auc.roc(clr.tbl)
auc.roc(dc.tbl)
#compute pr area
auc.pr(mr.tbl)
auc.pr(clr.tbl)
auc.pr(dc.tbl)
