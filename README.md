# mrt_analysis_binary

This repository contains data analysis and sample size calculation R code for MRTs with binary outcome.

This repository is maintained by Tianchen Qian and Eric Cohn.

## The estimators, and documentation

We have implemented two slightly different estimators in R, both can be used for estimating the causal excursion effect. The source code as well as demo of using them can be found in the folder "estimator/".

One estimator is called "estimator_EMEE". (EMEE stands for "estimator of marginal excursion effect".) This is the estimator described in the paper "Estimating time-varying causal excursion effect in mobile health with binary outcomes" (Tianchen Qian, Hyesun Yoo, Predrag Klasnja, Daniel Almirall, Susan A. Murphy. Biometrika, in revision.)

The other estimator is called "estimator_EMEE_alwaysCenterA". This is the estimator we will use in the sample size calculation paper. The difference from the previous estimator is that in this one, the treatment indicator is always centered --- namely, it is also centered in the blipping-down term. The current implementation of "estimator_EMEE_alwaysCenterA" assumes that (i) the randomization probability does not depend on H_t, and (ii) the control variables and moderators are all functions of time only. "estimator_EMEE" applies to much more general settings, but those settings are not relevant for the sample size calculation project.

Documentation of "estimator_EMEE_alwaysCenterA" can be found in "documentation/documentation_estimator_EMEE_alwaysCenterA.pdf". It includes the form of the estimator (as an estimating equation), its asymptotic variance, and small sample correction to the standard error estimator.

