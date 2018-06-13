###############################################################################
# Generate Synthetic Data In Texas Assessment Format
# Date: 06/08/2018
# Author: Jared E. Knowles
# Prepared for OpenSDP
################################################################################

## Identify the data structure needed 
## File - student grade 3-8
## grade_level 
## school_code
## sid
## male
## race_ethnicity
## eco_dis
## title_1
## migrant
## lep
## iep
## rdg_ss
## math_ss
## wrtg_ss
## composition
## wrtg_perc

## Install the synthesizer to generate the data
## This step is optional if you already have it installed
## Current package depends on this fork of the simglm package
## Uncomment to use
devtools::install_github("jknowles/simglm")
## Install the OpenSDP data synthesizer
## Uncomment to use
# devtools::install_github("OpenSDP/OpenSDPsynthR")

## 

library(OpenSDPsynthR)
set.seed(0525212) # set the seed

# The synthesizer needs some input paramaters
# As it is the defaults are not sufficient to give realistic assessment data
# These change those defaults to make the scores less deterministic

assess_adj <- sim_control()$assessment_adjustment

# Make scores spread out more
assess_adj$perturb_base <- 
  function (x, sd) 
  {
    mean_shift <- rnorm(1, sd = 3)
    y <- x + rnorm(1, mean_shift, sd * 0.8)
    return(y)
  }

# Get defaults
assess_sim_par <- OpenSDPsynthR::sim_control()$assess_sim_par
# Increase score variance
assess_sim_par$error_var <- 15
# Increase coefficient effects
assess_sim_par$fixed_param <- assess_sim_par$fixed_param * 10
assess_sim_par$lvl1_err_params$mean <- 1
assess_sim_par$lvl1_err_params$sd <- 10
# Set group level variances
assess_sim_par$random_param$random_var <- c(0.4, 0.75)
# Set the school-grade size ranges
assess_sim_par$unbalanceRange <- c(100, 420)

# Conduct the simulation
stu_pop <- simpop(50000L, seed = 0525212, 
                  control = sim_control(nschls = 12L, n_cohorts = 4L, 
                                        assessment_adjustment = assess_adj,
                                        assess_sim_par = assess_sim_par))

# Build analysis file from the datasets in the list produced by simpop
#
out_data <- dplyr::left_join(stu_pop$stu_assess, stu_pop$stu_year)
#
out_data <- out_data %>% select(-exit_type, -cohort_grad_year, - cohort_year, -enrollment_status, 
                                -grade_enrolled, -grade_advance, -ndays_attend, 
                                -ndays_possible)
out_data <- left_join(out_data, stu_pop$demog_master %>% 
                        select(sid, Sex, Race))
# Conver back to dataframe
out_data <- as.data.frame(out_data)

# Get sample model output to check relationships among variables
summary(lm(math_ss~rdg_ss + grade + frpl + ell + iep + gifted, data = out_data))

# Perturb by student to give student scores dependence on an unobserved student 
# talent - too deterministic still
out_data <- out_data %>% group_by(sid) %>% 
  mutate(talent = rnorm(1, 10, 20), 
         coef_t = rnorm(1, 10, 0.5),
         coef_a = rnorm(1, 5, 2),
         coef_z = rnorm(1, 1.5, 1)) %>% 
  mutate(coef_tb = coef_t + rnorm(1, 0, 1)) %>%
  ungroup %>% 
  mutate(rdg_ss = rdg_ss + coef_t*talent + coef_a * age + 3*age + rnorm(1, 25, 10), 
         math_ss = coef_z*rdg_ss + coef_tb*talent + 3*age + coef_a*age + rnorm(1, 25, 10)) %>% 
  select(-coef_t, -coef_tb, -coef_z, -coef_a,- talent) %>% ungroup %>% as.data.frame

# Fill in missing variables
out_data$migrant <- NA
out_data$wrtg_ss <- NA
out_data$composition <- NA
out_data$title_1 <- NA

# Define an export
export <- out_data %>% 
  select(grade, schid, sid, Sex, Race, frpl, title_1, migrant, ell, iep, rdg_ss, math_ss, 
         wrtg_ss, composition)

## Assign variable names
names(export) <- c("grade_level", "school_code", "sid", "male", "race_ethnicity", 
                   "eco_dis", "title_1", "migrant", "lep", "iep", "rdg_ss", 
                   "math_ss", "wrtg_ss", "composition")

# Save
save(export, file = "data/synth_texas.rda")


## Tests to evaluate the synthetic data
# summary({m1 <- lm(math_ss ~ rdg_ss, data = out_data)})
# summary({m2 <- lm(rdg_ss ~ math_ss, data = out_data)})
# 
# m1_b <- lm(math_ss_b ~ rdg_ss_b, data = out_data)
# m1 <- lm(math_ss ~ . , data = out_data[, -1])
