# IMPORTANT: AVAILABILITY_OPTIONS is used for a bitmask field. Once you have data using a bitmask, don’t change the order of the values, remove any values, or insert any new values in the ':as' array anywhere except at the end. You won’t like the results.
AVAILABILITY_OPTIONS = [
  :local_monday_morning,     :local_monday_afternoon,     :local_monday_night,
  :local_tuesday_morning,    :local_tuesday_afternoon,    :local_tuesday_night,
  :local_wednesday_morning,  :local_wednesday_afternoon,  :local_wednesday_night,
  :local_thursday_morning,   :local_thursday_afternoon,   :local_thursday_night,
  :local_friday_morning,     :local_friday_afternoon,     :local_friday_night,
  :local_saturday_morning,   :local_saturday_afternoon,   :local_saturday_night,
  :local_sunday_morning,     :local_sunday_afternoon,     :local_sunday_night,
  :remote_monday_morning,    :remote_monday_afternoon,    :remote_monday_night,
  :remote_tuesday_morning,   :remote_tuesday_afternoon,   :remote_tuesday_night,
  :remote_wednesday_morning, :remote_wednesday_afternoon, :remote_wednesday_night,
  :remote_thursday_morning,  :remote_thursday_afternoon,  :remote_thursday_night,
  :remote_friday_morning,    :remote_friday_afternoon,    :remote_friday_night,
  :remote_saturday_morning,  :remote_saturday_afternoon,  :remote_saturday_night,
  :remote_sunday_morning,    :remote_sunday_afternoon,    :remote_sunday_night
]
