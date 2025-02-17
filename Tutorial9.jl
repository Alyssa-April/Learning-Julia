##### Algorithms and Recursion

#= Algorithms --> An algorithm is a set of instructions designed to perform a specific task.
Can be simple proces, eg. 1+1, or a complex operation like a search engine. In computer 
programming, algorithms are often created as functions. These functions serve as mini programs
that can be called by a larger program. Skilled programmers usually look for the most 
efficient way to complete the task. =#

#= Solve the cuberoot of a number using three different algorithms:
1. Guess-and-Check
2. Approximate Solutions 
3. Binary search =#

### Guess and Check Algorithm

function cbrtguessandcheck(x)
    #initialise variable
    counter = 1
    # algorithm
    for guess in 0:abs(x)
        if guess^3 > abs(x)
            println("\n$x is not a perfect cube. Sorry.")
            break
        end
        if guess^3 != abs(x)
            println(counter, "\t Guess = $guess\tGuess Cubes = $(guess^3)")
            counter += 1
        else
            # display result
            if x < 0
                guess = -guess
            end
            println(counter, "\t Guess = $guess\tGuess Cubes = $(guess^3)")
            println("\n The cube root of $x is $guess.")
            break
        end
    end
end

cbrtguessandcheck(7)
cbrtguessandcheck(8)
cbrtguessandcheck(-2)
cbrtguessandcheck(-1)
cbrtguessandcheck(-8)
# it takes three guesses to figure out the cuberoot of 8 is 2

# another algorithm (approximate solutions)
function cbrtapproxsolutions(x)
    # initialise variables
    guess = 0.0
    counter = 1
    increment = 0.01
    sensitivity = 0.1
    # algorithm
    while abs(guess^3 - x) >= sensitivity && abs(guess^3) <= abs(x)
        println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
        guess += increment
        counter += 1
    end
    # display result
    println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
    guess = round(guess, digits = 2)
    x < 0 ? guess = -guess : guess = guess
    println("\nThe cube root of $x is approximately $guess.")
end

cbrtapproxsolutions(7)
cbrtapproxsolutions(8)
cbrtapproxsolutions(-2)
cbrtapproxsolutions(-1)
cbrtapproxsolutions(-8)
# 192 guesses to calc the cuberoot of 7 (so this algo is super inefficient)

# Same example using Binary Search / Bisection Search 

function cbrtbinarysearch(x)
    # initialise variables
    low = 0
    high = x
    guess = (low + high) / 2
    counter = 1
    sensitivity = 0.01
    # algorithm 
    while abs(guess^3 - x) >= sensitivity
        println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
        if abs(guess^3) < abs(x)
            low = guess
        else
            high = guess
        end
        guess = (low + high) / 2
        counter += 1
    end
    # display result
    println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
    guess = round(guess, digits = 3)
    println("\nThe cube root of $x is $guess.")
end

cbrtbinarysearch(7)
cbrtbinarysearch(8)
cbrtbinarysearch(-2)
cbrtbinarysearch(-1)
cbrtbinarysearch(-8)

# compare the performance of the three algorithms

cbrtguessandcheck(1000) # takes 11 guesses
cbrtapproxsolutions(1000) # takes 1001 guesses
cbrtbinarysearch(1000) # takes 22 guesses

cbrtguessandcheck(1000000) # takes 101 guesses
cbrtapproxsolutions(1000000) # takes 10001 guesses
cbrtbinarysearch(1000000) # takes 40 guesses
# as the numbers get larger, both the guess and check and approx sols get less appealing.
# while bonary search becomes the most efficient, it is one of the most popular algorithms for solving probs

### Recursion
#= Occurs when a thing is defined in terms of itself. In computing, Recursion is a method of problem
solving where the overall solution depends on solutions to smaller versions of the same problem. 
A recursive algo divides a problem into smaller, easy-to-manage subproblems. The output returned 
from one recursion after processing one subproblem then becomes the input for the subsequent process. 
A function that calls itself from within its own code is called a recursive function. =#

## Multiplication example
# x*y is the same as adding x for as much as y times

# create two functions to perform Multiplication in this manner

# iterative approach using for loop
function mult_i(x,y)
    # initialise variables
    result = 0
    # iterative algorithm
    for i in 1:y
        result += x
        println("$i\t$x * $i\t= $result")
    end
    # display and return final result
    println("\n$x * $y = $result\n")
    return result
