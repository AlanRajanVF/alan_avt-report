## Functions ##

## Function 1 = Cleaning data
clean_data_fn <- function(raw_data) {

# Defining the scales
agree_scale <- c(
  "Strongly disagree" = 1,
  "Disagree" = 2,
  "Neither agree nor disagree" = 3,
  "Agree" = 4,
  "Strongly agree" = 5,
  "Prefer not to answer" = NA
)

freq_scale <- c(
  "Never" = 1,
  "Rarely" = 2,
  "Sometimes" = 3,
  "Often" = 4,
  "Always" = 5,
  "Prefer not to answer" = NA
)

# Deleting Columns and rows
clean_data <- raw_data %>%
  select(-c(StartDate,EndDate,Status,Duration..in.seconds.,RecordedDate,DistributionChannel,UserLanguage)) %>%
  slice(-(1:2)) %>%
  as_tibble() %>%
  
# Renaming columns
  rename(
    #Q2
    'NHS trust' = 'Q2',
    #Q3
    'Clinical speciality' = 'Q3',
    #Q15
    'Occupational group' = 'Q15',
    #Q4
    'Mins spent Direct patient care' = 'Q4_1',
    'Mins spent In consultation documents' = 'Q4_2',
    'Mins spent Admin tasks' = 'Q4_3',
    'Mins spent Follow-up activities' = 'Q4_4',
    #Q5
    'Statement1 Completing clinical documentation is mentally demanding' = 'Q5_1',
    'Statement2 I feel rushed or time pressured while completing the clinical documentation' = 'Q5_2',
    'Statement3 I am satisfied with the quality of clinical documentation produced' = 'Q5_3',
    'Statement4 Completing the clinical documentation requires a lot of effort to meet the required standard' = 'Q5_4',
    'Statement5 I feel frustrated, stressed, or irritated while completing clinical documentation' = 'Q5_5',
    #Q16
    'Apply appropriate codes to outpatient procedures' = 'Q16',
    #Q6
    'Main challenges' = 'Q6',
    #Q7
    'Often1 do you find clinical documentation emotionally exhausting' = 'Q7_1',
    'Often2 do you feel burnt out because of clinical documentation tasks' = 'Q7_2',
    'Often3 do you feel worn out at the end of your working day/shift because of clinical documentation' = 'Q7_3',
    'Often4 do you not have enough energy for family and friends during leisure time due to clinical documentation' = 'Q7_4',
    'Often5 do you log on to complete clinical documentation outside of your scheduled hours' = 'Q7_5',
    #Q8
    'Balance between my work and home life' = 'Q8',
    #Q9
    'UNPAID hours at work per week' = 'Q9'
  ) %>%
  
# Applying the scales into the data
  mutate(
    across(
      c(`Statement1 Completing clinical documentation is mentally demanding`,`Statement2 I feel rushed or time pressured while completing the clinical documentation`,`Statement3 I am satisfied with the quality of clinical documentation produced`,`Statement4 Completing the clinical documentation requires a lot of effort to meet the required standard`,`Statement5 I feel frustrated, stressed, or irritated while completing clinical documentation`,`Balance between my work and home life`),
      ~ unname(agree_scale[.])),
    across(
      c(`Often1 do you find clinical documentation emotionally exhausting`, `Often2 do you feel burnt out because of clinical documentation tasks`, `Often3 do you feel worn out at the end of your working day/shift because of clinical documentation`, `Often4 do you not have enough energy for family and friends during leisure time due to clinical documentation`, `Often5 do you log on to complete clinical documentation outside of your scheduled hours`),
      ~ unname(freq_scale[.]))
  )

return(clean_data)

}
