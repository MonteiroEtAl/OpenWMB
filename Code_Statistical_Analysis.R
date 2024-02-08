###################################################################################################################################################################
####Important note!!!!!!!
##To run this analysis, you will need to download the Excel files entitled DB_alphas_omegas_tasks, Imputed_Databases_Validation_PT_version, BDs_imput2, and 
##Original_DB_without_outliers from the GitHub repository that contains the OpenWMB.
##It is paramount that these files are stored in the same folder as this R file; otherwise, this script will not function properly.

#Replace the string 'XXXXX' with the path of the directory in which you stored the R script and the Excel files with the databases. 
#Separate the components of the path with a double backslash (\\). It is paramount that you store all these files in the same directory.
setwd("C:\\Users\\fabio\\OneDrive\\Área de Trabalho\\FCT- PhD Coimbra -The daily rhytms of WM\\Latent_Variable_Study\\Reviewed_Version\\R2Version")

#####Libraries used in this script
library(semPlot)
library(semTools)
library(MVN)
library(mice)
library(readxl)
library(tibble)
library(openxlsx)
library(simsem)
library(psych)
library(sjmisc)
library(tidyr)

###################################################################################################################################################################
#
#
#
#
###################################################################################################################################################################
########1 - Power analysis
##We followed the procedure outlined by Muthén and Muthén (2002) to compute the Monte Carlo simulations. 
##We ran two Monte Carlo simulations with different seeds for each model.
##10,000 samples were generated in each simulation. 
##We used the following criteria to ensure that the chosen sample size was sufficient to achieve the desired statistical power and unbiased parameter estimates: 
##1 - Relative bias and standard error bias ≤ .10 for all parameters. 
##2 - Relative standard error bias ≤ .05 for the parameters of interest.
##3 - Coverage range between .91 and .98. 
##4 - Statistical power ≥ .80. 

##The parameter values used in the models were taken from previous investigations. 
##The parameter values for the reading span (.70), operation span (.66), n-back task (.55), binding and maintenance task (.86), letter series (.71), 
##and number series (.70) were collected from the study of Wilhelm et al. (2013). 
##The parameter value of the correlation between the WMC and the Gf factors (.83) was also derived from this study. 
##The parameter values for the symmetry span (.73) and the RAPM (.76) were taken from the study of Kane et al. (2004). 
##The value for the memory updating task (.64) was obtained from the study of Schmiedek et al. (2009). 
##We could not find a single investigation that used the multimodal span to assess the relationship between WMC and Gf or to derive a WMC factor. 
##A value of .50 was attributed to this parameter value of the multimodal span (Katz, 2019). 

##Monte Carlo Simulation computed to estimate the minimum sample size required to assess the general WMC factor (all tasks loading in one factor).
popModel <- '
f1 =~ 0.70*y1 + 0.66*y2 + 0.73*y3 + 0.55*y4 + 0.64*y5 + 0.86*y6  + 0.50*y7
y1 ~~ 0.51*y1
y2 ~~ 0.56*y2
y3 ~~ 0.47*y3
y4 ~~ 0.70*y4
y5 ~~ 0.59*y5
y6 ~~ 0.26*y6
y7 ~~ 0.75*y7
'

pop.fit<-sem(popModel,do.fit=FALSE)
summary(pop.fit,standardized=TRUE,rsquare=TRUE)

analysisModel <- '
f1 =~ y1 + y2 + y3 + y4 + y5 + y6  + y7
'

Output10 <- sim(10000, model=analysisModel, n=160, generate=popModel, std.lv=TRUE, lavaanfun = "cfa",seed = 10)
Output100 <- sim(10000, model=analysisModel, n=160, generate=popModel, std.lv=TRUE, lavaanfun = "cfa",seed = 100)

summaryParam(Output10,detail=TRUE,alpha = 0.05)
summaryConverge(Output10)
summary(Output10)
summaryParam(Output100,detail=TRUE,alpha = 0.05)
summaryConverge(Output100)
summary(Output100)

Df.MC10 <- data.frame(summaryParam(Output10,detail=TRUE,alpha = 0.05))
Df.MC10 <- Df.MC10[,-c(1:3,5:9,12,14:17)]
View(Df.MC10)
Df.MC100 <- data.frame(summaryParam(Output100,detail=TRUE,alpha = 0.05))
Df.MC100 <- Df.MC100[,-c(1:3,5:9,12,14:17)]
View(Df.MC100)

##Monte Carlo Simulation computed to estimate the minimum sample size required to assess the Structural Equation Model that evaluated the correlation between the 
##general WMC factor (all tasks loading in one factor) and a Gf factor derived from the letter series, the number series and the Raven’s Advanced Progressive 
##Matrices.
popModel <- '
f1 =~ 0.70*y1 + 0.66*y2 + 0.73*y3 + 0.55*y4 + 0.64*y5 + 0.86*y6  + 0.50*y7
f2 =~ 0.71*y8 + 0.70*y9 + 0.76*y10
f2 ~ 0.83*f1
y1 ~~ 0.51*y1
y2 ~~ 0.56*y2
y3 ~~ 0.47*y3
y4 ~~ 0.70*y4
y5 ~~ 0.59*y5
y6 ~~ 0.26*y6
y7 ~~ 0.75*y7
y8 ~~ 0.50*y8
y9 ~~ 0.51*y9
y10 ~~ 0.42*y10
'
pop.fit<-sem(popModel,do.fit=FALSE)
summary(pop.fit,standardized=TRUE,rsquare=TRUE)

analysisModel <- '
f1 =~ y1 + y2 + y3 + y4 + y5 + y6  + y7
f2 =~ y8 + y9 + y10
f2 ~ f1
'

Output10 <- sim(10000, model=analysisModel, n=160, generate=popModel, std.lv=TRUE, lavaanfun = "cfa",seed = 10)
Output100 <- sim(10000, model=analysisModel, n=160, generate=popModel, std.lv=TRUE, lavaanfun = "cfa",seed = 100)

summaryParam(Output10,detail=TRUE,alpha = 0.05)
summaryConverge(Output10)
summary(Output10)
summaryParam(Output100,detail=TRUE,alpha = 0.05)
summaryConverge(Output100)
summary(Output100)

