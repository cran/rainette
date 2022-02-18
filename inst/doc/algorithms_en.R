## ----echo=FALSE---------------------------------------------------------------
set.seed(13)
m <- matrix(sample(0:1, 20, replace = TRUE), nrow = 4)
rownames(m) <- paste0("doc", 1:4)
colnames(m) <- c("return", "of", "the", "obra", "dinn")
m

## ----echo=FALSE---------------------------------------------------------------
tmp <- rbind(colSums(m[1:2,]), colSums(m[3:4,]))
rownames(tmp) <- c("doc1 + doc2", "doc3 + doc4")
tmp

