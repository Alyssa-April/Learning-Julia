##### Functions (principle building blocks of programs)
#= Functions are mechanisms to achieve abstraction and decomposition.
Abstraction is hiding unnecessary complexity from a user so that the user can focus using the 
product without knowing how it works. 
Decompositions means breaking down a large unmanageable problem into smaller manageable pieces that are
easier to understand and solve.  A common goal can be achieved by many dif pieces working together. 
Functions are resuable blocks of code. They are not run until they are "called" or "invoked"
in a program. A function has:
1. name() --> use lowercase names 
2. 0 or more arguments
3. documentation (optional but recommended)
4. body
5. returns something

function name(arguments) 
    <code>
end 
arguments --> name() / name(x) / name(x,y,z) / name(arbitraty number of arguments)
=#

### How to Create Functions

function f(x,y)
    x + y 
end

# another way to construct function
g(x,y) = x + y # name is immediately followed by parentheses

function mymult(x,y)
    x*y
end
mymult(2,3)
mymult(2, 3.14)
mymult(π, ℯ)

function isgreaterthan(x,y)
    x > y
end
isgreaterthan(3,2)
isgreaterthan(2,3.14)
isgreaterthan(π, π )

### Functions with Control Flow

function myconditional(x,y)
    if x > y 
        println("$x is greater than $y")
    elseif x < y 
        println("$x is less than $y")
    else
        println("$x is equal to $y")
    end
end
myconditional(2,1)
myconditional(2,3.14)
myconditional(π, π)


# the var i and the conditional loop are within the body of the func, so they are in 
# the local scope of that function, so no need to set up counter in the global scope and 
#  no need to call out to the global scope from within the body of the loop
function mywhileloop(x)
    i = 1
    while i <= x
        println(i)
        i += 1
    end
end
mywhileloop(10)
mywhileloop(100)
mywhileloop(1000)


function myforloop1(stop)
    for i in 1:stop
        println(i)
    end
end
myforloop1(10)

function myforloop2(start, stop)
    for i in start:stop
        println(i)
    end
end
myforloop2(-10, 10)
myforloop2('c', 'h')
myforloop2(10, 1) # in order to count down, must give step number, so this cant be run

# the optional arg is separated by semicolon (called keyword argument --> kwarg)
function myforloop3(start, stop; step = 1) # optional step number, if user dont enter the function will select 1 as the default value
    for i in start:step:stop
        println(i)
    end
end
myforloop3(10,1; step = -1)
myforloop3(5,11; step = 2)
myforloop3('a', 'z'; step = 2)
myforloop3(1,10)


### Functions with Data Structures

d1 = Dict("A" => 1, "B" => π, "C" => "doggo")
tp1 = (1, π, "eggdog")
a1 = [2, ℯ, "bongocat"]
s1 = "Hello, World!"

function printdict(d)
    for (key, value) in d
        println("key = $key\tvalue = $value")
    end
end
printdict(d1)

# iterate over the contents of any tuple, array or string
function printcollection(a)
    for i in a
        println(i)
    end
end

printcollection(tp1)
printcollection(a1)
printcollection(s1)

# construct dictionary and array using function

function dictconstruct(x)
    d = Dict()
    for i in 1:x
        d[i] = i^2
    end
    return d
end
dictconstruct(10)

function arrayconstruct(x)
    a = []
    for i in 1:x
        push!(a, i)
    end
    return a
end
arrayconstruct(100)


### Functions with Nested Conditionals and Nested Loops

function fizzbuzz(n)
    for i in 1:n
        if i%3 == 0 && i%5 == 0 
            println("FizzBuzz")
        elseif i%3 == 0
            println("Fizz")
        elseif i%5 == 0
            println("Buzz")
        else 
            println(i)
        end
    end
end
fizzbuzz(100)

# create an addition table with any number of rows and cols
function addtable(row, column)
    A = fill(0, (row, column))
    for i in 1:row
        for j in 1:column
            A[i,j] = i+j
        end
    end
    return A
end
addtable(5,6)
addtable(rand(1:10), rand(1:10))

# w/o the (), a function object may be passed around like any other value
p = println
t = typeof
v = varinfo

s = "Hello, World!"
p(s)
t(s)

#= More Fun with Functions
1. return vs println()
2. returning a tuple
3. "slurp" operator =#

function addreturn(x,y)
    return x + y 
end

function addprintln(x,y)
    println(x + y)
end

a = 2
b = 3
addreturn(a,b)
addprintln(a,b) # appear the same, now try to bind to a var

c = addreturn(a,b)
d = addprintln(a,b)

c
d #= d returns nothing because the keyword return returns the value of the expression back to the caller
 in this case returns 5 to the caller which was the variable assignment op which allowed 
 the val 5 to bind to the var c. the println function just print the value of a+b to the terminal.
 it did not return the value of a+b to anyone, the value was used locally in the body of the functuoin
 and then discarded. so the var d was bound to a value of nothing. so if want your function to return 
 something for use outside the function, then use return. =#

# functions can return more than one value

function qnr(x,y)
    q = x ÷ y
    r = x%y
    return(q,r)
end
 quotient, remainder = qnr(5,2)
 quotient
 remainder

 # create function that allows dif users to select dif number of arguments
 # julia allows for the use of an arbitrary number of args using the ... operator.
 # In julia, taking multiple arguments or values and convert them into one argument, the 
 # process is called slurping. 

 # prints a shopping list based on the args entered w/o knowing the number of args beforehand
 function shoppinglist(items...)
    println("Number of items to buy = $(length(items))")
    for i in items
        println(i)
    end
end
 
shoppinglist("milk", "eggs", "bread")
shoppinglist("milk", "eggs", "bread", "apples", "cereal")

### How to Add Documentation to Your Functions

#= when ? and println, the text that comes up is called markdown.
when  you create a new function, you can include your own custom markdown text as well. =#

#= jldoctest is the keyword that displays the text within the ``` like it would appear on 
a REPL screen. close out of the markdown text with """, then construct your function =#

begin
    """
        is_even(x) => Bool
    Return `true` if `x` is an even number.
    Return `false` if `x` is an odd number.
    
    # Example
    ```jldoctest
    julia> is_even(3)
    false

    julia> is_even(4)
    true
    ```
    """
    function is_even(x)
        return x%2 == 0
    end
end

is_even(4)
is_even(5)

# in order to see your markdown text, type in question mark and is_even