Df.MC10 <- data.frame(summaryParam(Output10,detail=TRUE,alpha = 0.05))
Df.MC10 <- Df.MC10[,-c(1:3,5:9,12,14:17)]
View(Df.MC10)
Df.MC100 <- data.frame(summaryParam(Output100,detail=TRUE,alpha = 0.05))
Df.MC100 <- Df.MC100[,-c(1:3,5:9,12,14:17)]
View(Df.MC100)

###################################################################################################################################################################
#
#
#
#
###################################################################################################################################################################
###2 - Replacement of missing values through multiple imputation.

##Reads the DB containing the original data of the participants in the WM tasks.In this DB, univariate outliers (scores that deviated -/+ 3 StDev from the mean)
##where set to missing values.
DB_1 <- read_excel('Original_DB_without_outliers.xlsx', sheet = 'WMC')
View(DB_1)

#####Reads the DB containing the original data of the participants in the Gf tasks.In this DB, univariate outliers (scores that deviated -/+ 3 StDev from the mean)
##where set to missing values.
DB_2 <- read_excel('Original_DB_without_outliers.xlsx', sheet = 'Gf')
View(DB_2)

###Creates the predictor matrix that will be used to impute the missing values of each WM task. 
##The predictor matrix specifies which variables are used in the linear regression of each of the imputation models. 
##A value of 1 specifies that the variable given in the column name is used in the model to impute the variable given in the row name. 
##A value of  0 specifies that this variable is not used in this model.
imp_gen_DB_1 <- mice(DB_1, print = FALSE)
pred1 <- imp_gen_DB_1$predictorMatrix 
pred1[,"subject_nr"] <- 0
pred1["NBack","Multimodal_Span"] <- 0
View(pred1)

##Creates the predictor matrix that will be used to impute the missing values of each Gf task. 
##The predictor matrix specifies which variables are used in the linear regression of each of the imputation models. 
##A value of 1 specifies that the variable given in the column name is used in the model to impute the variable given in the row name. 
##A value of  0 specifies that this variable is not used in this model.
imp_gen_DB_2 <- mice(DB_2, print = FALSE)
pred2 <- imp_gen_DB_2$predictorMatrix 
pred2[,"subject_nr"] <- 0
View(pred2)

###This section of the script uses multiple imputation to generate 20 databases in which the missing values of the WM tasks will be replaced by plausible values.
###The missing values replaced through multiple imputation will be slightly different each time you run this function. 
###If you are looking to replicate the statistical analysis presented in the article by Monteiro et al. (2024) you should use R's 'read_excel' function 
###to read the DB entitled "BDs_imput2_2nd.xlsx" (see line 247 of this file). This file contains the DBs  (generated through multiple imputation)  that were used 
###to compute all the analitical procedures described in the article.
imp_gen_DB_1 <- mice(data=DB_1,
                     method = 'pmm',
                     m=20,
                     maxit=10,
                     predictorMatrix = pred1)

###This section of the script uses multiple imputation to generate 20 databases in which the missing values of the Gf tasks will be replaced by plausible values.
###The missing values replaced through multiple imputation will be slightly different each time you run this function. 
###If you are looking to replicate the statistical analysis presented in the article by Monteiro et al. (2024) you should use R's 'read_excel' function 
###to read the DB entitled "BDs_imput2_2nd.xlsx" (see line 247 of this file). This file contains the DBs  (generated through multiple imputation)  that were used 
###to compute all the analitical procedures described in the article.
imp_gen_DB_2 <- mice(data=DB_2,
                     method = 'pmm',
                     m=20,
                     maxit=10,
                     predictorMatrix = pred2)


###Creates the variables mice.imp_DB and fills them with the DB that were generated through multiple imputation.
mice.imp_DB_1 <- NULL
mice.imp_DB_2 <- NULL
ParaMaha <- NULL
for(i in 1:20) mice.imp_DB_1[[i]] <- complete(imp_gen_DB_1, action=i, inc=FALSE)
subject_id <- mice.imp_DB_1[[1]][,1]
for(i in 1:20) mice.imp_DB_1[[i]] <- mice.imp_DB_1[[i]][,-c(1)]. 
for(i in 1:20) ParaMaha[[i]] <- complete(imp_gen_DB_1, action=i, inc=FALSE)
for(i in 1:20) ParaMaha[[i]] <- ParaMaha[[i]][,-c(1)]
for(i in 1:20) mice.imp_DB_2[[i]] <- complete(imp_gen_DB_2, action=i, inc=FALSE)
for(i in 1:20) mice.imp_DB_2[[i]] <- mice.imp_DB_2[[i]][,-c(1)]
for(i in 1:20) mice.imp_DB_1[[i]] <- add_column(mice.imp_DB_1[[i]],mice.imp_DB_2[[i]],.after = 8)
for(i in 1:20) mice.imp_DB_1[[i]] <- data.frame(mice.imp_DB_1[[i]])
View(mice.imp_DB_1[[1]])

###Calculates the Mahalonobis Distance and the respective p-value for each participant.
for(i in 1:20) mice.imp_DB_1[[i]]$Mahalanobis_WMC_Gf <- mahalanobis(mice.imp_DB_1[[i]],colMeans(mice.imp_DB_1[[i]]),cov(mice.imp_DB_1[[i]]))
for(i in 1:20) mice.imp_DB_1[[i]]$pvalue_WMC_Gf <- pchisq(mice.imp_DB_1[[i]]$Mahalanobis, df=9, lower.tail=FALSE)
for(i in 1:20) mice.imp_DB_1[[i]]$Mahalanobis_WMC <- mahalanobis(ParaMaha[[i]],colMeans(ParaMaha[[i]]),cov(ParaMaha[[i]]))
for(i in 1:20) mice.imp_DB_1[[i]]$pvalue_WMC <- pchisq(mice.imp_DB_1[[i]]$Mahalanobis_WMC, df=6, lower.tail=FALSE)
for(i in 1:20) mice.imp_DB_1[[i]] <- add_column(mice.imp_DB_1[[i]],subject_id,.before = 1)
View(mice.imp_DB_1[[10]])

###Generates an excel file that includes the 20 DB that were created through multiple imputations and the values of the Mahalanobis Distances.
excSheet <- c("BD1","BD2","BD3","BD4","BD5","BD6","BD7","BD8","BD9","BD10","BD11","BD12","BD13","BD14","BD15","BD16","BD17","BD18","BD19","BD20")
OUT <- createWorkbook()
for(i in 1:20) addWorksheet(OUT, excSheet[[i]])
for(i in 1:20) writeData(OUT, sheet = excSheet[[i]], x = mice.imp_DB_1[[i]])
saveWorkbook(OUT, "BDs_imputed.xlsx",overwrite = TRUE)

