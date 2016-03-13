# First get the FastQC output directory
# and the full path to the summary.txt file
# within each sample's fastqc folder
fqc_out_dir <- "fqc_output"
sum_files <- list.files(fqc_out_dir, pattern = "summary.txt", recursive = TRUE)
fnames <- sub("_fastqc/summary.txt", "", sum_files)

# Now read in those files within a list
list_of_sum_files <- setNames(object = vector("list", length = length(sum_files)),
                              nm = fnames)

# Read in a summary.txt file output by FastQC
read_fastqc_summary <- function(fname, ...) {
  read.table(file = fname, header = FALSE,
             sep = "\t", stringsAsFactors = FALSE,
             col.names = c("Verdict", "Test", "Filename"),...)
  }

list_of_sum_files[] <- lapply(file.path(fqc_out_dir, sum_files), read_fastqc_summary)

# Check that they all have the same structure
is_fqcsum_ok <- function(df) {
  stopifnot(all(dim(df) == c(12, 3)))
  res_vec <- c("PASS", "WARN", "FAIL")
  stopifnot(all(df[[1]] %in% res_vec))
  stopifnot(length(unique(df[[3]])) == 1)
  TRUE
}

all(sapply(list_of_sum_files, is_fqcsum_ok))

# Now rbind all
big_df <- do.call("rbind", list_of_sum_files)
wide_df <- reshape(big_df, idvar = "Filename", timevar = "Test", direction = "wide")
names(wide_df) <- sub("Verdict\\.", "", names(wide_df))

names(wide_df)

shorten_colnames <- c(
  "Filename" = "Fname",
  "Basic Statistics" = "BS",
  "Per base sequence quality" = "BSQ",
  "Per tile sequence quality" = "TSQ",
  "Per sequence quality scores" = "SQS",
  "Per base sequence content" = "BSC",
  "Per sequence GC content" = "SGCC",
  "Per base N content" = "BNC",
  "Sequence Length Distribution" = "SLD",
  "Sequence Duplication Levels" = "SDL",
  "Overrepresented sequences" = "OS",
  "Adapter Content" = "AC",
  "Kmer Content" = "KMER"
)

all(colnames(wide_df) == names(shorten_colnames))
colnames(wide_df) <- shorten_colnames
wide_df
# Now print to colour table
xtab <- xtable::xtable(wide_df)

xt <- capture.output(print(xtab, scalebox=0.78, include.rownames=FALSE))
xt_mod1 <- gsub("PASS", "\\\\tc{green}{pass}", xt)
xt_mod2 <- gsub("FAIL", "\\\\tc{red}{fail}", xt_mod1)
xt_mod3 <- gsub("WARN", "\\\\tc{orange}{warn}", xt_mod2)
cat(xt_mod3, sep="\n")
