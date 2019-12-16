#####
# created by Tianchen Qian on 2019.12.16
#
# This code illustrates the usage of estimator_EMEE() function
# by first creating a data set via dgm_binary_uniform_covariate()
# then using estimator_EMEE() to estimate the effect moderation

source("dgm_demo.R")
source("estimator_EMEE.R")

set.seed(123)
dta <- dgm_demo(sample_size = 100, total_T = 30)
dta$S2 <- dta$S^2

str(dta)
# 'data.frame':	3000 obs. of  9 variables:
# $ userid   : int  1 1 1 1 1 1 1 1 1 1 ...
# $ day      : int  1 2 3 4 5 6 7 8 9 10 ...
# $ Y        : int  0 0 0 1 0 0 0 0 0 1 ...
# $ A        : int  1 1 1 0 0 1 0 1 1 0 ...
# $ S        : num  0.288 0.785 0.237 0.924 0.859 ...
# $ prob_Y   : num  0.31 0.462 0.298 0.354 0.343 ...
# $ prob_Y_A0: num  0.258 0.33 0.251 0.354 0.343 ...
# $ prob_A   : num  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...
# $ S2       : num  0.0827 0.6156 0.0563 0.8532 0.7372 ...

summary(dta)
#     userid            day             Y                A                S                 prob_Y         prob_Y_A0          prob_A          S2        
# Min.   :  1.00   Min.   : 1.0   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000653   Min.   :0.2233   Min.   :0.2231   Min.   :0.5   Min.   :0.0000  
# 1st Qu.: 25.75   1st Qu.: 8.0   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.2539757   1st Qu.:0.2700   1st Qu.:0.2533   1st Qu.:0.5   1st Qu.:0.0645  
# Median : 50.50   Median :15.5   Median :0.0000   Median :0.0000   Median :0.4934676   Median :0.3152   Median :0.2856   Median :0.5   Median :0.2435  
# Mean   : 50.50   Mean   :15.5   Mean   :0.3267   Mean   :0.4993   Mean   :0.4955589   Mean   :0.3324   Mean   :0.2888   Mean   :0.5   Mean   :0.3275  
# 3rd Qu.: 75.25   3rd Qu.:23.0   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:0.7443963   3rd Qu.:0.3669   3rd Qu.:0.3237   3rd Qu.:0.5   3rd Qu.:0.5541  
# Max.   :100.00   Max.   :30.0   Max.   :1.0000   Max.   :1.0000   Max.   :0.9994656   Max.   :0.5486   Max.   :0.3678   Max.   :0.5   Max.   :0.9989 

estimator <- estimator_EMEE(
    dta = dta,
    id_varname = "userid",
    decision_time_varname = "day",
    treatment_varname = "A",
    outcome_varname = "Y",
    control_varname = "S",
    moderator_varname = "S",
    rand_prob_varname = "prob_A"
)

print(estimator)

# Output:
#
# $beta_hat
# Intercept          S 
# 0.20196153 0.06645613 
# 
# $alpha_hat
# Intercept          S 
# -1.5898129  0.6601146 
# 
# $beta_se
# Intercept         S 
# 0.1137064 0.1670016 
# 
# $alpha_se
# Intercept          S 
# 0.08287128 0.12067152 
# 
# $beta_se_adjusted
# Intercept         S 
# 0.1137064 0.1670016 
# 
# $alpha_se_adjusted
# Intercept          S 
# 0.08287128 0.12067152 
# 
# $varcov
# [,1]         [,2]         [,3]         [,4]
# [1,]  0.006867649 -0.008967458 -0.006870902  0.008737748
# [2,] -0.008967458  0.014561616  0.009256539 -0.014397326
# [3,] -0.006870902  0.009256539  0.012929146 -0.017292360
# [4,]  0.008737748 -0.014397326 -0.017292360  0.027889522
# 
# $varcov_adjusted
# [,1]         [,2]         [,3]        [,4]
# [1,]  0.007026684 -0.009176660 -0.007026827  0.00893808
# [2,] -0.009176660  0.014901570  0.009467687 -0.01472736
# [3,] -0.007026827  0.009467687  0.013217571 -0.01768172
# [4,]  0.008938080 -0.014727365 -0.017681717  0.02852223
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
# [1] -3.047405e-08 -7.117731e-09 -1.252109e-10  3.279074e-11