##In the analysis described in the article by Monteiro et al. (2024), we excluded participants whose data deviated significantly from the distribution. 
##The scores from one participant (ID 155) deviated significantly from the distribution (p-value associated with the Mahalanobis Distance < .001).
##Thus, the data from this participant was excluded from further analysis.  
##The data from participant 155 is not included in the DB entitled Imputed_Databases_Validation_PT_version (see line 247). 
##This file contains the DBs that were used to compute the statistical analysis described in the article by Monteiro et al. (2024).
##All analyses presented from this point forward were either based on the raw data included in this file or pooled estimates based on Rubin’s (1987) rules. 
#####################################################################################################################################################################
#
#
#
#
###################################################################################################################################################################
##Very important!!!!!!!!
##3 - DBs used to compute the statistical analyses reported in the article by Monteiro et al. (2024). 

##The function bellow reads the excel file that contains the imputed DBs that were used to compute the statistical analysis presented 
##in the article by Monteiro et al. (2024).
excSheet <- c("BD1","BD2","BD3","BD4","BD5","BD6","BD7","BD8","BD9","BD10","BD11","BD12","BD13","BD14","BD15","BD16","BD17","BD18","BD19","BD20")
imp_gen_DB_1_2nd <- NULL
for (i in 1:20) imp_gen_DB_1_2nd[[i]] <- read_excel('Imputed_Databases_Validation_PT_version.xlsx', sheet = excSheet[[i]])
View(imp_gen_DB_1_2nd[[1]])

##Generates a DB that includes pooled estimates of the 20 DBs included in the file Imputed_Databases_Validation_PT_version based on Rubin’s (1987) rules.
para_merge_Trans <- NULL
para_merge_BD1 <- NULL
para_merge_BD2 <- NULL
para_merge_Oringinal_DB_1 <- DB_1[,-c(1,7)]
para_merge_Oringinal_DB_2 <- DB_2[,-c(1)]
for (i in 1:20) para_merge_Trans[[i]] <- read_excel('BDs_imput2.xlsx', sheet = excSheet[[i]])
for (i in 1:20) para_merge_BD1[[i]] <- para_merge_Trans[[i]][,c(2:6,8)]
for (i in 1:20) para_merge_BD2[[i]] <- para_merge_Trans[[i]][,c(9:11)]
subject_id <- para_merge_Trans[[1]][,c(1)]
SymSpn <- DB_1[,c(7)]
RAPM <- DB_2[,c(3)]
para_merge_BD1 <- miceadds::datalist2mids(para_merge_BD1)
merged_imp_gen_DB_1_2nd <- merge_imputations(para_merge_Oringinal_DB_1,para_merge_BD1,ori = NULL,summary = c("none", "dens", "hist", "sd"),filter = NULL)
merged_imp_gen_DB_1_2nd <- add_column(merged_imp_gen_DB_1_2nd, SymSpn,.after=5)
merged_imp_gen_DB_1_2nd <- add_column(merged_imp_gen_DB_1_2nd, subject_id,.before=1)
para_merge_BD2 <- miceadds::datalist2mids(para_merge_BD2)
merged_imp_gen_DB_2_2nd <- merge_imputations(para_merge_Oringinal_DB_2,para_merge_BD2,ori = NULL,summary = c("none", "dens", "hist", "sd"),filter = NULL)
merged_imp_gen_DB_2_2nd <- add_column(merged_imp_gen_DB_2_2nd, RAPM,.after=1)
merged_imp_gen_DB_1_2nd <- add_column(merged_imp_gen_DB_1_2nd, merged_imp_gen_DB_2_2nd,.after=8)
merged_imp_gen <- merged_imp_gen_DB_1_2nd[-c(149),]
View(merged_imp_gen)
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
##4 - Assessment of univariate and multivariate normality in the distribution of the WM and Gf scores.

##Univariate and multivariate normality were assessed in each of the 20 imputed datasets included in the file Imputed_Databases_Validation_PT_version.xlsx.
##We considered the following criteria to evaluate univariate normality: Skewness < 2; Kurtosis < 7.
##We considered the following criteria to evaluate multivariate normality: Kurtosis<3, or significant Mardia's skewness coefficient (p-value > 0.05).

paraNomr <- NULL
MultNormalVar <- NULL
###Generated 20 DBs that only include the scores of the WM and the Gf tasks.
for(i in 1:20) paraNomr[[i]] <- imp_gen_DB_1_2nd[[i]][,-c(1,12,13,14,15)]
###Computes Mardia's Skewness coefficients and assess the skewness and kurtosis values of each of the 20 BDs. 
for(i in 1:20) MultNormalVar[[i]]<- mvn(paraNomr[[i]], mvnTest = "mardia")
MultNormalVar[1]

##Generates two columns displaying pooled estimates of skewness and kurtosis for the distribution of each WM and Gf task
##This values are presented in Table 1 of the article by Monteiro et al. (2024).
Megred_MultNormVar <- merged_imp_gen[,-c(1)]
Megred_MultNormVar <- mvn(merged_imp_gen,mvnTest = "mardia")
Megred_MultNormVar <- data.frame(Megred_MultNormVar$Descriptives)
Megred_MultNormVar <- Megred_MultNormVar[-c(1),c(9,10)]
View(Megred_MultNormVar)
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
###5 - Computation of the reliability estimates (Cronbach's alpha and McDonalds' Omega).

##This section utilizes the information provided in the Excel file titled 'DB_alphas_omegas_tasks' to compute Cronbach's alpha and McDonald's Omega for each task.
##In this file, the score of every participant in every trial of each WM and Gf task is labeled as 1 (correct) or 0 (incorrect)
##Cronbach's alpha and McDonalds' Omega are computed at the level of individual trials.

###Reading Span
original_RS <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "Reading_Span")
original_RS <- original_RS[,-c(1)]
original_RS <- original_RS[-c(82,150),]
View(original_RS)

###Cronbach's Alpha
alpha_original_RS <- alpha(original_RS)
alpha_original_RS_CIs <- alpha.ci(original_RS,n.obs = 162,n.var = 60,digits = 2)
View(alpha_original_RS_CIs)

