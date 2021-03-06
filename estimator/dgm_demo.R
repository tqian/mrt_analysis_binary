
# for binary outcome

# Tianchen Qian, 2019.12.19

# In this code, I constructed examples where:
# p_t is a repeating pattern of 0.3, 0.5, 0.7, 0.3, 0.5, 0.7, ...
# Availability is exogenous and random (with 0.8 probability being available at a time point)

# The baseline model is 
# log E(Y_{t+1} | A_t = 0, I_t = 1) = alpha_0 + alpha_1 * time / total_T
#                                     + alpha_2 * 1(time > total_T/2)
# The treatment effect model is log relative risk = beta_0 + beta_1 * time / total_T


expit <- function(x){
    return(exp(x)/(1+exp(x)))
}


dgm_demo <- function(sample_size, total_T) {
    
    alpha_0 <- - 1.5
    alpha_1 <- 0.5
    alpha_2 <- 0.3
    
    beta_0 <- 0.1
    beta_1 <- 0.3
    
    # With the above parameter specification, the range of success probability of Y would be
    # [exp(-1.5), exp(-1.5 + 0.5 + 0.3 + 0.1 + 0.3)] = [0.223, 0.741]
    
    df_names <- c("userid", "time", "time_var1", "time_var2", "Y", "A", "avail", "prob_Y", "prob_Y_A0", "prob_A")
    # time_var1 is time / total_T
    # time_var2 is 1(time > total_T/2)
    
    dta <- data.frame(matrix(NA, nrow = sample_size * total_T, ncol = length(df_names)))
    names(dta) <- df_names
    
    dta$userid <- rep(1:sample_size, each = total_T)
    dta$time <- rep(1:total_T, times = sample_size)
    dta$time_var1 <- dta$time / total_T
    dta$time_var2 <- as.numeric(dta$time > (total_T/2))
    
    for (t in 1:total_T) {
        # row index for the rows corresponding to time t for every subject
        row_index <- seq(from = t, by = total_T, length = sample_size)
        
        dta$avail[row_index] <- rbinom(sample_size, 1, 0.8) # 0.8 probability to be available
        
        dta$prob_A[row_index] <- ifelse(t %% 3 == 1, 0.3, ifelse(t %% 3 == 2, 0.5, 0.7))
        dta$A[row_index] <- rbinom(sample_size, 1, dta$prob_A[row_index]) * dta$avail[row_index] # A can only be 1 if avail = 1
        # We keep prob_A as-is for those observations with avail = 0. It's OK because those prob_A won't be used in the estimation.
        
        dta$prob_Y_A0[row_index] <- exp(alpha_0 + alpha_1 * dta$time_var1[row_index] + alpha_2 * dta$time_var2[row_index])
        dta$prob_Y[row_index] <- dta$prob_Y_A0[row_index] * exp(dta$A[row_index] * (beta_0 + beta_1 * dta$time_var1[row_index]))
        dta$Y[row_index] <- rbinom(sample_size, 1, dta$prob_Y[row_index])
    }
    
    return(dta)
}


# try out the range of Y
if (0) {
    set.seed(123)
    dta <- dgm_demo(100, 30)
    summary(dta$prob_Y)
    summary(dta$prob_A)
    summary(dta)
}