summary_1 <- tests %>%
  group_by(redcap_event_name) %>%
  select(redcap_event_name, gait_speed, bmi) %>%
  ezsummary(flavor = "wide", unit_markup = "[. (.)]")
