#####
# created by Tianchen Qian on 2019.12.16
#
# This code illustrates the usage of estimator_EMEE() function
# by first creating a data set via dgm_demo()
# then using estimator_EMEE() to estimate the effect moderation

rm(list = ls())

source("dgm_demo.R")
source("estimator_EMEE.R")

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

estimator_1 <- estimator_EMEE(
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
# 0.08114495 0.42931332 
# 
# $alpha_hat
# Intercept  time_var1  time_var2 
# -1.4542369  0.4565905  0.2479836 
# 
# $beta_se
# Intercept time_var1 
# 0.1301265 0.1882975 
# 
# $alpha_se
# Intercept  time_var1  time_var2 
# 0.09699208 0.24074140 0.11167475 
# 
# $beta_se_adjusted
# Intercept time_var1 
# 0.1316436 0.1905454 
# 
# $alpha_se_adjusted
# Intercept  time_var1  time_var2 
# 0.09813404 0.24373700 0.11301692 
# 
# $varcov
# [,1]        [,2]          [,3]          [,4]         [,5]
# [1,]  0.009407463 -0.01848050  0.0036293844 -0.0088951364  0.013687095
# [2,] -0.018480501  0.05795642 -0.0213308200  0.0142698457 -0.028903632
# [3,]  0.003629384 -0.02133082  0.0124712494 -0.0009844053  0.004400843
# [4,] -0.008895136  0.01426985 -0.0009844053  0.0169329062 -0.022639280
# [5,]  0.013687095 -0.02890363  0.0044008428 -0.0226392795  0.035455933
# 
# $varcov_adjusted
# [,1]        [,2]          [,3]          [,4]        [,5]
# [1,]  0.009630289 -0.01893458  0.0037223411 -0.0090997258  0.01401250
# [2,] -0.018934578  0.05940773 -0.0218615441  0.0145917501 -0.02960477
# [3,]  0.003722341 -0.02186154  0.0127728233 -0.0009971158  0.00450630
# [4,] -0.009099726  0.01459175 -0.0009971158  0.0173300425 -0.02317355
# [5,]  0.014012503 -0.02960477  0.0045063005 -0.0231735513  0.03630756
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
# [1] -5.044321e-09 -1.294067e-09 -7.096608e-11  5.605593e-11 -1.437989e-11



estimator_2 <- estimator_EMEE(
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
# 0.07724047 0.43208244 
# 
# $alpha_hat
# Intercept  time_var1 
# -1.5152016  0.8233442 
# 
# $beta_se
# Intercept time_var1 
# 0.1305738 0.1892496 
# 
# $alpha_se
# Intercept  time_var1 
# 0.09111501 0.14787518 
# 
# $beta_se_adjusted
# Intercept time_var1 
# 0.1320913 0.1914970 
# 
# $alpha_se_adjusted
# Intercept  time_var1 
# 0.09215827 0.14965759 
# 
# $varcov
# [,1]        [,2]         [,3]        [,4]
# [1,]  0.008301946 -0.01228294 -0.008679038  0.01266260
# [2,] -0.012282945  0.02186707  0.012878998 -0.02242036
# [3,] -0.008679038  0.01287900  0.017049530 -0.02289098
# [4,]  0.012662597 -0.02242036 -0.022890976  0.03581542
# 
# $varcov_adjusted
# [,1]        [,2]         [,3]        [,4]
# [1,]  0.008493147 -0.01257380 -0.008880208  0.01296360
# [2,] -0.012573801  0.02239739  0.013183554 -0.02296359
# [3,] -0.008880208  0.01318355  0.017448123 -0.02343171
# [4,]  0.012963599 -0.02296359 -0.023431708  0.03667110
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
# [1] -3.552516e-09 -9.234264e-10  6.339861e-11 -4.210823e-12


estimator_3 <- estimator_EMEE(
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
# 0.3630815 
# 
# $alpha_hat
# Intercept 
# -1.069043 
# 
# $beta_se
# Intercept 
# 0.05128719 
# 
# $alpha_se
# Intercept 
# 0.03818096 
# 
# $beta_se_adjusted
# Intercept 
# 0.0518462 
# 
# $alpha_se_adjusted
# Intercept 
# 0.03857985 
# 
# $varcov
# [,1]         [,2]
# [1,]  0.001457786 -0.001494628
# [2,] -0.001494628  0.002630375
# 
# $varcov_adjusted
# [,1]         [,2]
# [1,]  0.001488405 -0.001526525
# [2,] -0.001526525  0.002688028
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
# [1] -5.609001e-11 -4.093174e-13
