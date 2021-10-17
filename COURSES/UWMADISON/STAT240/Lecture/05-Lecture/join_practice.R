library(tidyverse)
library(lubridate)

person <- tibble(
 name = c('Sleepy', 'Sneezy', 'Doc', 'Mickey', 'Minnie'),
 type = c('dwarf', 'dwarf', 'dwarf', 'mouse','mouse'),
 age = c(113, 110, 109, 92, 92)
)
person

work <- tibble(
  name = c('Sleepy', 'Sneezy', 'Doc', 'Mickey', 'Pinocchio'),
  position = c('Director', 'Salesman', 'Doctor', 'Movie Star', 'Dancer')
)
work

left_join(person, work, by="name")
right_join(person, work, by="name")
full_join(person, work, by="name")
inner_join(person, work, by="name")

full_join(person, work)