[![hex.pm version](https://img.shields.io/hexpm/v/ex_mark2pdf.svg)](https://hex.pm/packages/ex_mark2pdf)

ExMark2pdf
==========

It provides the ability to convert from the markdown to the PDF.  

Required wkhtmltopdf.  
Download: [http://wkhtmltopdf.org/downloads.html](http://wkhtmltopdf.org/downloads.html)  

Usage
=====

Input:

```cmd
>escript ex_mark2pdf -i path/to/markdown/file.md -o output/path/to/pdf/file.pdf
```

Output:

PDF is output to the specified output destination.

Roadmap
=======

- [x] Markdown file to HTML file.
- [x] HTML file to PDF file.
- [x] Mix Custom Task.
- [x] Japanese correspondence.
- [x] Registration Hex Library.
- [x] Specifying the output destination.
- [ ] CSS support.
- [ ] Javascript support.
- [ ] Code highlight.
- [ ] Document