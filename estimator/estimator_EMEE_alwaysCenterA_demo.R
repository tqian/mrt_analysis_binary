#####
# created by Tianchen Qian on 2019.12.16
#
# This code illustrates the usage of estimator_EMEE() function
# by first creating a data set via dgm_binary_uniform_covariate()
# then using estimator_EMEE() to estimate the effect moderation

rm(list = ls())

source("dgm_demo.R")
source("estimator_EMEE_alwaysCenterA.R")

set.seed(123)
dta <- dgm_demo(sample_size = 100, total_T = 30)
dta$S2 <- dta$S^2

str(dta)
# 'data.frame':	3000 obs. of  10 variables:
# $ userid   : int  1 1 1 1 1 1 1 1 1 1 ...
# $ time     : int  1 2 3 4 5 6 7 8 9 10 ...
# $ time_var1: num  0.0333 0.0667 0.1 0.1333 0.1667 ...
# $ time_var2: num  0 0 0 0 0 0 0 0 0 0 ...
# $ Y        : int  0 0 0 1 0 0 0 0 0 1 ...
# $ A        : int  0 1 0 0 0 0 0 1 0 0 ...
# $ avail    : int  1 1 1 0 0 0 1 1 1 1 ...
# $ prob_Y   : num  0.227 0.26 0.235 0.239 0.243 ...
# $ prob_Y_A0: num  0.227 0.231 0.235 0.239 0.243 ...
# $ prob_A   : num  0.3 0.5 0.7 0.3 0.5 0.7 0.3 0.5 0.7 0.3 ...

summary(dta)
#     userid            time        time_var1         time_var2         Y                A              avail            prob_Y         prob_Y_A0          prob_A   
# Min.   :  1.00   Min.   : 1.0   Min.   :0.03333   Min.   :0.0   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.2269   Min.   :0.2269   Min.   :0.3  
# 1st Qu.: 25.75   1st Qu.: 8.0   1st Qu.:0.26667   1st Qu.:0.0   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:1.0000   1st Qu.:0.2671   1st Qu.:0.2550   1st Qu.:0.3  
# Median : 50.50   Median :15.5   Median :0.51667   Median :0.5   Median :0.0000   Median :0.0000   Median :1.0000   Median :0.3806   Median :0.3399   Median :0.5  
# Mean   : 50.50   Mean   :15.5   Mean   :0.51667   Mean   :0.5   Mean   :0.4023   Mean   :0.4087   Mean   :0.8067   Mean   :0.3976   Mean   :0.3493   Mean   :0.5  
# 3rd Qu.: 75.25   3rd Qu.:23.0   3rd Qu.:0.76667   3rd Qu.:1.0   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:0.4803   3rd Qu.:0.4419   3rd Qu.:0.7  
# Max.   :100.00   Max.   :30.0   Max.   :1.00000   Max.   :1.0   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :0.7408   Max.   :0.4966   Max.   :0.7  


estimator_1 <- estimator_EMEE_alwaysCenterA(
    dta = dta,
    id_varname = "userid",
    decision_time_varname = "day",
    treatment_varname = "A",
    outcome_varname = "Y",
    control_varname = c("time_var1", "time_var2"),
    moderator_varname = "time_var1",
    rand_prob_varname = "prob_A",
    avail_varname = "avail"
)

print(estimator_1)

# Output:
#
# $beta_hat
# Intercept  time_var1 
# 0.08502509 0.41260611 
# 
# $alpha_hat
# Intercept  time_var1  time_var2 
# -1.4358563  0.6935913  0.2647090 
# 
# $beta_se
# Intercept time_var1 
# 0.1250711 0.1810747 
# 
# $alpha_se
# Intercept  time_var1  time_var2 
# 0.06213613 0.17279523 0.10357601 
# 
# $beta_se_adjusted
# Intercept time_var1 
# 0.1266788 0.1834912 
# 
# $alpha_se_adjusted
# Intercept  time_var1  time_var2 
# 0.06290973 0.17500825 0.10478227 
# 
# $varcov
# [,1]         [,2]          [,3]          [,4]         [,5]
# [1,]  0.0038608991 -0.007512966  0.0020372384 -0.0005068623  0.001975262
# [2,] -0.0075129657  0.029858190 -0.0156664102  0.0026684541 -0.008951825
# [3,]  0.0020372384 -0.015666410  0.0107279889 -0.0008563799  0.003400086
# [4,] -0.0005068623  0.002668454 -0.0008563799  0.0156427857 -0.020762192
# [5,]  0.0019752617 -0.008951825  0.0034000860 -0.0207621925  0.032788043
# 
# $varcov_adjusted
# [,1]         [,2]          [,3]          [,4]         [,5]
# [1,]  0.0039576339 -0.007719062  0.0021002006 -0.0005141107  0.002021394
# [2,] -0.0077190622  0.030627887 -0.0160546827  0.0027628732 -0.009212018
# [3,]  0.0021002006 -0.016054683  0.0109793233 -0.0009021267  0.003511370
# [4,] -0.0005141107  0.002762873 -0.0009021267  0.0160475226 -0.021311424
# [5,]  0.0020213942 -0.009212018  0.0035113704 -0.0213114237  0.033669021
# 
# $dims
# $dims$p
# [1] 2
# 
# $dims$q
# [1] 3
# 
# 
# $f.root
# [1] -1.169334e-09 -3.069830e-10 -1.483697e-11  9.840937e-12 -3.374931e-12



