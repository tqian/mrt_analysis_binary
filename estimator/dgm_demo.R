
# for binary outcome

# Tianchen Qian, 2019.11.28

# In this code, I constructed examples where:
# p_t is constant (0.5)
# S_t (covariate) is Unif(0, 1)

# The baseline model is E(Y_{t+1} | H_t, A_t = 0) = alpha_0 + alpha_1 * S_t + alpha_2 * S_t^2
# The treatment effect model is log relative risk = beta_0 + beta_1 * S_t


expit <- function(x){
    return(exp(x)/(1+exp(x)))
}


dgm_demo <- function(sample_size, total_T) {
    
    alpha_0 <- - 1.5
    alpha_1 <- 0.5
    # alpha_2 <- 0.4
    alpha_2 <- 0
    
    beta_0 <- 0.1
    beta_1 <- 0.3
    
    # checking the range of probability
    if (0) {
        S <- seq(from = 0, to = 1, by = 0.001)
        summary(exp(alpha_0 + alpha_1 * S + alpha_2 * S^2))
        summary(exp(alpha_0 + alpha_1 * S + alpha_2 * S^2 + beta_0 + beta_1 * S))
    }
    
    df_names <- c("userid", "day", "Y", "A", "S", "prob_Y", "prob_Y_A0", "prob_A")
    
    dta <- data.frame(matrix(NA, nrow = sample_size * total_T, ncol = length(df_names)))
    names(dta) <- df_names
    
    dta$userid <- rep(1:sample_size, each = total_T)
    dta$day <- rep(1:total_T, times = sample_size)
    
    for (t in 1:total_T) {
        # row index for the rows corresponding to day t for every subject
        row_index <- seq(from = t, by = total_T, length = sample_size)
        
        
        dta$S[row_index] <- runif(sample_size)
        dta$prob_A[row_index] <- rep(0.5, sample_size)
        dta$A[row_index] <- rbinom(sample_size, 1, dta$prob_A[row_index])
        
        dta$prob_Y_A0[row_index] <- exp(alpha_0 + alpha_1 * dta$S[row_index] + alpha_2 * (dta$S[row_index])^2)
        dta$prob_Y[row_index] <- dta$prob_Y_A0[row_index] * exp(dta$A[row_index] * (beta_0 + beta_1 * dta$S[row_index]))
        dta$Y[row_index] <- rbinom(sample_size, 1, dta$prob_Y[row_index])
    }
    
    return(dta)
}

# beta_true <- c(0.1, 0.3)

# try out the range of Y
if (0) {
    set.seed(123)
    dta <- demo_dgm(100, 30)
    summary(dta$prob_Y)
    summary(dta$prob_A)
}