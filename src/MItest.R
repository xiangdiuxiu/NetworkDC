true<-read.table("../data/Dream3/Yeast10/True.txt",header=F)
true<-as.matrix(true)

library(minet)
library(energy)

#read the gene expression and compute MI between each pair of genes
dat<-read.csv("../data/Dream3/Yeast10/Y10.csv",header=T)
p<-ncol(dat)

MI<-build.mim(dat,"mi.shrink","equalwidth",sqrt(nrow(dat)))

mr<-mrnet(MI)
ar<-aracne(MI)
clr<-clr(MI)

mr.tbl<-validate(mr,true)
clr.tbl<-validate(clr,true)
mi.tbl<-validate(MI,true)

#compute roc area
auc.roc(mr.tbl)
auc.roc(clr.tbl)
auc.roc(mi.tbl)
#compute pr area
auc.pr(mr.tbl)
auc.pr(ar.tbl)
auc.pr(mi.tbl)