## Name: HYUN KO
## Email: hko26@wisc.edu

## We'll grade your homework by running
##   source("HW1.R")
## in a directory containing your "HW1.R" file and a folder of the baby
## names data. We may also run other test cases on your code. We may
## also read your code.
##
## Hint: if you have a bug, study a single test case that manifests it.

rm(list = ls())

## ======================================================================
## Part 1: Write discriminant() and quadratic.formula() functions to
## solve the quadratic equation a*x^2 + b*x + c = 0.
## ======================================================================

##  ---------- Part 1(a) ----------
## Write a function "discriminant()" that takes three numeric
## parameters, a, b, and c, related to the quadratic equation
##   a*x^2 + b*x + c = 0
## and returns the discriminant b^2 - 4ac.
discriminant = function(a, b, c) {
 return(b ** 2 - 4 * a* c)
}
stopifnot(isTRUE(all.equal(discriminant(0, 0,  0), 0)))
stopifnot(isTRUE(all.equal(discriminant(0, 0,  1), 0)))
stopifnot(isTRUE(all.equal(discriminant(0, 1,  0), 1)))
stopifnot(isTRUE(all.equal(discriminant(0, 1,  1), 1)))
stopifnot(isTRUE(all.equal(discriminant(1, 0,  0), 0)))
stopifnot(isTRUE(all.equal(discriminant(1, 0,  1), -4)))
stopifnot(isTRUE(all.equal(discriminant(1, 1,  1), -3)))
stopifnot(isTRUE(all.equal(discriminant(1, -1,  -1), 5)))
stopifnot(isTRUE(all.equal(discriminant(-1, -1,  -1), -3)))

##  ---------- Part 1(b) ----------
## Write a function "quadratic.formula()" with three numeric
## parameters, a, b, and c related to the quadratic equation
## a*x^2 + b*x + c = 0. Its return value is as follows:
##
## If a is 0, return NULL (because "0x^2 + bx + c = 0" isn't a
## quadratic equation).
##
## If there are no real-number solutions (because the discriminant
## is negative), return a numeric vector of length 0. (Use your
## discriminant() function to find the discriminant.)
## 
## Otherwise return a vector of the two (possibly identical) solutions
## to a*x^2 + b*x + c = 0. If the two solutions are different, the
## smaller solution should be first in the vector.
##
## Note: Call your discriminant() function to get the discriminant.
quadratic.formula = function(a, b, c) {
  if (a == 0) {
    return (NULL)
  }
  
  discriminant = discriminant(a, b, c)
  if (discriminant < 0) {
    return (numeric(0))
  }
  else if (discriminant == 0) {
    return(-b / 2*a)
  }
  else {
    small_nominator = -b - sqrt(b**2- 4 * a * c)
    big_nominator = -b + sqrt(b**2- 4 * a * c)
    denominator = 2 * a
    small_result = small_nominator / denominator
    big_result = big_nominator / denominator
    return (c(small_result, big_result))   
  }
}
stopifnot(isTRUE(all.equal(quadratic.formula(0, 0,  0), NULL)))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 0,  1), numeric(0))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 0, -1), c(-1, 1))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 0, -4), c(-2, 2))))
stopifnot(isTRUE(all.equal(quadratic.formula(2, 0, -8), c(-2, 2))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 5,  6), c(-3,-2))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 1, -6), c(-3, 2))))

## ======================================================================
## Part 2: Write a function baby() to process data on U.S. births where
## the individual has a Social Security Number.
## ======================================================================

##  ---------- Part 2(a) ----------
## Get the required data. Do this part outside this R script.
##
## Make a folder called "babyData". Save the file
## www.ssa.gov/OACT/babynames/names.zip into your babyData
## folder. Unzip names.zip to see NationalReadMe.pdf and 140 data
## files, one for each year from 1880 through 2019 (or the year from the last 
## file shown below):
##   NationalReadMe.pdf
##   yob1880.txt
##   yob1881.txt
##   ...
##   yob2018.txt
##   yob2019.txt (or the last file in the similar format with a number 
##   even larger)
## 
## The file "NationalReadMe.pdf" says this:
##   For each year of birth YYYY after 1879, we created a
##   comma-delimited file called yobYYYY.txt. Each record in the
##   individual annual files has the format "name,sex,number," where
##   name is 2 to 15 characters, sex is M (male) or F (female) and
##   "number" is the number of occurrences of the name.

