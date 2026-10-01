#!/usr/bin/env Rscript

required_papers <- c(
  "paper_id", "title", "year", "species", "model", "status"
)
required_claims <- c(
  "paper_id", "claim_id", "claim", "evidence_type", "confidence"
)
required_datasets <- c(
  "dataset_id", "accession", "repository", "species", "condition"
)

check_file <- function(path, required) {
  if (!file.exists(path)) stop("Missing file: ", path)
  x <- read.csv(path, check.names = FALSE, stringsAsFactors = FALSE)
  missing <- setdiff(required, names(x))
  if (length(missing)) stop(path, " is missing: ", paste(missing, collapse = ", "))
  x
}

papers <- check_file("data/papers.csv", required_papers)
claims <- check_file("data/claims.csv", required_claims)
datasets <- check_file("data/datasets.csv", required_datasets)

if (anyDuplicated(papers$paper_id)) stop("Duplicate paper_id found")
if (anyDuplicated(claims$claim_id)) stop("Duplicate claim_id found")
if (anyDuplicated(datasets$dataset_id)) stop("Duplicate dataset_id found")

doi <- papers$doi[nzchar(papers$doi)]
if (anyDuplicated(tolower(doi))) warning("Duplicate DOI found")

orphan_claims <- setdiff(unique(claims$paper_id), papers$paper_id)
if (length(orphan_claims)) stop("Claims refer to unknown paper_id: ", paste(orphan_claims, collapse = ", "))

message("OK: ", nrow(papers), " papers; ", nrow(claims), " claims; ", nrow(datasets), " datasets.")
