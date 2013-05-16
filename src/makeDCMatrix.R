##Example code 
##Compute distance correlation for each pair of genes and save the result in res/dc.csv


#read data
dat<-read.csv("../data/Dream3/Yeast10/Y10.csv",header=T)
#p stand for the number of genes
p<-ncol(dat)

#compute distance correlations for each pair of genes
#optional: use snowfall package for parallel computing if the gene expression file is big

library(snowfall)
sfInit(parallel=T,cpus=8)
sfLibrary(energy)
sfExport("dat")
sfExport("p")

dcor2<-function(i){
	dis<-matrix(0,ncol=p)
	for(j in (i+1):p){
	      dis[j]<-dcor(dat[,i],dat[,j])
	}
	return(dis)
}

res<-sfSapply(1:(p-1),dcor2)
res<-cbind(res,rep(0,p))
res<-res+t(res)
#save the result in res/dc.csv. 
#res will be a matrix whose entry(i,j) stands for the distance correlation of gene i and gene j. 
write.csv(res,"res/dc.csv",row.names=F)

sfStop()