###McDonald's W
omega_original_RS <- omega(original_RS,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###Number Series
original_NSer <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "Number_Series")
original_NSer <- original_NSer[,-c(1)]
original_NSer <- original_NSer[-c(82,150),]
original_NSer_sItem2 <- original_NSer[,-c(2)]
View(original_NSer_sItem2)

###Cronbach's Alpha
alpha_original_NSer_sItem2 <- alpha(original_NSer_sItem2)
alpha_original_NSer_sItem2_CIs <- alpha.ci(original_NSer_sItem2,n.obs = 162,n.var = 15,digits = 2)
View(alpha_original_NSer_sItem2_CIs)

###McDonald's W
omega_original_sItem2 <- omega(original_NSer_sItem2,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###NBack
original_NBack <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "N_Back")
original_NBack <- original_NBack[,-c(1)]
original_NBack <- original_NBack[-c(82,150),]
View(original_NBack)

###Cronbach's Alpha
alpha_original_NBack <- alpha(original_NBack)
alpha_original_NBack_CIs <- alpha.ci(original_NBack,n.obs = 162,n.var = 12,digits = 2)
View(alpha_original_NBack_CIs)

###McDonald's W
omega_original_NBack <- omega(original_NBack,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###RAPM
original_RAPM <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "RAPM")
original_RAPM <- original_RAPM[,-c(1)]
original_RAPM <- original_RAPM[-c(82,150),]
View(original_RAPM)

###Cronbach's Alpha
alpha_original_RAPM <- alpha(original_RAPM)
alpha_original_RAPM_CIs <- alpha.ci(original_RAPM,n.obs = 162,n.var = 18,digits = 2)
View(alpha_original_RAPM_CIs)

###McDonald's W
omega_original_RAPM <- omega(original_RAPM,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###Operation Span
original_OS <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "Operation_Span")
original_OS <- original_OS[,-c(1)]
original_OS <- original_OS[-c(82,150),]
View(original_OS)

###Cronbach's Alpha
alpha_original_OS <- alpha(original_OS)
alpha_original_OS_CIs <- alpha.ci(original_OS,n.obs = 162,n.var = 60,digits = 2)
View(alpha_original_OS_CIs)

###McDonald's W
omega_original_OS <- omega(original_OS,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###Binding Task
original_BT <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "Binding_Task")
original_BT <- original_BT[,-c(1)]
original_BT <- original_BT[-c(82,150),]
View(original_BT)

###Cronbach's Alpha
alpha_original_BT <- alpha(original_BT)
alpha_original_BT_CIs <- alpha.ci(original_BT,n.obs = 162,n.var = 16,digits = 2)
View(alpha_original_BT_CIs)

###McDonald's W
omega_original_BT <- omega(original_BT,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###Multimodal Span
original_MS <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "Multimodal_Span")
original_MS <- original_MS[,-c(1)]
original_MS <- original_MS[-c(82,150),]
View(original_MS)

###Cronbach's Alpha
alpha_original_MS <- alpha(original_MS)
alpha_original_MS_CIs <- alpha.ci(original_MS,n.obs = 162,n.var = 5,digits = 2)
View(alpha_original_MS_CIs)

###McDonald's W
omega_original_MS <- omega(original_MS,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###Letter Series
original_LSer <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "Letter_Series")
original_LSer <- original_LSer[,-c(1)]
original_LSer <- original_LSer[-c(82,150),]
View(original_LSer)

###Cronbach's Alpha
alpha_original_LSer <- alpha(original_LSer)
alpha_original_LSer_CIs <- alpha.ci(original_LSer,n.obs = 162,n.var = 15,digits = 2)
View(alpha_original_LSer_CIs)

###McDonald's W
omega_original_LSer <- omega(original_LSer,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###Symmetry Span
original_SS <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "Symmetry Span")
original_SS <- original_SS[,-c(1)]
original_SS <- original_SS[-c(82,150),]
View(original_SS)

###Cronbach's Alpha
alpha_original_SS <- alpha(original_SS)
alpha_original_SS_CIs <- alpha.ci(original_SS,n.obs = 162,n.var = 60,digits = 2)
View(alpha_original_SS_CIs)

###McDonald's W
omega_original_SS <- omega(original_SS,nfactors = 1,fm="ml")

#####################################################################################################################################################################
###WM Updating Task
original_WMU <- read_excel("DB_alphas_omegas_tasks.xlsx",sheet = "WMU Task")
original_WMU <- original_WMU[,-c(1)]
original_WMU <- original_WMU[-c(82,150),]
View(original_WMU)

###Cronbach's Alpha
alpha_original_WMU <- alpha(original_WMU)
alpha_original_WMU_CIs <- alpha.ci(original_WMU,n.obs = 162,n.var = 12,digits = 2)
View(alpha_original_WMU_CIs)

###McDonald's W
omega_original_WMU <- omega(original_WMU,nfactors = 1,fm="ml")

####################################################################################################################################################################
##Generates the columns with the values of Cronbach's alpha and McDonald's Omega that will be used appended to the table with descriptive statistics.

##Column containing the Cronbach's alpha for each task.
aRS <- alpha_original_RS$total$raw_alpha
aNB <- alpha_original_NBack$total$raw_alpha
aOS <- alpha_original_OS$total$raw_alpha
aBT <- alpha_original_BT$total$raw_alpha
aMS <- alpha_original_MS$total$raw_alpha
aSS <- alpha_original_SS$total$raw_alpha
aWMU <- alpha_original_WMU$total$raw_alpha
aNSer <- alpha_original_NSer_sItem2$total$raw_alpha
aRAPM <- alpha_original_RAPM$total$raw_alpha
aLSer <- alpha_original_LSer$total$raw_alpha

col_alphas <- data.frame(c(aRS,aNB,aOS,aBT,aMS,aSS,aWMU,aNSer,aRAPM,aLSer))
View(col_alphas)

##Column containing McDonalds' Omega for each task.
wRS <- omega_original_RS$omega.tot
wNB <- omega_original_NBack$omega.tot
wOS <- omega_original_OS$omega.tot
wBT <- omega_original_BT$omega.tot
wMS <- omega_original_MS$omega.tot
wSS <- omega_original_SS$omega.tot
wWMU <- omega_original_WMU$omega.tot
wNSer <- omega_original_sItem2$omega.tot
wRAPM <- omega_original_RAPM$omega.tot
wLSer <- omega_original_LSer$omega.tot

