---
layout: page
title: R for reproducible scientific analysis
subtitle: Introduction to R and RStudio
minutes: 45
---



> ## Learning objectives {.objectives}
>
> * Appreciate why a social scientist might want to write code and why R specifically
> * Gain familiarity the RStudio IDE
> * Use basic math functions in R, with calculator and fun() notation
> * Understand variables and how to assign to them
> * Use comparison operations
> * Manage your workspace in an interactive R session
> * Understand errors, warnings, and messages
> * To be able to seek help via `?` and Google
>

Welcome to the R portion of the workshop.

In this lesson, you'll become familiar with the R language, the RStudio environment, and some best practices that will make your life easier and your science more reliable. You'll also write a bit of R code. 

#### Why R?

R is a free, open-source programming language that is designed for data analysis and statistics. It has a huge user-community and is highly extensible, with thousands of packages that add extra functionality at the official Comprehensive R Archive Network. For almost anything you want to do, there is an R package to help. In short, for most social scientists, it is the best tool to organize, visualize, and analyze data.

#### Why RStudio?

RStudio is an IDE (integrated development environment) which we use to manage and execute R code. It is also free and open-source, it works on all platforms (e.g. you can use an Amazon Web Services cluster using RStudio), and it integrates version control and project management.

You write the same R code in RStudio as you would elsewhere, and it executes the same way. RStudio helps by keeping things nicely organized.

#### Why Code?

- Power
- Flexibility
- Editability: Error fixing, tweaks
- Traceability: Return and know what was done
- Reproducability: Cornerstone of science
- Communication: No ambiguity

### Introduction to RStudio

When you open RStudio you should see three panels:

1. The interactive R console (entire left)
1. Workspace/History (tabbed in upper right)
1. Files/Plots/Packages/Help (tabbed in lower right)

#### Workflow within Rstudio

Console vs. script

- Console
    - The R console is where code is run
        - The console in RStudio is the same as if typed in `R` in your command line
    - When you start RStudio, you'll see a bunch of information, followed by a ">" and a blinking cursor. This is a "Read, evaluate, print loop". It's highly interactive: You can type in commands and R will execute them and print the result.
    - You can work here, and your history is saved, but that is a laborious way to work
- Script
    - Preserve work in a plain-text file (with .R extension)
    - Create new R script with `File -> New File -> R Script` or ctrl/cmd-shift-N
    - There's now a fourth RStudio panel, which is your plain-text script
        - Do your work here, and save this to be able to reproduce or edit it at a later date
        - For now your script is unsaved and called "untitled1" or something. We'll fix that shortly
    - cmd/ctrl-enter executes the line the cursor is on by copying that line and sending it to the Console
        - You can run multiple lines at once by highlighting them and pressing cmd/ctrl-enter
    - Benefits of working in a script:
        - Mixes interactivity and preservation
        - Save just text and can get same results at another time or on another machine
        - Building preservable pipeline of operations
    

> #### Tip: Pushing to the interactive R console {.callout}
> To run the line of your script where the cursor is, you can click on the `Run` button at the top-right of the
> script pane or use the keyboard short cut: cmd/ctrl-enter.
>
> To run a block of code, select (highlight) it and click `Run` or cmd/ctrl-enter. 
>
> You are working toward selecting a whole script and running it.  
> - You'll write your script interactively, running each line to make sure it works, and at the end, 
> you'll be able to run the whole analysis by selecting all and running the script. This way you can later
> rerun the analysis on new or modified data or change part of the analysis and everything will work with
> the click of a button.

### Introduction to R

The simplest thing you can do with R is do arithmetic:


~~~{.r}
1 + 100
~~~



~~~{.output}
[1] 101

~~~

And R will print out the answer, with a preceding "[1]", which indicates the first item of output.

If you type in an incomplete command, R will wait for you to complete it:

~~~ {.r}
> 1 -
~~~

~~~ {.output}
+
~~~

Any time you execute code and the R session shows a "+" instead of a ">", it
means it's waiting for you to complete the command. If you want to cancel
a command you can simply hit "Esc" and RStudio will give you back the ">"
prompt. You can also cancel commands with "Esc" if R is taking too long to 
finish a calculation.

Order of operations works in R just like it did in algebra class. From highest to lowest precedence:

 * Parentheses: `(`, `)`
 * Exponents: `^`
 * Divide: `/`
 * Multiply: `*`
 * Add: `+`
 * Subtract: `-`


~~~{.r}
3 + 5 * 2
~~~



~~~{.output}
[1] 13

~~~

Use parentheses to group to force the order of evaluation, and/or to make
code easier to read.


~~~{.r}
(3 + 5) * 2
~~~



~~~{.output}
[1] 16

~~~


#### Whitespace

Speaking of being easy to read, whitespace is ignored by R. Use it consistently to make code readable. 
For example, putting a single space on either side of an operator makes code easy to read. 


~~~{.r}
(3 + (5 * (2 ^ 2))) # hard to read
3 + 5 * 2 ^ 2       # easier to read, once you know rules
3+5*2^2             # very hard to read
3 + 5 * (2 ^ 2)     # to make order of operations clear, use parentheses
~~~

