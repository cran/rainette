## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----warning=FALSE, message=FALSE---------------------------------------------
library(quanteda)
library(rainette)

## Split documents into segments
corpus <- split_segments(data_corpus_inaugural, segment_size = 40)

## -----------------------------------------------------------------------------
corpus

## -----------------------------------------------------------------------------
head(docvars(corpus))

## -----------------------------------------------------------------------------
tok <- tokens(corpus, remove_punct = TRUE)
tok <- tokens_tolower(tok)
tok <- tokens_remove(tok, stopwords("en"))
dtm <- dfm(tok)

## -----------------------------------------------------------------------------
dtm <- dfm_trim(dtm, min_docfreq = 10)

## ----message = FALSE, warning = FALSE-----------------------------------------
res <- rainette(dtm, k = 5, min_segment_size = 15)

## ----eval = FALSE-------------------------------------------------------------
#  rainette_explor(res, dtm, corpus)

## -----------------------------------------------------------------------------
cluster <- cutree(res, k = 5)

## -----------------------------------------------------------------------------
corpus$cluster <- cutree(res, k = 5)
head(docvars(corpus))

## -----------------------------------------------------------------------------
clusters_by_doc_table(corpus, clust_var = "cluster")

## -----------------------------------------------------------------------------
clusters_by_doc_table(corpus, clust_var = "cluster", prop = TRUE)

## -----------------------------------------------------------------------------
docs_by_cluster_table(corpus, clust_var = "cluster")

## ----message=FALSE, warning=FALSE---------------------------------------------
res1 <- rainette(dtm, k = 5, min_segment_size = 10)
res2 <- rainette(dtm, k = 5, min_segment_size = 15)

## ----message=FALSE, warning=FALSE---------------------------------------------
res <- rainette2(res1, res2, max_k = 5)

## ----eval=FALSE---------------------------------------------------------------
#  rainette2_explor(res, dtm, corpus)

## -----------------------------------------------------------------------------
clusters <- cutree(res, k = 5)
clusters_completed <- rainette2_complete_groups(dtm, clusters)

