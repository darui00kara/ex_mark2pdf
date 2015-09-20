[![hex.pm version](https://img.shields.io/hexpm/v/ex_mark2pdf.svg)](https://hex.pm/packages/ex_mark2pdf)

ExMark2pdf
==========

It provides the ability to convert from the markdown to the PDF.  

Required wkhtmltopdf.  
Download: [http://wkhtmltopdf.org/downloads.html](http://wkhtmltopdf.org/downloads.html)  

Dependency
==========

```elixir
defp deps do
  [...
   {:ex_mark2pdf, "~> 0.0.1"},
  ...]
end
```

```cmd
>mix deps.get
```

Usage
=====

Inputs:

```cmd
>mix ex_mark2pdf README.md
```

Output:

PDF file is output to the current directory.

Roadmap
=======

- [x] Markdown file to HTML file.
- [x] HTML file to PDF file.
- [x] Mix Custom Task.
- [x] Japanese correspondence.
- [x] Registration Hex Library.
- [ ] Specifying the output destination.
- [ ] CSS
- [ ] Javascript
- [ ] Code highlight