test <- c(1721, 979, 366, 299, 675, 1456)


multiply_if_sum <- function(input_vector, sum_of_interest = 2020,
                            n_elements = 2) {
  stopifnot(is.numeric(input_vector), is.numeric(sum_of_interest))
  all_combinations <- combn(input_vector, n_elements)
  ind <- which(apply(all_combinations, 2, sum) == sum_of_interest)
  stopifnot(length(ind) == 1)
  prod(all_combinations[, ind])
}
 
stopifnot(multiply_if_sum(c(1, 2, 3, 4), 7) == 12)
stopifnot(multiply_if_sum(test, 2020) == 514579)
stopifnot(multiply_if_sum(c(1, 2, 3, 4), 7, 3) == 8)
stopifnot(multiply_if_sum(test, 2020, 3) == 241861950)

input_vec <- as.numeric(readLines("input.txt"))
multiply_if_sum(input_vec)

multiply_if_sum(input_vec, n_elements = 3)