estimator_2 <- estimator_EMEE_alwaysCenterA(
    dta = dta,
    id_varname = "userid",
    decision_time_varname = "day",
    treatment_varname = "A",
    outcome_varname = "Y",
    control_varname = "time_var1",
    moderator_varname = "time_var1",
    rand_prob_varname = "prob_A",
    avail_varname = "avail"
)

print(estimator_2)

# Output:
#
# $beta_hat
# Intercept  time_var1 
# 0.08135223 0.41501807 
# 
# $alpha_hat
# Intercept time_var1 
# -1.500389  1.081624 
# 
# $beta_se
# Intercept time_var1 
# 0.1254770 0.1819551 
# 
# $alpha_se
# Intercept  time_var1 
# 0.05853071 0.08249087 
# 
# $beta_se_adjusted
# Intercept time_var1 
# 0.1270777 0.1843535 
# 
# $alpha_se_adjusted
# Intercept  time_var1 
# 0.05919943 0.08349150 
# 
# $varcov
# [,1]         [,2]          [,3]         [,4]
# [1,]  0.0034258445 -0.004431643 -0.0003104024  0.001173695
# [2,] -0.0044316431  0.006804744  0.0014290304 -0.003956722
# [3,] -0.0003104024  0.001429030  0.0157444686 -0.020985280
# [4,]  0.0011736948 -0.003956722 -0.0209852803  0.033107648
# 
# $varcov_adjusted
# [,1]         [,2]          [,3]         [,4]
# [1,]  0.0035045721 -0.004537431 -0.0003066702  0.001194014
# [2,] -0.0045374309  0.006970831  0.0014562178 -0.004053448
# [3,] -0.0003066702  0.001456218  0.0161487409 -0.021536329
# [4,]  0.0011940137 -0.004053448 -0.0215363295  0.033986212
# 
# $dims
# $dims$p
# [1] 2
# 
# $dims$q
# [1] 2
# 
# 
# $f.root
# [1] -6.862022e-10 -1.849064e-10  9.668080e-12 -1.082802e-12



estimator_3 <- estimator_EMEE_alwaysCenterA(
    dta = dta,
    id_varname = "userid",
    decision_time_varname = "day",
    treatment_varname = "A",
    outcome_varname = "Y",
    control_varname = NULL,
    moderator_varname = NULL,
    rand_prob_varname = "prob_A",
    avail_varname = "avail"
)

print(estimator_3)

# Output:
#
# $beta_hat
# Intercept 
# 0.3581699 
# 
# $alpha_hat
# Intercept 
# -0.8874211 
# 
# $beta_se
# Intercept 
# 0.05151793 
# 
# $alpha_se
# Intercept 
# 0.02351753 
# 
# $beta_se_adjusted
# Intercept 
# 0.05205549 
# 
# $alpha_se_adjusted
# Intercept 
# 0.02374381 
# 
# $varcov
# [,1]          [,2]
# [1,]  0.0005530744 -0.0001758438
# [2,] -0.0001758438  0.0026540973
# 
# $varcov_adjusted
# [,1]          [,2]
# [1,]  0.0005637687 -0.0001776259
# [2,] -0.0001776259  0.0027097742
# 
# $dims
# $dims$p
# [1] 1
# 
# $dims$q
# [1] 1
# 
# 
# $f.root
# [1] -4.271644e-13 -6.929457e-15