quarto::quarto_render("_make_pdf.qmd")

# Path to PDF file
pdf_file <- "creating_the_world_script.pdf"

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

# Run PDF-Function
compress_pdf(pdf_file)