col_omegas <- data.frame(c(wRS,wNB,wOS,wBT,wMS,wSS,wWMU,wNSer,wRAPM,wLSer))
View(col_omegas)

################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
##6 - Computes several descriptive statistics (mean, St Dev, St Error, variance) based on pooled estimates of the scores in the WM and Gf tasks. 
##The results of this analysis are presented in Table 1 of the article written by Monteiro et al. (2024).

###Calculates the mean of the WM and Gf tasks and the respective covariance matrix.
View(paraNomr)
descriptive_stats <- fmi(paraNomr)

###Selects the diagonal of the covariance martix.
aux_calc_dev <- data.frame()
for(i in 1:10) aux_calc_dev[i,1] <- descriptive_stats$Covariances$coef[i,i]
###Calculates the St Dev for each WM and Gf task.
for(i in 1:10) aux_calc_dev[i,2] <- sqrt(aux_calc_dev[i,1])
###Calculates the St Error for each WM and Gf task.
for(i in 1:10) aux_calc_dev[i,3] <- aux_calc_dev[i,2]/sqrt(162)
View(aux_calc_dev)

###Generates a table with the descriptive statistcs.
descriptive_stats <- descriptive_stats$Means$coef
descriptive_stats <- data.frame(descriptive_stats)
descriptive_stats <- add_column(descriptive_stats,aux_calc_dev[,2],.after=1)
descriptive_stats <- add_column(descriptive_stats,aux_calc_dev[,3],.after=2)
descriptive_stats <- add_column(descriptive_stats,aux_calc_dev[,1],.after=3)
TaskNames <- c("Reading Span","N-Back Task","Operation Span","Binding Task","Multimodal Span","Symmetry Span","WM Updating Task","Number Series","RAPM","Letter Series")
descriptive_stats <- add_column(descriptive_stats,TaskNames,.before =1)
colnames(descriptive_stats) <- c("Task_Names","Mean","SD","SE","Var")
View(descriptive_stats)

###Computes the "Range" of values (minimum score - maximum score) for each WM and Gf task.
MaxMatrix <- matrix(data = NA, ncol = 10,nrow = 20)
for(i in 1:20) for(j in 1:10) MaxMatrix[i,j] <- max(paraNomr[[i]][,j])
MaxColumn <- NULL
for(i in 1:10) MaxColumn[i] <- max(MaxMatrix[,i])
MaxColumn <- data.frame(MaxColumn)
for(i in 1:10) MaxColumn[i,] <- round(MaxColumn[i,],digits = 2)
for(i in 1:10) MaxColumn[i,] <- toString(MaxColumn[i,])
View(MaxColumn)
MinMatrix <- matrix(data = NA, ncol = 10,nrow = 20)
for(i in 1:20) for(j in 1:10) MinMatrix[i,j] <- min(paraNomr[[i]][,j])
MinColumn <- NULL
for(i in 1:10) MinColumn[i] <- min(MinMatrix[,i])
MinColumn <- data.frame(MinColumn)
for(i in 1:10) MinColumn[i,] <- round(MinColumn[i,],digits = 2)
for(i in 1:10) MinColumn[i,] <- toString(MinColumn[i,])
View(MinColumn)
RangExpTasks <- MaxColumn
for(i in 1:10) RangExpTasks[i,] <- paste(MinColumn[i,],"-",MaxColumn[i,])
View(RangExpTasks)

##Generates a table similar to Table 1 of the article by Monteiro et al. (2024).
##This table includes descriptive statistics (Mean,	St Dev,	Range	Skewness,	Kurtosis) and reliability estimates of the WM and Gf measures. 
descriptive_stats <- descriptive_stats[,-c(4,5)]
descriptive_stats <- add_column(descriptive_stats, Megred_MultNormVar,.after  = 3)
descriptive_stats <- add_column(descriptive_stats,RangExpTasks,.after = 3)
descriptive_stats <- add_column(descriptive_stats,col_alphas,.after = 6)
descriptive_stats <- add_column(descriptive_stats,col_omegas,.after = 7)
colnames(descriptive_stats) <- c("Task Names","Mean","SD","Range","Skewness","Kurtosis","Alpha","Omega")
descriptive_stats <- descriptive_stats[c(1,3,6,2,7,5,4,10,8,9),]
rownames(descriptive_stats) <- NULL
View(descriptive_stats)
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
###7 - Generates a table with quartile, tercile, and median-based percentiles for the WM tasks as it is presented in Table 2 of the article by Monteiro et al. (2024).

percentils <- NULL
percentils <- data.frame(apply(merged_imp_gen[],2,quantile,probs=c(0.05,0.25,0.33,0.50,0.66,0.75,0.95)))
Task_Names_1 <- rownames(percentils)
percentils <- add_columns(percentils,Task_Names_1,.before =1)
percentils <- percentils[,-c(2)]
percentils <- percentils[,c(1,2,4,7,3,8,6,5,11,9,10)]
percentils <- data.frame(percentils)

for(i in 1:length(percentils$Reading.Span)) 
  for(j in 2:length(percentils[1,]))
    percentils[i,j] <- as.double(percentils[i,j])

percentils <- percentils[,c(1,5,8,6,3,10,4,7)]

TaskNames <- c("Percentile","Reading Span","Operation Span","Symmetry Span","N-Back Task","WM Updating Task","Multimodal Span","Binding Task")
colnames(percentils) <- TaskNames
View(percentils)
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
##8 - Computation of the correlation and covariation matrices of the WM tasks included in the OpenWMB.

##Generates a table similar to Table 3 presented in the article by Monteiro et al. (2024). 
head1<- NULL
pval1 <- NULL
corr_WMC <- miceadds::micombine.cor(mi.res=paraNomr, variables=c(1:10))
pval1 <- corr_WMC[,c(9)]
corr_WMC <- corr_WMC[,-c(4:11)]
corr_WMC <- spread(corr_WMC, variable1, r)
for(i in 1:10) corr_WMC[c(i),c(i+1)] <- 1.00
corr_WMC <- corr_WMC[,c(1,9,7,10,5,11,4,2)]
corr_WMC <- corr_WMC[c(8,6,9,4,10,3,1),]

