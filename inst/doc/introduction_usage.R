## ----message=FALSE------------------------------------------------------------
library(rainette)
library(quanteda)
## Import du corpus
fichier <- system.file("extdata", "manifeste_pc.txt", package = "rainette")
corpus <- import_corpus_iramuteq(fichier)

## -----------------------------------------------------------------------------
corpus

## ----paged.print=TRUE---------------------------------------------------------
docvars(corpus)

## ----message=FALSE------------------------------------------------------------
corpus <- split_segments(corpus, segment_size = 40)

## -----------------------------------------------------------------------------
corpus

## -----------------------------------------------------------------------------
head(docvars(corpus))

## -----------------------------------------------------------------------------
as.character(corpus)[1:2]

## -----------------------------------------------------------------------------
tok <- tokens(corpus, remove_punct = TRUE, remove_numbers = TRUE)
tok <- tokens_remove(tok, stopwords("fr"))
dtm <- dfm(tok, tolower = TRUE)

## -----------------------------------------------------------------------------
dtm <- dfm_trim(dtm, min_docfreq = 3)

## ----message=FALSE------------------------------------------------------------
res <- rainette(dtm, k = 5, min_segment_size = 10, min_split_members = 10)

## -----------------------------------------------------------------------------
res

## ----eval = FALSE-------------------------------------------------------------
#  rainette_explor(res, dtm, corpus)

## ----eval=FALSE---------------------------------------------------------------
#  ## Clustering description plot
#  rainette_plot(res, dtm, k = 5, type = "bar", n_terms = 20, free_scales = FALSE,
#      measure = "chi2", show_negative = "TRUE", text_size = 11)
#  ## Groups
#  cutree(res, k = 5)

## -----------------------------------------------------------------------------
corpus$groupe <- cutree(res, k = 5)
head(docvars(corpus))

## -----------------------------------------------------------------------------
clusters_by_doc_table(corpus, clust_var = "groupe")

## -----------------------------------------------------------------------------
clusters_by_doc_table(corpus, clust_var = "groupe", prop = TRUE)

## -----------------------------------------------------------------------------
docs_by_cluster_table(corpus, clust_var = "groupe")

## ----message=FALSE, warning=FALSE---------------------------------------------
res1 <- rainette(dtm, k = 7, min_segment_size = 10, min_split_members = 10)
res2 <- rainette(dtm, k = 7, min_segment_size = 15, min_split_members = 10)

## ----message=FALSE------------------------------------------------------------
res <- rainette2(res1, res2, max_k = 7, min_members = 10)

## ----eval=FALSE---------------------------------------------------------------
#  res <- rainette2(dtm, min_segment_size1 = 10, min_segment_size2 = 15, max_k = 7, min_members = 10)

## ----eval=FALSE---------------------------------------------------------------
#  rainette2_explor(res, dtm, corpus)

## -----------------------------------------------------------------------------
groupes <- cutree(res, k = 5)
groupes_complets <- rainette2_complete_groups(dtm, groupes)

