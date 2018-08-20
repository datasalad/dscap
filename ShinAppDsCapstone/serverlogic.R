library(quanteda)
library(readtext)
library(stringr)
library(glue)
library(data.table)

db <- readRDS("dbopt10.rds")

clearInput <- function(input) {
  ## "Go on a romantic date at the"
  out <- stringr::str_to_lower(input)
  out <- stringr::str_replace_all(out, "[[:punct:]]", "")
  out <- stringr::str_replace_all(out, "[[:cntrl:]]", "")
  out <- stringr::str_replace_all(out, "[[:digit:]]", "")
  out <- stringr::str_squish(out)
}


dbLookup <- function(dt, term, ngnum) {
  cnd <- dt[like(feat, paste0("^", term))]
  
  s <- cnd[which.max(cnd$freq), ]$feat
  k <- str_split(s, "_", simplify = TRUE)
  
  #print(k)
  ret <- ""
  
  if (ncol(k) > 0)
    ret <- k[1, ncol(k)]
  
  
  
  scoreTermAppeared <- sum(cnd$freq)
  
  p <- paste0("^", term, "_", ret)
  
  scoreTermAppearedPlusPred <- 0
  scoreTermAppearedPlusPred <- sum(dt[like(feat, p)]$freq)
  
  if (scoreTermAppeared == 0)
    scoreTermAppeared = 0.0000001
  
  if (ngnum == 2) {
    score <- 0.4 * 0.4 * 0.4 * scoreTermAppearedPlusPred / scoreTermAppeared
  } else if( ngnum == 3) {
    score <- 0.4 * 0.4 * scoreTermAppearedPlusPred / scoreTermAppeared
  } else if( ngnum == 4) {
    score <- 0.4 * scoreTermAppearedPlusPred / scoreTermAppeared
  } else {
    score <-  scoreTermAppearedPlusPred / scoreTermAppeared
  }
  
  
  result <- NULL
  result$score <- score
  result$term <- ret
  result
}

findBestCandAndScore <- function(current_term){
  #candidates <- tibble::add_row(candidates, term = k$term, score = k$score)
  # db lookup
  
  m <- str_split(current_term, "_", simplify = TRUE)
  ng <- ncol(m) + 1
  
  #print(current_term)
  
  cand <- NULL
  
  if (ng == 2) {
    cand <- dbLookup(db$n2, current_term, 2)
  } else if (ng == 3) {
    cand <- dbLookup(db$n3, current_term, 3)
  } else if (ng == 4) {
    cand <- dbLookup(db$n4, current_term, 4)
  } else if (ng == 5) {
    cand <- dbLookup(db$n5, current_term, 5) 
  } else if (ng == 6) {
    cand <- dbLookup(db$n6, current_term, 6)
  }
  
  
  
  ret <- NULL
  ret$score = cand$score
  ret$term = cand$term
  ret
}


doPredict <- function(normInput) {
  sent_chunks <- stringr::str_split(normInput, " ", simplify = TRUE)
  # 
  #      [,1] [,2] [,3] [,4]       [,5]   [,6] [,7] 
  # [1,] "go" "on" "a"  "romantic" "date" "at" "the"
  
  nwords <- ncol(sent_chunks)
  max_pred <- 5
  
  if (nwords == 0 )
    return("")
  
  if (nwords > max_pred) {
    sent_chunks <- matrix(sent_chunks[, ((nwords - max_pred) + 1):nwords], nrow = 1)
    nwords <- ncol(sent_chunks)
  }
  
  search_str <- c()
  chr <- nwords
  
  while(chr > 0) {
    idx <- chr:nwords
    search_str <- append(search_str, paste0(sent_chunks[, idx], collapse = "_"))
    chr <- chr - 1
  }
  
  # for each phrase find candidate with highrst score
  candidates <- tibble::tibble(term  = "", score = 0)
  
  for (i in 1:length(search_str)) {
    current_term <- search_str[i]
    k <- findBestCandAndScore(current_term)
    candidates <- tibble::add_row(candidates, term = k$term, score = k$score)
  }
  
  # select candidate with highest score
  cand <- candidates[-1,]
  
  #print(cand)
  endResult <- ""
  
  
  resLookup <- cand[which.max(cand$score),]
  
  #endResult <- paste0(resLookup$term, "_", resLookup$score)
  endResult <- resLookup$term
  
  if (endResult == "")
    endResult = db$n1[which.max(db$n1$freq),]$feat
  
  endResult
}

predictWord <- function(input) {
  pred <- doPredict(clearInput(input))
  #glue("{input}  -->  {pred}", input = input, pred = pred)
  pred
}

gc()