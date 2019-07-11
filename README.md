# vcardr
read vCard files into R.

The package consists of a single function `read_vcard()` which reads a .vcf file into an R session as a dataframe. In the current version the function obtains all of the information in the vCard file, but each unique label receives a separate column. The next step is to bring the information in these columns into the dataframe itself and reduce the number of columns necessary.  