end

mult_i(5, 20)


# using recursive algo for the same example (not performing a calc at each step)
function mult_r(x, y)
    if y == 1
        # base case
        println("mult_r($x, $y)\t= $x\n")
        return x
    else 
        # recursive case
        println("mult_r($x, $y)\t= $x +mult_r($x, $(y-1))")
        return x + mult_r(x, y - 1)
    end
end

mult_r(5,20)
#its calling itself to calc 5x19, in order to calc 5x19, its calling itself to calc 5x18...
# t=until it reaches the base case of 5*1 which is 5. with this info, the algo goes back up the ladder
# to plug in the values till it gets to the top again.
#= in terms of mem usage, each recursive call to a function, creates its own local scope, so the 
bindings of variables in a local scope are not changed by recursive calls. The flow of control
is passed back to the previous scope once the function call returns a value. 

In order for a recursive algo to work, it requires two pieces:
1. A recursive case which is a smaller version of the overall prob its trying to Solve
2. A base case so that it can stop calling itself and begin returning values back to the callers.
w/o base case, the recursive algo will be stuck in an infinite loop. =#

## Another Example: Looking at the factorial of a number

# iterative approach
function fact_i(x)
    # initialise variables
    result = 1
    # iterative algorithm
    for i in 1:x
        result *= i
        println("$i factorial = $result")
    end
    # display and return final result
    println("\nThe Factorial of $x is $result\n")
    return result
end

fact_i(5)
factorial(5) # built in func

# recursive algorithm
function fact_r(x)
    if x == 1
        # base case
        println("fact_r($x) = $x\n")
        return 1
    else 
        # recursive case 
        println("fact_r($x) = $x * fact_r($(x - 1))")
        return x * fact_r(x - 1)
    end
end

fact_r(5)

# this next example highlights the inefficiency of the recursive algo and offers a workaround to help
# it perform more efficiently.

# Example: Fibonacci number

# iterative approach
function fib_i(x)
    # initialise variables
    f1, f2 = (0,1)
    println("\nF_0 = 0")
    # iterative algo
    for i in 1:x
        f1, f2 = (f2, f1 + f2)
        println("F_$i = $f1")
    end
    # display and return final result
    println("\nF sub $x is $f1\n")
    return f1
end

fib_i(5)

# recursive algorithm
function fib_r(x)
    if x < 2
        # base case
        println("B_$x = $x")
        return x
    else 
        # recursive case
        println("F_$x = F_$(x - 1) + F_$(x - 2)")
        fib_r(x - 1) + fib_r(x - 2)
    end
end

fib_r(5)
fib_r(1)


## Example that offers a workaround to the inefficiency found in the recursive algo of the 
# Fibonacci example. It uses dictionary to store intermediate values. This technique is called memoization.
# Memoization technique requires a new dict everytime. Fib_m is the actual recursive function that populates
# a dictionary with the intermediate values. if a value exists in the dict, the algo skips the calc
# so it doesnt repeat itself.

function fib_m(x, d)
    if x in keys(d)
        # base case
        println("B_$x = $(d[x])")
        return d[x]
    else
        # recursive case
        println("F_$x = F_$(x - 1) + F_$(x - 2)")
        d[x] = fib_m(x - 1, d) + fib_m(x - 2, d)
    end
end

# this function sets up a clean dict
function fib_memoization(x)
    # initialise dict
    d = Dict(0 => 0, 1 => 1)
    # call fib_m() func
    fib_m(x, d)
end

fib_memoization(5)
fib_r(10)
fib_memoization(10)

#= why use recursive if its inefficient? Recursion is imp bcs there are some cases where the 
recursive algo is actually more efficient. One of the most famous examples is the tower of hanoi. 
Create a function that will generate a cheat sheet to let the player know the most efficient way to solve
the puzzle given the number of discs. =#

function towers(disks, from, to, spare)
    if disks == 1
        # base case 
        println("Move disk from $from to $to")
    else 
        # recursive case
        towers(disks - 1, from, spare, to)
        towers(1, from, to, spare)
        towers(disks - 1, spare, to, from) # these three steps are repeated recursively until the sol is found
    end
end

towers(1,1,2, 3) # base case: moving one disk from rod 1 to rod 2
towers(2, 1, 2, 3)
towers(3, 1, 2, 3)