#### Comments

The text that appears to the right of each line of code above is called a comment. Anything that
follows the hash symbol -- `#` -- is ignored by R.

Liberally add comments to your code as you write. Things that are clear as you write them will be 
mysterious to others, including your-future-self! Commenting takes little time and will save you 
time and headaches in the long run. 

#### Scientific Notation

Really small or large numbers get a scientific notation:


~~~{.r}
2/10000
~~~



~~~{.output}
[1] 2e-04

~~~

Which is shorthand for "multiplied by `10^XX`". So `2e-4`
is shorthand for `2 * 10^(-4)`.

You can write numbers in scientific notation too:


~~~{.r}
1e9  # One billion
~~~



~~~{.output}
[1] 1e+09

~~~

#### Mathematical functions

R has many built in mathematical functions. To call a function,
type its name, follow by open and closing parentheses.
Anything we type inside those parentheses is an "argument" to that function.

Here we call the `sin` function and provide it the argument 3.14, or approximately $\pi$.


~~~{.r}
sin(3.14)  # trigonometry functions
~~~



~~~{.output}
[1] 0.001592653

~~~

We can take a logarith:


~~~{.r}
log(3)  # natural logarithm
~~~



~~~{.output}
[1] 1.098612

~~~

Or exponentiate:


~~~{.r}
exp(0.5) # e^(1/2)
~~~



~~~{.output}
[1] 1.648721

~~~

#### Nested Functions

