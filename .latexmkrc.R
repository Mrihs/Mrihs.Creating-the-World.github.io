# .latexmkrc
add_cus_dep('pdf', 'pdf', 0, 'gscompress');

sub gscompress {
  my ($base_name, $path) = fileparse($_[0]);
  system("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${base_name}_compressed.pdf ${base_name}.pdf");
  system("mv ${base_name}_compressed.pdf ${base_name}.pdf");
}