## For example, here are the start and end of yob2010.txt:
##   Isabella,F,22921
##   Sophia,F,20646
##   ...
##   Zyran,M,5
##   Zzyzx,M,5
## 
## (The idea for this assignment came from Nick Parlante's "Nifty
## Assignment Archive", http://nifty.stanford.edu/2005/NameSurfer. I took
## a class from Nick, an excellent and hilarious teacher, in about 1991.)

## ---------- Part 2(b) ----------
## Write a function "baby()" with three character string parameters:
## name, sex, and data.
##
## It should read the ".txt" files in the data folder and get the
## proportion of babies born each year, 1880 to 2019 (or the year from 
## the last file shown above), of the specified
## name and sex.

## It should make a graph showing, on the x-axis, the years from 1880
## to 2019 (or the year from the last file shown above), and on the 
## y-axis, the proportion of babies born with the
## specified name and sex for each year. Include the title "Proportion
## of babies named <name> by year" (where "<name>" is replaced by the
## name provided by the caller), the x-axis label "Year" and the y-axis
## label "Proportion of babies".
##
## It should return the vector of proportions.
baby = function(name, sex, data) {
  proportions = c()
  
  for (i in seq(1880,2020)) {
    path = paste(data,"/names/yob", as.character(i), ".txt", sep="")
    txt_file = read.delim(path, header = FALSE)$V1
    target_data = 0
    total_population = 0

    for (j in (1:length(txt_file))){
      person_name = unlist(strsplit(txt_file[j], ","))[1]
      person_sex = unlist(strsplit(txt_file[j], ","))[2]
      person_data = as.numeric(unlist(strsplit(txt_file[j], ","))[3])
      
      if (person_name == name & person_sex == sex){
        target_data = target_data + person_data
      }
      total_population = total_population + person_data
    }
    ratio = as.numeric(( target_data / total_population ))
    sprintf(ratio, fmt = '%#.3f')
    proportions <- append(proportions, ratio)
  }
  return(proportions)
}

## ---------- Part 2(c) ----------
## Call your function on "Emma", "F", and "babyData". (I've done this for you.)
proportion = baby(name="Emma", sex="F", data="babyData")
## Check that your solution matches mine. (I've done this for you.)
emma.proportions =
  c(0.00994, 0.01056, 0.0104, 0.01091, 0.01063, 0.01133, 0.01083, 
    0.0107, 0.01031, 0.00998, 0.00989, 0.01006, 0.00935, 0.00913, 
    0.00867, 0.00841, 0.00803, 0.00778, 0.00731, 0.00721, 0.00687, 
    0.00686, 0.0065, 0.00605, 0.00573, 0.00542, 0.00519, 0.00506, 
    0.00482, 0.00457, 0.00441, 0.00406, 0.0034, 0.00306, 0.0028, 
    0.00275, 0.0027, 0.00255, 0.00245, 0.00241, 0.00231, 0.00217, 
    0.00219, 0.00216, 0.00206, 0.00202, 0.00195, 0.00187, 0.00178, 
    0.00173, 0.0016, 0.00157, 0.00158, 0.00158, 0.00142, 0.00134, 
    0.00136, 0.00129, 0.00121, 0.00122, 0.00113, 0.00105, 0.00095, 
    0.00086, 0.00084, 0.00077, 0.00065, 0.00059, 0.00061, 0.00057, 
    0.00054, 0.00047, 0.00045, 0.00041, 0.00038, 0.00036, 0.00033, 
    0.00029, 0.00026, 0.00025, 0.00024, 0.00021, 2e-04, 0.00018, 
    2e-04, 0.00018, 0.00018, 0.00017, 0.00015, 0.00015, 0.00015, 
    0.00014, 0.00014, 0.00014, 0.00016, 0.00016, 0.00014, 0.00015, 
    0.00014, 0.00015, 0.00015, 0.00015, 0.00016, 0.00016, 0.00019, 
    0.00027, 0.00035, 0.00044, 0.00048, 5e-04, 0.00061, 0.00067, 
    0.00084, 0.00109, 0.00128, 0.00138, 0.00168, 0.00214, 0.00284, 
    0.00318, 0.00332, 0.00356, 0.00443, 0.00597, 0.00566, 0.00529, 
    0.00484, 0.0046, 0.00479, 0.00469, 0.0047, 0.00515, 0.00573, 
    0.00575, 0.00566, 0.00554, 0.00533, 0.00556, 0.00535, 0.00496,
    0.00471)
stopifnot(isTRUE(all.equal(proportion, emma.proportions, tolerance=.001)))

year_range = c(1880:2020)
name = "Emma"
plot(x=year_range, y=proportion, main=paste("Proportion
of babies named", name, "by year"), xlab="Year", ylab="Proportion of babies")