rownames(corr_WMC) <- NULL
colnames(corr_WMC) <- c("Task","Reading Span","Operation Span","Symmetry Span","N-Back Task","WM Updating Task","Multimodal Span","Binding Task")
corr_WMC[,c(1)] <- c("Reading Span","Operation Span","Symmetry Span","N-Back Task","WM Updating Task","Multimodal Span","Binding Task")
View(corr_WMC)
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
##9 - Computation of the EFA that evaluated the underlying structure of the WM tasks. 

merged_imp_gen_for_efa <- merged_imp_gen[2:8]
View(merged_imp_gen_for_efa)

##Computes the descriptive statistics for the variables that will be subjected to EFA (Reading Span, Operation Span, Symmetry Span, N-back task, Updating task,
##Multimodal Span, and Binding Task).
summary(merged_imp_gen_for_efa)

##Calculates the Kaiser-Meyer-Olkin measure (KMO). 
##A KMO above .50 suggest that the characteristics of the data are suitable for factorial analysis (Kaiser & Rice, 1974). 
##The result of the KMO (.83) suggested that our data was adequate to conduct an EFA. 
KMO(merged_imp_gen_for_efa)

##Calculates Bartlett's test of sphericity. 
##A significant Bartlett's test of sphericity suggests that the characteristics of the data are suitable for factorial analysis.
##The results of Bartlett’s test of sphericity (χ2(21) = 301.53, p < .001) suggested that our data was adequate to conduct this analysis.
cortest.bartlett(merged_imp_gen_for_efa)

##Calculates eigenvalues
##We applied Kaiser’s criterion (1970) to decide how many factors to retain (eigenvalues > 1).
ev <- eigen(cor(merged_imp_gen_for_efa))
ev$values

##Computes a scree test to evaluate how many factors should be extracted.
scree(merged_imp_gen_for_efa, pc=FALSE)

##Computes a parallel analysis to evaluate how many factors should be extracted.
fa.parallel(merged_imp_gen_for_efa, fa="pc")

##The results of the scree test, the parallel analysis, and Kaiser’s criterion (1970) suggested that a single factor was enough to accommodate all WM tasks.

##Assesses the fit of the unifactorial structure of WMC and estimates the loadings of each task in this factor.
##Method of extraction = Maximum Likelihood, Rotation = Promax.
fit <- factanal(merged_imp_gen_for_efa, factors = 1, rotation="promax")
print(fit, digits=3, cutoff=0.4, sort=TRUE)
loads <- fit$loadings
fa.diagram(loads)     
##The unifactorial structure accounted for 38% of the variance in the WM tasks. 
##All tasks presented acceptable factor loadings (> .40).

##Computes Cronbach's alpha for the unifactorial structure of WMC.
alpha(merged_imp_gen_for_efa)
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
#10 - Computes the CFA that was used to confirm whether the general WMC factor extracted in the EFA presented an adequate 
#structure to accommodate all seven tasks included in the battery.

#Unifactorial model of WMC (labeled as Model 1 in the article by Monteiro et al. (2024)).
model1WMCGeneralFactor <-
  'WMC =~ NA*Reading_Span + Operation_Span + Symmetry_Span + NBack + WM_Updating_Task + Multimodal_Span + Binding_Task
  WMC ~~ 1*WMC'

#The function bellow fits the unifactorial model to the data.
fit_model1WMCGeneralFactor <- runMI(model1WMCGeneralFactor, 
                                    data=imp_gen_DB_1_2nd,
                                    fun="cfa")

##Computes the fit indexes of the model (e. g., chi-square, CFI, RMSEA,SRMR).
summary(fit_model1WMCGeneralFactor,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE)
fitmeasures(fit_model1WMCGeneralFactor,c("nnfi","aic"))

##########################
#Computes the implied pooled covariance matrix.
model_implied_1WMCGeneralFactor_cov <- fitted(fit_model1WMCGeneralFactor, omit.imps = c("no.conv", "no.se"))
View(data.frame(model_implied_1WMCGeneralFactor_cov))

#Computes the implied pooled correlation matrix.
model_implied_1WMCGeneralFactor_corr <- data.frame(model_implied_1WMCGeneralFactor_cov)
colnames(model_implied_1WMCGeneralFactor_corr) <- c("Reading_Span","Operation_Span","Symmetry_span","NBack","WM_Updating_Task","Multimodal_Span","Binding_Task")
model_implied_1WMCGeneralFactor_corr <- data.matrix(model_implied_1WMCGeneralFactor_corr)
model_implied_1WMCGeneralFactor_corr <- cov2cor(model_implied_1WMCGeneralFactor_corr)
View(model_implied_1WMCGeneralFactor_corr)

##Computes the standardized residual matrix of covariance. 
Std_residual_matrix_1WMCGenFactor <- cfa(model1WMCGeneralFactor,data = merged_imp_gen, estimator = "ML")
resid(Std_residual_matrix_1WMCGenFactor,type="standardized")

##########################
#Generates a graph similar to the one presented in Figure 2 of the article by Monteiro et al.(2024).
#This plot displays the standardized factor loadings, squared multiple correlations, and standardized error terms of model 1.
fit_model_test1 <- cfa(model1WMCGeneralFactor, 
                       data=imp_gen_DB_1_2nd[[1]],estimator="ML")
SEMPLOT <- semPlot::semPlotModel(fit_model_test1)
aaaa<- data.frame(summary(fit_model1WMCGeneralFactor,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE))
aaaa <- aaaa$std.all[-c(16:22)]
SEMPLOT@Pars$std <- aaaa
Rsq_1WMC <- summary(fit_model1WMCGeneralFactor,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE)
Rsq_1WMC <- data.frame(Rsq_1WMC)
for(i in 1:length(Rsq_1WMC[,"std.all"])) Rsq_1WMC[i,"RSq"] <- as.character(round(Rsq_1WMC[i,"std.all"]^2,2))
vecNames1WMC <- c("RS","OS","SS","NB","UT","MS","BT") 
vecRsq1WMC <- Rsq_1WMC[1:7,"RSq"]
vecIndi1WMC <- paste(vecNames1WMC," (",vecRsq1WMC,")")
vecIndi1WMC[8] <- "WMC"
vecIndi1WMC[5] <- "UT ( 0.60 )"
vecIndi1WMC <- c("RS (.47)","OS (.48)","SS (.46)","NB (.23)","UT (.60)","MS (.18)","BT (.18)", "WMC")
Path1WMC <- semPaths(SEMPLOT,'std',intercepts = TRUE, residuals = TRUE, layout = "tree",edge.color = "black",edge.label.color = "black",rotation = 4,sizeMan = 10,sizeLat = 12,
                     nodeLabels = vecIndi1WMC, optimizeLatRes = TRUE, shapeLat = "ellipse")
