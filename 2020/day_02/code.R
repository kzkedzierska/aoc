library(tidyverse)

check_passwords <- function(input_file) {
  read_delim(input_file, delim = " ", 
             col_names = c("reqs", "let", "pass")) %>%
    separate(reqs, sep = "-", into = c("reqs_min", "reqs_max"),
             convert = TRUE) %>%
    mutate(let = str_remove(let, ":"),
           occ = str_count(pass, let)) %>%
    filter(occ <= reqs_max, occ >= reqs_min) %>%
    nrow()
}

stopifnot(check_passwords("test_input.txt") == 2)
check_passwords("./input.txt")


check_passwords_position <- function(input_file) {
  read_delim(input_file, delim = " ", 
             col_names = c("pos", "let", "pass")) %>%
    separate(pos, sep = "-", into = c("pos_one", "pos_two"),
             convert = TRUE) %>%
    rowwise() %>%
    mutate(let = str_remove(let, ":"), 
           first = str_split(pass, "")[[1]][pos_one], 
           second = str_split(pass, "")[[1]][pos_two]) %>%
    filter(sum(c(first == let, second == let)) == 1) %>%
    nrow()
}
stopifnot(check_passwords_position("./test_input.txt") == 1)

check_passwords_position("./input.txt")
