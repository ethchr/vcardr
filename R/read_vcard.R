# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

library(dplyr)
library(magrittr)
library(tidyr)
library(stringr)
library(glue)

demofile <- "C:/Users/Ethan/Downloads/Ethan_Contacts.vcf"

read_vcard <- function(file,...){
cons <- readLines(file)

#Note that this approach may result in double spaces from where the string was cut by a new line. Not sure how best to solve that yet, but doesn't seem to be a major issue.

consd <-data.frame(cons,stringsAsFactors = F)
consd %>% mutate(condy = ifelse(stringr::str_detect(cons, "^ "), cons, NA)) %>%
  mutate(condy = lead(condy, 1)) %>%
  mutate(cons = ifelse(test = !is.na(condy), glue::glue("{cons}{condy}"), cons)) %>%
  select(cons) %>%
  filter(!stringr::str_detect(cons, "^ ")) %>%
  tidyr::separate(cons, c("type", "value"), ":", extra = "merge") %>%
  mutate(cond2 = str_detect(type, "BEGIN"), cond2= cumsum(cond2)) %>%
  tidyr::fill(cond2) %>%
  spread(type, value) %>%
  select(-cond2, -BEGIN, -END)
}
