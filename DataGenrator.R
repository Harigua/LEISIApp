#library(remotes)
#install.packages("distr")
library(RODBC)
library(RODBCext)
library(distr)
connect=odbcConnect("InDev", uid='root', pwd='16souemna' , DBMSencoding = "UTF-8")


query=paste("select * from patient")
data=data.frame(sqlQuery(connect,query))
data=data[,c(1:3,7)]
#generate ages with a costum distrubution
T <- UnivarMixingDistribution(Chisq(7,2), Norm(50,20))
AGEs <- sample(c(0:100), 3000, replace=TRUE, prob=c(d(T)(0:100)) )
NAT <- sample(c("TN","MA","LB","DZ","Other"), 3000, replace=TRUE, prob=c(50,30,10,5,5) )
Gend <- sample(c("Male","Female","N/A"), 3000, replace=TRUE, prob=c(49,49,2) )
#prop.table(table(AGEs))
for(p in 1:dim(data)[1])
{
	updateQuery=paste0("update patient set AGE='",AGEs[p],"', NATIONALITY='",NAT[p],"', GENDER='",Gend[p],"' where PATIENT_IDENTIFIER='",data[p,1],"';")
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, updateQuery)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      sprintf("Error in Update patient %d",p)
    }else{sprintf("Patient %d age successfully Updated",p)}	
}


query=paste("select * from sample")
data2=data.frame(sqlQuery(connect,query))
#generate lesion ages with a costum distrubution
T <- UnivarMixingDistribution(Chisq(3,2), Norm(7,2))
L_AGEs <- sample(c(0:15), 3000, replace=TRUE, prob=c(d(T)(0:15)) )
for(p in 1:dim(data2)[1])
{
	updateQuery=paste0("update sample set SPECIES='Other', Lesion_Age='",L_AGEs[p],"' where ID_SAMPLE='",data2[p,1],"';")
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, updateQuery)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      sprintf("Error in Update patient %d",p)
    }else{sprintf("Patient %d age successfully Updated",p)}	
}



query=paste("select * from sample as s , patient as p where s.PATIENT_IDENTIFIER=p.PATIENT_IDENTIFIER and p.NATIONALITY='TN'")
data3=data.frame(sqlQuery(connect,query))
#generate species with a costum distrubution for TN
LS <- sample(c("L.infantum","L.major","L.tropica","Other"), 3000, replace=TRUE, prob=c(55,30,10,5) )
for(p in 1:dim(data3)[1])
{
	updateQuery=paste0("update sample set SPECIES='",LS[p],"' where ID_SAMPLE='",data3[p,1],"';")
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, updateQuery)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      sprintf("Error in Update patient %d",p)
    }else{sprintf("Patient %d age successfully Updated",p)}	
}

query=paste("select * from sample as s , patient as p where s.PATIENT_IDENTIFIER=p.PATIENT_IDENTIFIER and p.NATIONALITY='MA'")
data3=data.frame(sqlQuery(connect,query))
#generate species with a costum distrubution for MA
LS <- sample(c("L.major","L.infantum","Other"), 3000, replace=TRUE, prob=c(75,20,5) )
for(p in 1:dim(data3)[1])
{
	updateQuery=paste0("update sample set SPECIES='",LS[p],"' where ID_SAMPLE='",data3[p,1],"';")
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, updateQuery)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      sprintf("Error in Update patient %d",p)
    }else{sprintf("Patient %d age successfully Updated",p)}	
}

query=paste("select * from sample as s , patient as p where s.PATIENT_IDENTIFIER=p.PATIENT_IDENTIFIER and p.NATIONALITY='LB'")
data3=data.frame(sqlQuery(connect,query))
#generate species with a costum distrubution for LB
LS <- sample(c("L.tropica","L.infantum","Other"), 3000, replace=TRUE, prob=c(75,20,5) )
for(p in 1:dim(data3)[1])
{
	updateQuery=paste0("update sample set SPECIES='",LS[p],"' where ID_SAMPLE='",data3[p,1],"';")
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, updateQuery)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      sprintf("Error in Update patient %d",p)
    }else{sprintf("Patient %d age successfully Updated",p)}	
}
