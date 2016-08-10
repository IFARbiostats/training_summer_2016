source("manipulation/global.R")

# Read in data
# auth <- read_csv("manipulation/auth")
# db <- as_data_frame(redcap_read_oneshot(redcap_uri = auth$uri,
                                        # token = auth$token)$data)
# db_version <- as.character(Sys.time())

# test

db <- read_csv("data/ShinyDemoDatabase_generated_data_2016_03_25.csv")

# In the next few steps, you should split data into smaller pieces

## When the redcap project is large, you may want to read in only one
## piece of the database.
db <- db %>%
  mutate(
    redcap_event_name = sub("_arm_1", "", redcap_event_name)
  )

phone <- db %>%
  filter(redcap_event_name == "phone") %>%
  select(record_id:first_contact_complete)

# baseline <- db %>%
#   # set up a filter to only select rows with baseline data
#   filter(redcap_event_name %in% c("phone", "visit 1")) %>%
#   # Select variables that matters
#   select(studyid, redcap_event_name, something, something2, anotherthing)
# 
# test <- db %>%
#   # select relavent rows and columns
#   filter(redcap_event_name %in% c("visit 1", "visit 2", "visit 3")) %>%
#   select(studyid, redcap_event_name, test1_1:test1_5, test2, test3) %>%
#   # Perform some calculations
#   mutate(test1 = sum(test1_1, test1_2, test1_3, test1_4, test1_5,
#                      na.rm = T)) %>%
#   # downsize the data
#   select(studyid, redcap_event_name, test1, test2, test3)

# If if requires some complicated manipulation, you can put analytical
# code in a separate file and source it here. For example
# source("manipulation/baseline.R")

# After everything, you have the option to export a cleaned version of
# the data to somewhere. In many cases, you don't need to
# write(baseline, "data/baseline.csv")
# write(baseline, "data/tests.csv")

tests <- db %>%
  filter(redcap_event_name %in% c("visit_1", "visit_2")) %>%
  select(record_id, redcap_event_name, gait_speed:bmi) %>%
  filter(!is.na(gait_speed))
