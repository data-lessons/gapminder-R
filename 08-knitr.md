---
layout: page
title: R for reproducible scientific analysis
subtitle: Dynamic reports with knitr
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> * Learn how to render R Markdown documents. Generate dynamic documents that include text, code, and results.
> * Control basic formatting using Markdown syntax.
> * Create, edit, and compile an R Markdown document including code chunks and inline code.

### The What and Why of R Markdown

R Markdown is a way to keep our notes, code, and results organized in a single document. It is a great tool for "reproducible research" -- the idea that your research output should be easy for others to reproduce. It keeps your writing and results together, so if you collect some new data or change how you clean the data, you just have to re-compile the document and you're up to date.

An R Markdown file is a plain text file containing content in a simple document markup language called *markdown* interspersed with R code blocks. R Markdown files can be converted to html, pdf (if you have LaTeX on your machine), or Word files for dissemination. You can write websites in R Markdown, articles that conform to publishing standards, CVs, presentations... People have even written dissertations in RMarkdown. The syntax of the language is designed to be super simple, but you still get high quality output.

> ## Challenge - Render an R Markdown document {.challenge}
> 
> - Right-click on this [link](./code/example.Rmd) to "Save Link As..."
> - Open `example.Rmd` in RStudio.
> - Render the R Markdown document by pressing the "Knit" button at the top of document.
> - Compare the output (html) file to the input (Rmd) file.

### Organization of an R Markdown Document

The top of the an Rmd file has some header material in YAML format (enclosed by triple dashes). Some of this (`title`, `author`, ...) gets displayed in the output header, other parts provide formatting information to the conversion engine.

After the header, there is a mix of plain-text, formatted with markdown syntax, and R code chunks. 

#### Markdown Syntax

> The overriding design goal for Markdown's formatting syntax is to make it as readable as possible. The idea is that a Markdown-formatted document should be publishable as-is, as plain text, without looking like it's been marked up with tags or formatting instructions. - John Gruber

    # A Markdown Example
    
    Paragraphs are separated by a blank line.
    
    This is a new paragraph. Words and phrases can be made _italic_,
    __bold__, or `monospace`. Use asterisks to create bullet items:

    * Item-A
    * Item-B
    * Item-C
    
    Enumerated lists look like this:
    
    1. Item-1
    2. Item-2
    3. Item-3
    
    Here's a code snippet:
    
    ```
    for (i in 1:10) {
        print(i)
    }
    ```
    
    Here's a link to [a website](https://www.google.com/) and images
    can be included like so:
    
    ![My Image Caption](https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png)
    
    ## MathJax Support
    
    Inline math is placed between dollar signs: $y = mx + b$. Display
    math should get its own line and be put between double dollar
    signs:
    
    $$ y = ax^2 + bx + c $$

[This page](http://rmarkdown.rstudio.com/authoring_basics.html) covers the basics of formatting text in R Markdown.

> ## Challenge - Practice writing Markdown {.challenge}
> 
> - In RStudio, create a new R Markdown file.
> - Write a top level section heading with the content `Text formatting`.
> - Under the heading write `R Markdown makes writing easy and fun`. Make the word `easy` italic and the word `fun` bold.
> - Create another top level section heading with the content `Lists are easy`
> - Under the heading write a numbered list of your four favorite foods.
> 

#### Code Chunks and Inline Code

To distinguish R code from text, R Markdown uses three back-ticks followed by `{r}` to distinguish a "code chunk". In RStudio, the keyboard shortcut to create a code chunk is command-option-i or control-alt-i. You can set options for how that code chunk renders after the `r`. For example, `echo = FALSE` will prevent the code from being displayed, but its output will still be rendered. `fig.height = 8` will make plots generated in that code chunk 8 inches in height. It is also possible to set the chunk options for the entire document by calling [`knitr::opts_chunk$set()`](http://kbroman.org/knitr_knutshell/pages/Rmarkdown.html#global-chunk-options). Check out the full suite of chunk options in the [knitr documentation](http://yihui.name/knitr/options/).

A code chunk will set off the code and its results in the output document, but you can also print the results of code within a text block by enclosing code like so: `` `r code-here` ``.

    Below is a code chunk. Rendering the chunk will result in the code
    being highlighted for R syntax and the output being included below
    the code.
    
    ```{r}
    1 + 1
    ```
    
    `r 1 + 1` is inline code. Rendering inline code will replace the
    code with the result.

    The following code snippet will not be evaluated:
    
    ```
    1 + 1
    ```
    
    Similarly, this inline code snippet will not be evaluated: `1 + 1`

#### R Markdown Documents are Self-Contained

Any data or package you use in an R Markdown document must be loaded in that document. `knitr` will not look in the Environment for data or functions. It is sometimes useful to include a code-chunk at the beginning of your document where you load data and packages and perhaps set `knitr` options for the whole document. You may or may not want to include this code in the output. If not, you can give it the option `include = FALSE`.

> ## Challenge - Write a new R Markdown document and render it {.challenge}
>
> 1. Create a new R Markdown file and save it as life_expectancy.Rmd
> 2. Create a plot of life_expectancy versus year. Start simple, when you're finished with the rest of this challenge, return to this to improve it.
> 3. Add a few notes describing what the code does and what the main findings are. Include an in-line calculation of the average life expectancy over the whole dataset.
> 4. Knit the document and view the html result.

### Further Reading

*   [RStudio's Lessons on R Markdown](http://rmarkdown.rstudio.com/lesson-1.html)
*   RStudio > Help > Cheatsheets > R Markdown Cheat Sheet
*   RStudio > Help > Markdown Quick Reference
*   [Markdown Syntax](https://daringfireball.net/projects/markdown/syntax)
*   [R Markdown Output Formats](http://rmarkdown.rstudio.com/formats.html)