You can even put functions inside each other. `exp(0.5)` raised `e` to the `1/2` power. 
Equivalently we could take the square-root of `e`. Expressions are interpretted from the inside-out: 
In the following line, R first takes `e^1` (which is `e`), and then takes the square-root 
(that's what the `sqrt` function does) of the result.


~~~{.r}
sqrt(exp(1))
~~~



~~~{.output}
[1] 1.648721

~~~

You don't need to remember function names. There are many ways to discover or rediscover them when you need them. Google is your friend, but we will discuss other ways soon.

#### Comparison

We can do logical comparison in R. This will be important later, for example, when we want to filter a dataset
based on a logical condition.


~~~{.r}
1 == 1  # equality (note two equals signs, read as "is equal to")
~~~



~~~{.output}
[1] TRUE

~~~


~~~{.r}
1 != 2  # not-equal (read, "is not equal to")
~~~



~~~{.output}
[1] TRUE

~~~


~~~{.r}
1 < 2  # less than
~~~



~~~{.output}
[1] TRUE

~~~


~~~{.r}
1 >= -9 # greater than or equal to
~~~



~~~{.output}
[1] TRUE

~~~

#### Variables and assignment

We can store values in variables using the assignment operator `<-`. 
You can also use a single equals sign, `=`, for assignment.

Note that unlike every other expression we have run so far, R doesn't print anything 
when we run this next line. Instead, it is stored for later in a **variable**, `x`. 
`x` now contains the **value** `0.25`. Read this as "Assign 1/4 to x."


~~~{.r}
x <- 1/4
~~~

Look for the `Environment` tab in one of the panes of RStudio, and you will see that `x` and its value
have appeared. Our variable `x` can be used in place of a number in any calculation that expects a number:


~~~{.r}
x
~~~



~~~{.output}
[1] 0.25

~~~


~~~{.r}
log(x)
~~~



~~~{.output}
[1] -1.386294

~~~

This doesn't change the value of `x` or store the result anywhere, it simply prints the answer to the console.

Variables can be reassigned:


~~~{.r}
x <- 99
~~~

`x` used to contain the value 0.25 and and now it has the value 99.

Assignment values can contain the variable being assigned to:


~~~{.r}
x <- x + 1 
~~~

> #### MCQ -- Variable Assignment {.challenge}
>
> What does the following code print?
> ```
> a <- 1
> b <- 2
> c <- a + b
> b <- 4
> a <- b
> c <- a
> c 
> ```
>
> a. a
> b. 3
> c. 4
> d. ::nothing::
>


#### Variable name conventions

Variable names can contain letters, numbers, underscores and periods. They
cannot start with a number nor contain spaces at all. Different people use
different conventions for long variable names, especially:

- underscores\_between_words
- camelCaseToSeparateWords

What you use is up to you, but **be consistent**.

#### Tab completion

Use descriptive variable names, as they make your code easier to understand. It will save time because you'll remember what each variable is: It's easier to remember what `domesticPopulation` is than `dp` or `x`. A silly example:


~~~{.r}
theNumberNine <- 9
~~~

Tab-completion is a really nice feature of RStudio that saves typing and avoid typos. 
After you assign 9 to `theNumberNine`, if you start typing `t...`, `th...`, etc., and
then pressing `tab`, RStudio will pull up a box of all the valid ways to finish that word. 
You can scroll through them using the up- and down-arrows and press enter to choose the 
one you want. If you press tab when there is only one valid way to complete something, 
RStudio will automatically complete it. 

### Understanding functions & getting help

#### R help files

Once you figure out what function you want, you need to figure out how to use it. Every function has an associated help-file. They can be hard to read, especially at first, but it is important to learn how to make sense of them.

`?function` brings up help-file. E.g.


~~~{.r}
?log
~~~

Each help-file contains the following components.

- Description: An extended description of what the function does.
- Usage: The arguments of the function and their default values.
- Arguments: An explanation of the data each argument is expecting.
- Details: Any important details to be aware of.
- Value: The data the function returns.
- See Also: Any related functions you might find useful.
- Examples: Some examples for how to use the function.


#### Other ways to get help

- `??` searches the text of all R help files, e.g. `??base` will find `log`.
- Google
- Stack Overflow
- [Cookbook for R](http://www.cookbook-r.com/)
- [RStudio cheat sheets](http://www.rstudio.com/resources/cheatsheets/)


#### Arguments to functions

- Can be specified by order or by name
- Before, when we entered `log(3)`, `log` knew `3` was `x` because it was in the first position, but we could have also told `log` explicitly that `3` is the value `x` should take. These are the same:


~~~{.r}
log(3)  
~~~



~~~{.output}
[1] 1.098612

~~~



~~~{.r}
log(x = 3)
~~~



~~~{.output}
[1] 1.098612

~~~

- Some arguments have default values, e.g. `log`'s `base` defaults to `exp(1)`, *e*, unless you tell it otherwise. So these are identical:


~~~{.r}
log(x = 3)
~~~



~~~{.output}
[1] 1.098612

~~~



~~~{.r}
log(x = 3, base = exp(1))
~~~



~~~{.output}
[1] 1.098612

~~~

To get the base 10 logarithm of 3, you could do


~~~{.r}
log(x = 3, base = 10)
~~~



~~~{.output}
[1] 0.4771213

~~~

If you provide a function with arguments by name, they can go in any order. Otherwise, they have to appear in the order specified by the function. These are all the same:


~~~{.r}
log(3, 10)
~~~



~~~{.output}
[1] 0.4771213

~~~



~~~{.r}
log(x = 3, base = 10)
~~~



~~~{.output}
[1] 0.4771213

~~~



~~~{.r}
log(base = 10, x = 3)
~~~



~~~{.output}
[1] 0.4771213

~~~


> #### MCQ -- Which of these things is not like the other ones? {.challenge}
>
> Three of the following lines produce the same result. Without running the code, which one will produce a different result than the others? The helpfile for `log` (`?log`) may be helpful.
>
> ```
> a. log(x = 1000, base = 10)
> b. log10(1000)
> c. log(base = 10, x = 1000)
> d. log(10, 1000)
> ```


### When R Wants to Tell You Something

Besides the value of an expression R has executed, there are a few other kinds of responses you might get from R, including errors, warnings, and messages. 

#### Errors

R returns an error when it cannot proceed. It stops you in your tracks. The error message will provide some information on what the problem was, but it is often cryptic. Learning to understand these messages is important but takes practice. Here's an example of an error:


~~~{.r}
log_of_a_word <- log("a_word")
~~~



~~~{.output}
Error in log("a_word"): non-numeric argument to mathematical function

~~~

R tell us that something has gone wrong: It got a non-number for a function that needs a number. Note that errors prevent execution of the line, so nothing got assigned to `log_of_a_word` there. If we ask R what it thinks `log_of_a_word` is, it will return another error. Practice understanding R's communication style: Do you understand how R is telling you what the problem is?


~~~{.r}
log_of_a_word
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'log_of_a_word' not found

~~~

#### Warnings

Warnings appear in the same red font in the console, but they start with "Warning" instead of "Error". Warnings are R's way of telling you that it did something, but it suspects it may not have been what you wanted. *Warnings can be more insidious than errors* because you can keep going, but keep going with a mistake in your pipeline. Here's an example:


~~~{.r}
log_of_a_negative <- log(-2)
~~~



~~~{.output}
Warning in log(-2): NaNs produced

~~~

`NaN` means "not a number", and R has kindly told us, "Hey, I think you probably wanted a number here -- taking a log of a negative is kind of a weird thing to do. I can do it if you really want, I just want to be make sure it's what you want."

Note that it did work, so if we ask R what `log_of_a_negative` is, we won't get an error. Note that we don't get a warning either, so you need to pay attention when warnings first appear.


~~~{.r}
log_of_a_negative
~~~



~~~{.output}
[1] NaN

~~~

#### Messages

There's a third source of red text in R: messages. These are R's way of telling you that something happened, but it's probably nothing to worry about. These don't start with "Message"; they just print the red text. We can make R print one like this:


~~~{.r}
message("Hey buddy!")
~~~



~~~{.output}
Hey buddy!

~~~




> #### Challenge -- Extra practice: Assignment & Comparison {.challenge}
>
> Which elephant weighs more? Convert one's weight to the units of the other, and store the result in an appropriately-named new variable. Write a command to test whether elephant1 weights more than elephant2 (1 kg ≈ 2.2 lb).
>
> 
> ~~~{.r}
> elephant1_kg <- 3492
> elephant2_lb <- 7757
> ~~~
>