png(file= "Model1.png",width=4096, height=3277)
semPaths(SEMPLOT,'std',intercepts = TRUE, residuals = TRUE, layout = "tree", edge.color = "black",rotation = 4,sizeMan = 8,sizeLat = 10,
         nodeLabels = vecIndi1WMC, edge.width=0.7, fade = FALSE, fixedStyle = c("black"),freeStyle = c("black"),cut=1, ,edge.label.cex = 0.75,mar=c(4,4,4,4))
dev.off()
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
##11 - Computes the SEM that was used to assess the correlation between the unifactorial model of  WMC extracted in the EFA and the latent Gf factor derived 
##from the Letter_Series, the Number_Series, and the RAPM.

##Model that was used to assess the correlation between the unifactorial model of WMC and the Gf factor (labeled as Model 2 in the article by Monteiro et al. (2024)).
model_1GfFactor_1WMCFactor <- 'WMC =~ NA*Reading_Span + Operation_Span + Symmetry_Span + NBack + WM_Updating_Task + Multimodal_Span + Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the model to the data.
fit_model_1GfFactor_1WMCFactor <- runMI(model_1GfFactor_1WMCFactor, 
                                        data=imp_gen_DB_1_2nd,
                                        fun="sem")

#Computes the fit indexes of the model (e. g., chi-square, CFI, RMSEA,SRMR).
summary(fit_model_1GfFactor_1WMCFactor,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2")
fitmeasures(fit_model_1GfFactor_1WMCFactor,c("nfi","rmsea"))


##########################
##Computes the implied pooled covariance matrix.
model_implied_1GfFactor_1WMCFactor_cov <- fitted(fit_model_1GfFactor_1WMCFactor, omit.imps = c("no.conv", "no.se"))
View(data.frame(model_implied_1GfFactor_1WMCFactor_cov))

#Computes the implied pooled correlation matrix.
model_implied_1GfFactor_1WMCFactor_corr <- data.frame(model_implied_1GfFactor_1WMCFactor_cov)
colnames(model_implied_1GfFactor_1WMCFactor_corr) <- c("Reading_Span","Operation_Span","Symmetry_span","NBack","WM_Updating_Task","Multimodal_Span","Binding_Task")
model_implied_1GfFactor_1WMCFactor_corr <- data.matrix(model_implied_1GfFactor_1WMCFactor_corr)
model_implied_1GfFactor_1WMCFactor_corr <- cov2cor(model_implied_1GfFactor_1WMCFactor_corr)
View(model_implied_1GfFactor_1WMCFactor_corr)

###Computes the standardized residual matrix of covariance.
Std_residual_matrix_1GfFactor_1WMCFactor <- cfa(model_1GfFactor_1WMCFactor,data = merged_imp_gen, estimator = "ML")
resid(Std_residual_matrix_1GfFactor_1WMCFactor,type="standardized")

##########################
#Generates a graph similar to the one presented in Figure 2 of the article by Monteiro et al.(2024).
#This plot displays the standardized factor loadings, squared multiple correlations, and standardized error terms of model 2.
fit_model_test3 <- sem(model_1GfFactor_1WMCFactor, 
                       data=imp_gen_DB_1_2nd[[1]],estimator="ML")
SEMPLOT <- semPlot::semPlotModel(fit_model_test3)
aaaa<- data.frame(summary(fit_model_1GfFactor_1WMCFactor,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE))
aaaa <- aaaa$std.all[-c(24:34)]
aaaa2 <- aaaa
aaaa2[c(1:7)] <- rev(aaaa2[c(1:7)])
aaaa2[c(9:10)] <- rev(aaaa2[c(9:10)])
aaaa2[c(14:20)] <- rev(aaaa2[c(14:20)])
aaaa2[c(22:23)] <- rev(aaaa2[c(22:23)])
SEMPLOT@Pars$std <- aaaa2
Rsq_1WMC_1Gf <- summary(fit_model_1GfFactor_1WMCFactor,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE)
Rsq_1WMC_1Gf <- data.frame(Rsq_1WMC_1Gf)
for(i in 1:length(Rsq_1WMC_1Gf[,"std.all"])) Rsq_1WMC_1Gf[i,"RSq"] <- as.character(round(Rsq_1WMC_1Gf[i,"std.all"]^2,2))
vecNames1WMC_1Gf <- c("RS","OS","SS","NB","UT","MS","BT","RAPM","L_Ser","N_Ser","Gf") 
vecRsq_1WMC_1Gf <- Rsq_1WMC_1Gf[1:11,"RSq"]
vecIndi1WMC_1Gf <- paste(vecNames1WMC_1Gf," (",vecRsq_1WMC_1Gf,")")
vecIndi1WMC_1Gf[12] <- "WMC"
vecIndi1WMC_1Gf[6] <- "MS ( 0.20 )"
vecIndi1WMC_1Gf <- c("BT (.21)","MS (.20)","UT (.65)","NB (.23)","SS (.43)","OS (.46)","RS (.42)","RAPM (.37)","NSer (.45)","LSer (.49)","WMC","Gf")
vecIndi1WMC_1Gf
semPaths(SEMPLOT,'std',intercepts = TRUE, residuals = TRUE, layout = "tree",edge.color = "black")
png(file= "Model2.png",width=4096, height=3277)
semPaths(SEMPLOT,'std',intercepts = TRUE, residuals = TRUE, layout = "tree", edge.color = "black",rotation = 2,sizeMan = 9,sizeLat = 11, optimizeLatRes = TRUE,
         nodeLabels = vecIndi1WMC_1Gf, edge.width=0.7, fade = FALSE, fixedStyle = c("black"),freeStyle = c("black"),cut=1, edge.label.cex = 0.75, mar = c(5,5,5,5))
dev.off()
################################################################################################################################################################
#
#
#
#
###############################################################################################################################################################
#####12 - Permutation analysis.

##This section contains the code that was used to compute the permutation analysis used to test which administration method yielded the best estimate of WMC: 
##employing (1) a single WM task, (2) a homogeneous WMC factor (based on multiple tasks from the same para-digm), or (3) a heterogeneous WMC factor (derived from 
##triplets of tasks from different paradigms). To test this, we compared the amount of variance shared between the Gf factor (derived from the Letter_Series, 
##the Number_Series, and the RAPM) and all possible combinations of single WM tasks, homogeneous, and heterogeneous WMC factors.

parafinaltablePerm <- data.frame()
parafinaltablePvalue <- data.frame()

model_names_a <- c("RS (ST)","OS (ST)","SS (ST)","NB (ST)","UT (ST)","MS (ST)","BT (ST)","RS-OS-SS (HoF)","NB-UT (HoF)","MS-BT (HoF)","RS-NB-MS (HeF)",
                   "RS-NB-BT (HeF)","RS-UT-MS (HeF)","RS-UT-BT (HeF)","OS-NB-MS (HeF)","OS-NB-BT (HeF)","OS-UT-MS (HeF)","OS-UT-BT (HeF)","SS-NB-MS (HeF)",
                   "SS-NB-BT (HeF)","SS-UT-MS (HeF)","SS-UT-BT (HeF)")
final_dataframe_a <- data.frame(model_names_a)

###########################################################################################################################################################
#Model fitted: RS (ST)
model_Permutation <- 'Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ Reading_Span
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data. to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[4]*aaaa$std.all[4],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: OS (ST)
model_Permutation <- 'Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ Operation_Span
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data. to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[4]*aaaa$std.all[4],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: SS (ST)
model_Permutation <- 'Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ Symmetry_Span
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data. to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[4]*aaaa$std.all[4],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)
###############################################################################################################################
#Model fitted: NB (ST)
model_Permutation <- 'Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ NBack
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data..
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[4]*aaaa$std.all[4],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: UT (ST)
model_Permutation <- 'Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WM_Updating_Task
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[4]*aaaa$std.all[4],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: MS (ST)
model_Permutation <- 'Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ Multimodal_Span
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[4]*aaaa$std.all[4],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: BT (ST)
model_Permutation <- 'Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ Binding_Task
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[4]*aaaa$std.all[4],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: RS-OS-SS (HoF)
model_Permutation <- 'WMC =~ NA*Reading_Span + Operation_Span + Symmetry_Span
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: NB-UT (HoF)
model_Permutation <- 'WMC =~ a*NBack + a*WM_Updating_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2")
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[6]*aaaa$std.all[6],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)


