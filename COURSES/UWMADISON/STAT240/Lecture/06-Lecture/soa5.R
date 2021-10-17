#my_string1 <- \What's today's date?\
my_string2 <- "What's today's date?"
my_string2

my_string3 <- 'What\'s today\'s date?'
my_string3


#my_string4 <- 'What's today's date?'

string1 <- c("A", "B", "CD")
string2 <- str_c("A", "B", "CD")
length(string1)*length(string2) + str_length(string2)

str_c("ABC",1:3)

str_c(c("a", "bc"))
c(str_c("a", "bc"))

s <- "\\n\n\\t\\" 
s

string1 <- "a\nbc"
string2 <- "a\nbbc"
string3 <- "a\n.bc"
string4 <- "a\n\nbc"
str_view(c(string1, string2, string3, string4), ".b.")

str_view(c("abbcc", "abbbc", "abaa", "abcabcabc"), "(.)\\1\\1")

str_view(c("Hello, my name is Jessi.", "Wow!%^&!!!", "6+2=8", "^.*$", "Go Badgers!"), "^.*$")

str_detect(c("W", "WW", "WWW", "WWWW", "abc", "Wabc"), "^W+$") 
