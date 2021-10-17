library(tidyverse)
string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'

str_length(c("a", "R for data science", NA))

# Combining Strings
str_c("x", "y")
str_c("x", "y", "z")

# Like most other functions in R, missing values are contagious. If you want them to print as "NA", use str_replace_na():
x <- c("abc", NA)
str_c("|-", x, "-|")
str_c("|-", str_replace_na(x), "-|")

# As shown above, str_c() is vectorised, and it automatically recycles shorter vectors to the same length as the longest:
str_c("prefix-", c("a", "b", "c"), "-suffix")

# Objects of length 0 are silently dropped. This is particularly useful in conjunction with if:
name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c("Good ", time_of_day, " ", name,
      if (birthday) " and HAPPY BIRTHDAY",
      ".")

# To collapse a vector of strings into a single string, use collapse:
str_c(c("x", "y", "z"), collapse=", ")



# <Subsetting strings>

# You can extract parts of a string using str_sub(). As well as the string, str_sub() takes start and end arguments which give the (inclusive) position of the substring:

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
# negative numbers count backwards from end
str_sub(x, -3, -1)

# Nothe that str_sub() won't fail if the string is too short: it will just return as much as possible:
str_sub("A", 1, 5)

# You can also use the assignment form of str_sub() to modify strings:
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))


# <Locales>
# Above I used str_to_lower() to chagne the text to lower case. You can also str_to_upper() or str_to_title(). However, changing case is more complicated than it might at first appear because different languages have different rules for changing case. You can pick which set of rules to use by specifying a locale:
str_to_upper(c("i", "I"))
str_to_upper(c("i", "I"), locale = "tr")



# Matching patterns with regular expressions


# 1. Basic matches
x <- c("apple", "banana", "pear")
str_view(x, "an")
install.packages("htmlwidgets")
library(htmlwidgets)

str_view(x, ".a.")

# But if "." matches any character, how do you match the character " . "? You need to use an "escape" to tell the regular expression you want to match it exactly, not use its special behavior. Like strings, regexps use the backslash, \ , to escape special behavior. So to match an ., you need the regexp \. Unfortunately this creates a problem. We use strings to represent regular expressions, and \ is also usd as an escape symbol in strings. So to create the reular expression \. We need the string "\\."

dot <- "\\."
writeLines(dot)
writeLines("a\\.c")
str_view(c("abc", "a.c", "bef"), "a\\.c")

# If \ is used as an escape character in regular expressions, how do you match a literal \? WEll you need to escape it, creating the regular expression \\. To create that regular expression, you need to use a string, which also needs to escape \. That means to match a literal \ you need to "\\\\" - you need four backslashes to match one!

x <- "a\\b"
writeLines(x)
str_view(x, "\\\\")


# <Anchors>

#  By default, regular expressions will match any part of a string. It's often useful to anchor the regular expression so that it matches from the start or end of the string. You can use:
# ^ to match the start of the string.
# $ to match the end of the string.
x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")
# begin with power(^) and end up with money($)
x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")

# You can also match the boundary between words with \b.

# <Character classes and alternatives>
# \d : mathes any digit
# \s : matches any whitespace
# [abc] : matches a, b, or c.
# [^abc] : matches anytyhing except a, b, or c.

# Remember, to create a regular expression cotnaining \d or \s, you'll need to escape the \ for the string, so you'll type "\\d" or "\\s".
str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")
str_view(c("abc", "a.c", "a*c", "a c"), ".[*]c")