###############################################################################################################################
#Model fitted: MS-BT (HoF)
model_Permutation <- 'WMC =~ a*Multimodal_Span + a*Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[6]*aaaa$std.all[6],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: RS-NB-MS (HeF)
model_Permutation <- 'WMC =~ NA*Reading_Span + NBack + Multimodal_Span
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: RS-NB-BT (HeF)
model_Permutation <- 'WMC =~ NA*Reading_Span + NBack + Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: RS-UT-MS (HeF)
model_Permutation <- 'WMC =~ NA*Reading_Span + WM_Updating_Task + Multimodal_Span
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: RS-UT-BT (HeF)
model_Permutation <- 'WMC =~ NA*Reading_Span + WM_Updating_Task + Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: OS-NB-MS (HeF)
model_Permutation <- 'WMC =~ NA*Operation_Span + NBack + Multimodal_Span
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: OS-NB-BT (HeF)
model_Permutation <- 'WMC =~ NA*Operation_Span + NBack + Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: OS-UT-MS (HeF)
model_Permutation <- 'WMC =~ NA*Operation_Span + WM_Updating_Task + Multimodal_Span
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: OS-UT-BT (HeF)
model_Permutation <- 'WMC =~ NA*Operation_Span + WM_Updating_Task + Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: SS-NB-MS (HeF)
model_Permutation <- 'WMC =~ NA*Symmetry_Span + NBack + Multimodal_Span
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: SS-NB-BT (HeF)
model_Permutation <- 'WMC =~ NA*Symmetry_Span + NBack + Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: SS-UT-MS (HeF)
model_Permutation <- 'WMC =~ NA*Symmetry_Span + WM_Updating_Task + Multimodal_Span
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
#Model fitted: SS-UT-BT (HeF)
model_Permutation <- 'WMC =~ NA*Symmetry_Span + WM_Updating_Task + Binding_Task
              Gf =~ NA*RAPM + Letter_Series + Number_Series
              Gf ~~ WMC
              WMC ~~ 1*WMC
              Gf ~~ 1*Gf'

#The function bellow fits the SEM model to the data.
fit_model_Permutation <- runMI(model_Permutation, 
                               data=imp_gen_DB_1_2nd,
                               fun="sem")

##Computes the fit indexes of the model (R^2, chi-square, CFI, RMSEA,SRMR). 
##These fit indexes are displayed in Table 4 of the article by Monteiro et al. (2024).
aaaa <- data.frame(summary(fit_model_Permutation,fit.measures = TRUE, standardized = TRUE,rsquare = TRUE,test="D2"))
aaaa2 <- aaaa
aaaa <- round(aaaa$std.all[7]*aaaa$std.all[7],2)
bbbb <- fitmeasures(fit_model_Permutation,c("all"))
bbbb <- c(bbbb[['chisq']],bbbb[['pvalue']],(bbbb[['chisq']]/bbbb[['df']]),bbbb[['cfi']],bbbb[['rmsea']],bbbb[['srmr']])
bbbb[1:4] <- round(bbbb[1:4],2)
bbbb[5:6] <- round(bbbb[5:6],3)
aaaa <- c(aaaa,bbbb)

parafinaltablePerm <- rbind(parafinaltablePerm,aaaa)
parafinaltablePvalue <- rbind(parafinaltablePvalue,aaaa2)

###############################################################################################################################
##Generates a table displaying the fit indices of all models estimated in the permutation analysis. This table resembles Table 4 
##from the article by Monteiro et al. (2024). However, this version of the table is not sorted based on the amount of variance 
##shared between the WMC and Gf factors (R^2)
FinaltablePerm <- cbind(final_dataframe_a,parafinaltablePerm)
colnames(FinaltablePerm) <- c("model","R2","chisq","p","chisq/df","CFI","RMSEA","SRMR")
View(FinaltablePerm)
