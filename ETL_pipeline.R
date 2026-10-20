# Installing libraries
if (!require("pacman")){
  install.packages("pacman")}
pacman::p_load(
  'janitor',
  'tidyverse',
  'data.table',
  'skimr',
  'tictoc',
  'Microsoft365R',
  'ggvenn',
  'quarto',
  'targets'
)

## 1. Importing the data
# Reading file
raw_qualtrics_data <- read.csv("C:/Users/k2582493/Downloads/AI+scribe+pre-implementation+clinician+survey_October+8,+2026_20.42.csv")

## 2. Cleaning the data
# Deleting Columns and rows
clean_qualtrics_data_1 <- raw_qualtrics_data %>%
  select(-c(StartDate,EndDate,Status,Duration..in.seconds.,RecordedDate,DistributionChannel,UserLanguage)) %>%
  slice(-2) %>%
  row_to_names(1) %>%
  as_tibble()

# Renaming columns
clean_qualtrics_data_2 <- clean_qualtrics_data_1 %>%
  rename(
    #Q2
    'NHS trust' = 'Which NHS trusts will you be using the AI scribe as part of this programme? (Select all that apply)',
    #Q3
    'Clinical speciality' = 'What is your clinical speciality or service? (Select one)',
    #Q15
    'Occupational group' = 'What is your occupational group?',
    #Q4
    'Mins spent Direct patient care' = 'Based on your most recent consultation without an AI scribe, how many minutes (approximately) did you spend on the following? - Direct patient care

(talking with, examining, or listening to the patient, with the patient as the primary focus and no multitasking)',
    'Mins spent In consultation documents' = 'Based on your most recent consultation without an AI scribe, how many minutes (approximately) did you spend on the following? - In‑consultation documentation with the patient present

(typing notes, placing orders, reviewing charts or scans, or other documentation activities)',
    'Mins spent Admin tasks' = 'Based on your most recent consultation without an AI scribe, how many minutes (approximately) did you spend on the following? - Administrative tasks immediately before or after the patient

(referrals, forms, discharge summaries, follow‑up documentation, reviewing results, telephone appointments, other pre or post consultation activities)',
    'Mins spent Follow-up activities' = 'Based on your most recent consultation without an AI scribe, how many minutes (approximately) did you spend on the following? - Further follow-up activities significantly after the consultation

(on your break, at the end of the clinic or outside of work hours)',
    #Q5
    'Statement1 Completing clinical documentation is mentally demanding' = 'For each statement, please select the option that best reflects your experience without an AI scribe. - Completing clinical documentation is mentally demanding',
    'Statement2 I feel rushed or time pressured while completing the clinical documentation' = 'For each statement, please select the option that best reflects your experience without an AI scribe. - I feel rushed or time pressured while completing the clinical documentation',
    'Statement3 I am satisfied with the quality of clinical documentation produced' = 'For each statement, please select the option that best reflects your experience without an AI scribe. - I am satisfied with the quality of clinical documentation produced',
    'Statement4 Completing the clinical documentation requires a lot of effort to meet the required standard' = 'For each statement, please select the option that best reflects your experience without an AI scribe. - Completing the clinical documentation requires a lot of effort to meet the required standard',
    'Statement5 I feel frustrated, stressed, or irritated while completing clinical documentation' = 'For each statement, please select the option that best reflects your experience without an AI scribe. - I feel frustrated, stressed, or irritated while completing clinical documentation',
    #Q16
    'Apply appropriate codes to outpatient procedures' = 'How easy or difficult is it to identify and apply the appropriate codes to outpatient procedures without an AI scribe?',
    #Q6
    'Main challenges' = 'What are the main challenges you face, if any, related to clinical documentation at this time without the use of an AI scribe?',
    #Q7
    'Often1 do you find clinical documentation emotionally exhausting' = 'Please indicate how often each applies to you in relation to clinical documentation without an AI scribe. - How often, if at all, do you find clinical documentation emotionally exhausting?',
    'Often2 do you feel burnt out because of clinical documentation tasks' = 'Please indicate how often each applies to you in relation to clinical documentation without an AI scribe. - How often, if at all, do you feel burnt out because of clinical documentation tasks?',
    'Often3 do you feel worn out at the end of your working day/shift because of clinical documentation' = 'Please indicate how often each applies to you in relation to clinical documentation without an AI scribe. - How often, if at all, do you feel worn out at the end of your working day/shift because of clinical documentation?',
    'Often4 do you not have enough energy for family and friends during leisure time due to clinical documentation' = 'Please indicate how often each applies to you in relation to clinical documentation without an AI scribe. - How often, if at all, do you not have enough energy for family and friends during leisure time due to clinical documentation?',
    'Often5 do you log on to complete clinical documentation outside of your scheduled hours' = 'Please indicate how often each applies to you in relation to clinical documentation without an AI scribe. - How often, if at all, do you log on to complete clinical documentation outside of your scheduled hours (e.g. before or after your shift, during breaks, or while on leave)?',
    #Q8
    'Balance between my work and home life' = 'I achieve a good balance between my work life and my home life without an AI scribe.',
    #Q9
    'UNPAID hours at work per week' = 'On average, how many additional UNPAID hours do you work per week for this organisation, over and above your contracted hours without an AI scribe?

This may include time worked before or after your scheduled hours, during breaks, on weekends, or while on leave.'
    )

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

# Applying the scales into the data
clean_qualtrics_data_3 <- clean_qualtrics_data_2 %>%
  mutate(
    across(
      c(`Statement1 Completing clinical documentation is mentally demanding`,`Statement2 I feel rushed or time pressured while completing the clinical documentation`,`Statement3 I am satisfied with the quality of clinical documentation produced`,`Statement4 Completing the clinical documentation requires a lot of effort to meet the required standard`,`Statement5 I feel frustrated, stressed, or irritated while completing clinical documentation`,`Balance between my work and home life`),
      ~ agree_scale[.]),
    across(
      c(`Often1 do you find clinical documentation emotionally exhausting`, `Often2 do you feel burnt out because of clinical documentation tasks`, `Often3 do you feel worn out at the end of your working day/shift because of clinical documentation`, `Often4 do you not have enough energy for family and friends during leisure time due to clinical documentation`, `Often5 do you log on to complete clinical documentation outside of your scheduled hours`),
    ~ freq_scale[.])
  )

## 3. Model






## 4. Plot
