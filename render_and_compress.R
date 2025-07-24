##### Render Script #####
quarto::quarto_render("_make_pdf.qmd")

# Path to PDF file
pdf_file <- "creating_the_world_script.pdf"





##### Compress #####
# Compress-Function
compress_pdf <- function(pdf_in, pdf_out = pdf_in) {
  if (!file.exists(pdf_in)) stop()
  if (Sys.which("gs") == "") stop()
  
  tmp_out <- tempfile(fileext = ".pdf")
  
  cmd <- sprintf(
    "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=%s %s",
    shQuote(tmp_out), shQuote(pdf_in)
  )
  message("Compressing PDF...")
  system(cmd)
  
  if (file.exists(tmp_out)) {
    file.copy(tmp_out, pdf_out, overwrite = TRUE)
    message("PDF compressed")
  } else {
    warning("No PDF-File resulted")
  }
}

# Run Compress-Function
compress_pdf(pdf_file)



##### Clean Up #####
# Set Files to remove
files_to_remove <- c(
  "_make_pdf.tex",
  "_make_pdf.aux",
  "_make_pdf.log",
  "_make_pdf.toc",
  "_make_pdf.synctex.gz",
  "_make_pdf.pdf",
  "_make_pdf_files"
)


# Remove files
for (f in files_to_remove) {
  if (file.exists(f)) {
    if (dir.exists(f)) {
      unlink(f, recursive = TRUE)
    } else {
      file.remove(f)
    }
    message("Removed: ", f)
  }
}