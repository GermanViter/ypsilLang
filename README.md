<p align="center">
  <img src="Ypsil.png" alt="Project banner" width="800"/>
</p>

# ypsilLang

A small Lisp-like interpreted programming language written in C. It uses the "mpc" parser combinator library to parse and evaluate expressions. The interpreter provides a simple REPL (Read-Eval-Print Loop) for interactive use.

## Features

*   **Interactive REPL**: A simple and intuitive Read-Eval-Print Loop for interactive coding.
*   **S-Expressions**: Support for symbolic expressions, the core data structure of Lisp.
*   **Basic Arithmetic**: Perform calculations with standard arithmetic operators.
*   **Error Handling**: Basic error reporting to help with debugging.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

Before you begin, ensure you have the following installed:

*   A C compiler (e.g., `gcc` or `clang`)
*   `make`
*   `git`
*   The `editline` library (often called `libedit-dev` or similar on package managers)

### Installation & Building

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/ypsilLang.git
    cd ypsilLang
    ```

2.  **Build the project:**
    Run the `make` command to compile the source code.
    ```sh
    make
    ```
    This will create an executable file named `ypsil`.

## Usage

To start the interpreter's REPL, run the compiled executable:

```sh
./ypsil
```

You can then start entering Lisp-like expressions.

### Defining Variables

Variables can be defined using `def` for global scope or `=` for local scope.

*   **Global Definition (`def`)**:
    ```lisp
    > def {x} 10
    ()
    > x
    10
    ```

*   **Local Assignment (`=`)**:
    ```lisp
    > = {y} 20
    ()
    > y
    20
    ```
    Note that `=` is typically used for re-assigning variables within a function's scope, or for defining local variables if not already defined.

### Defining Functions (Lambdas)

Functions are defined using the `\` (lambda) keyword, followed by a Q-expression of formal arguments and a Q-expression for the function body.

```lisp
> def {add-one} (\ {x} (+ x 1))
()
> add-one 5
6
> def {multiply} (\ {x y} (* x y))
()
> multiply 2 3
6
```

Functions can also take a variable number of arguments using `&`.

```lisp
> def {sum-all} (\ {& nums} (eval (join + nums)))
()
> sum-all 1 2 3 4
10
```

### Built-in Functions

ypsilLang comes with several built-in functions:

*   **Arithmetic Operations**: `+`, `-`, `*`, `/`
    ```lisp
    > + 10 20
    30
    > - 50 25
    25
    > / 100 10
    10
    ```

*   **List (Q-Expression) Manipulation**:
    *   `list`: Converts S-expressions to Q-expressions.
        ```lisp
        > list 1 2 3
        {1 2 3}
        ```
    *   `head`: Returns a Q-expression containing the first element.
        ```lisp
        > head {1 2 3}
        {1}
        ```
    *   `tail`: Returns a Q-expression containing all but the first element.
        ```lisp
        > tail {1 2 3}
        {2 3}
        ```
    *   `join`: Joins multiple Q-expressions.
        ```lisp
        > join {1 2} {3 4}
        {1 2 3 4}
        ```
    *   `eval`: Evaluates a Q-expression as an S-expression.
        ```lisp
        > eval {+ 1 2}
        3
        ```

*   **Conditional and Comparison**:
    *   `if`: `(if condition then-expression else-expression)`
        ```lisp
        > if (== 1 1) {print "yes"} {print "no"}
        "yes"
        > if (> 5 10) {print "bigger"} {print "smaller"}
        "smaller"
        ```
    *   Comparison operators: `==`, `!=`, `>`, `<`, `>=`, `<=`
        ```lisp
        > == 1 1
        1
        > != 1 2
        1
        > > 10 5
        1
        ```

*   **Input/Output and System**:
    *   `load`: Loads and executes a file.
        ```lisp
        > load "my_script.ypsl"
        ```
    *   `print`: Prints values to the console.
        ```lisp
        > print "Hello, Ypsil!"
        "Hello, Ypsil!"
        > print "The answer is:" (+ 10 20)
        "The answer is:" 30
        ```
    *   `error`: Raises an error with a given string message.
        ```lisp
        > error "Something bad happened!"
        Error: Something bad happened!
        ```

### Example Session

```lisp
> def {greeting} "Hello"
()
> def {name} "World"
()
> print greeting name
"Hello" "World"
> def {square} (\ {x} (* x x))
()
> square 5
25
> def {fib} (\ {n} {
    if (< n 2)
      {n}
      {(+ (fib (- n 1)) (fib (- n 2)))}
  })
()
> fib 6
8
```

To exit the REPL, press `Ctrl+C`.

## Standard Library (`prelude.ypsl`)

The interpreter automatically loads a standard library from `prelude.ypsl` which provides a rich set of additional functions.

### Function Definition Helper

*   `fun`: A convenient way to define functions. `(fun {add x y} {+ x y})` is syntactic sugar for `(def {add} (\ {x y} {+ x y}))`.

### Core Functional Tools

*   `let`: Creates a new scope for local variable bindings.
*   `unpack` / `curry`: Unpacks a list of arguments to a function. Example: `(unpack + {1 2 3})` evaluates to `6`.
*   `pack` / `uncurry`: Packs arguments into a list for a function.
*   `do`: Executes a sequence of expressions and returns the result of the final one.
*   `comp`: Composes two functions. `(comp f g x)` is equivalent to `(f (g x))`.

### Logical Operations

*   `not`, `or`, `and`: Standard logical operators.

### List Manipulation

*   `fst`, `snd`, `trd`: Get the first, second, or third element of a list.
*   `len`: Get the length of a list.
*   `nth`: Get the nth element of a list.
*   `last`: Get the last element of a list.
*   `init`: Get all but the last element of a list.
*   `reverse`: Reverse a list.
*   `take n l`: Take the first `n` elements of a list `l`.
*   `drop n l`: Drop the first `n` elements of a list `l`.
*   `split n l`: Split a list `l` into two lists at index `n`.
*   `elem x l`: Check if element `x` exists in list `l`.

### Higher-Order List Functions

*   `map f l`: Apply a function `f` to every element in a list `l`.
*   `filter f l`: Filter a list `l` using a predicate function `f`.
*   `foldl f z l` (Left Fold): Reduce a list from left to right.
*   `foldr f z l` (Right Fold): Reduce a list from right to left.
*   `sum l`: Sum all elements in a list.
*   `product l`: Find the product of all elements in a list.
*   `take-while f l`: Take elements while a condition `f` is true.
*   `drop-while f l`: Drop elements while a condition `f` is true.

### Conditional Functions

*   `select`: A general-purpose conditional that takes a list of condition-action pairs.
*   `case`: Compares a value against a series of cases.
*   `otherwise`: Used with `select` and `case` as a default case.

### Example using Standard Library

Here is how you can use some of the standard library functions:

```lisp
> def {my-list} (list 1 2 3 4 5)
()
> my-list
{1 2 3 4 5}
> len my-list
5
> map ({x} (* x x)) my-list
{1 4 9 16 25}
> filter ({x} (> x 3)) my-list
{4 5}
> sum my-list
15
> product my-list
120
> reverse my-list
{5 4 3 2 1}
```

## Cleaning Up

To remove the compiled executable and other build artifacts, run:

```sh
make clean
```
