### Allie provided
source("http://bioconductor.org/biocLite.R")
#LOAD DATABASE AND AFFY LIBRARY
biocLite("ath1121501.db")
biocLite("affy")
biocLite("biobase")
#USE AFFY LIBRARY
require(affy)

#READ FILES
Data <- ReadAffy()
pData(Data)

#make a boxplot to look at the data
boxplot(Data)

#load phenodata file

pd <- read.AnnotatedDataFrame("Gifford_CELfilestokeep_PhenoData.txt")
phenoData(Data) <- pd
pData(pd)

#normalize data
nData <- rma(Data)

#look at normalized data
boxplot(exprs(nData),main="normalized data")

tnData <- t(as.data.frame(nData))

##write.csv(tnData, file="tnData.csv")

head(tnData)

#remove genes that are not expressed - threshold based per dataset
lowExprThresh = 6
rmvRows = apply (tnData, 1, function(x){all( x < lowExprThresh)})

enData = tnData[!rmvRows,]


write.csv(enData, file="Treatment_tnData_NOV26.csv")
