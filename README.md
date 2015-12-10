# State	Of The Commons 2015

## What's here?

Here you'll find all the files for building the	website for the 2015
edition of our State of the Commons report (SOTC), plus	the SVG	files
used to build the PDF version.

## How does this work?

The report itself is self-contained in a single Markdown file (with a
little inline HTML for tables and social media links) ``sotc.md`` --
this is the canonical English-language report. You'll notice that
littered throughout the document is the string `-----` -- this is a
horizontal rule that we use as a page seperator (other horizontal
rules are represented by `---`) for building the multi-page version of
the document.

We use GNU csplit to generate split pages of the master document based
on the page seperator, and then ignore the initial 11 lines of each of
these files (which contains markup that's useful in the one-page, but
not so much in the single pages) and then generate a page title from
the next line. We pass this page title, plus the page number and the
split Markdown file into Pandoc. Pandoc generates the various HTML
files.

### Translations

Creative Commons being a global organization has a strong desire to
see this document in lots of languages too. For that, a form was
created which populates a spreadsheet. Creative Commons' Affiliate
Teams have access to the form, and after completion can request access
to the resulting spreadsheet. Each language is assigned a single row
in the spreadsheet, and complete their translation there.

A shortened version of the report is represented by the
``translation.md`` Markdown document. Most of the content in this
document is replaced by tokens in the form of `{{14}}, {{15}}, etc` --
these numbers represent the column number in the spreadsheet with the
particular string.

When an affiliate has completed some updates to their translations,
they can let us know and we'll export the spreadsheet to
``translations/translations-master`` which is a typical character
seperated spreadsheet (CSV is a common format) seperated by the
character
``[`` and saved without quoted text fields.

This file is then split using ``split translation-master -l 1 --additional-suffix=.csv`` which creates the various standalone language data files. These files are then populated into ``translation.md`` by ``translate.pl`` which creates a temporary Markdown file. These temporary Markdown files are then processed by Pandoc to create HTML versions.

## Data sources

The data sources for the report are in the ``data.mdwn`` file which is once again processed by Pandoc into a template of its own. The resulting ``data.html`` file is widely sourced throughout the report.

## Images

Images are edited in Inkscape and where appropriate, GIMP.

## Fonts

The font "Lato" is widely used throughout the report. Lato is a sans serif typeface family started in the summer of 2010 by Warsaw-based designer Łukasz Dziedzic (“Lato” means “Summer” in Polish). In December 2010 the Lato family was published under the Open Font License by his foundry tyPoland, with support from Google.

## Icons

We also use the CC Attribution licensed [Glyphicons by Jan Kovařík](http://glyphicons.com). We use these in the [CC Open Store](http://creativecommons.org/discover/gift-guide/), too.

## Built with free software!

Thanks to the developers of git, perl, pandoc, markdown, perl, GNU
coreutils, fileutils, Inkscape, GIMP and of course, GNU Emacs.

---

- Matt Lee, Creative Commons (December 2015)
