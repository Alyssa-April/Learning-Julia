##### Control Flow (the order in which program instructions are executed)
#= Conditional takes a boolean expression and evaluates whether it is true or 
false. Dif instruction for different outcome.
A loop is a set of instrutions that is specified once but may be carried
out multiple timesin succession. =#

### Conditionals (aka branching)

#= 1. if <code> end 
2. if <code> else <code> end
3. if <code> elseif <code> else <code> end =#

x = 1
y = 2
if x > y 
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else 
    println("$x is equal to $y")
end

x, y = y, x
x
y # run up again

x = y # run the conditional again

#= In computing, a ternary operator is an operator that takes three arguments,
julia allows for the use of the question mark, colon ternary operator, sometimes called 
    the conditional operator. Shorthand version for conditional control flow.
    It uses the general format a ? b : c
--> a is a boolean exp that is to be evaluated, while b and c are separate instructions
to be executed. if a is true, then execute b, if a false then c is executed. =#

x = 1
y = 2

x > y ? println("$x > $y") : println("$x ≤ $y") # make sure to leave spaces between colon and ?
# \le tab 

x, y = y, x
# rerun code above

x = y  # rerun again code above


### Loops (a set of instructions that is specified once but may be carried out
# multiple times in succession).

#= While Loop: Allows code to be executed repeatedly based on a given Boolean 
condition. Generally used when the number of iterations is unclear to the programmer. 
while <code> end
must use an external counter, usually use i =#

i = 1 
while i <= 10
    print(i)
    global i+=1 
end
#= this example introduces the concept of scope of variables 
according to julia docs, the scope of a variable is the region of code within
which a variable is visible. There are two kinds of scope: global and local.
Global scope is anything that shows up in your workspace panel. when you create a loop, 
the variables included within that loop are considered local variables. they are
treated as temp vars used during the loop and discarded once the loop is completed. 
if you want to refer to the value of a variable in the global scope within the body
of the loop, theres no prob. but there is a prob when u want to change the value of
a global variable from within the body of your loop, as in this case with i+=1.
so using the keyword global is like a safety measure since changing the global variable
within a loop is not encouraged. =#

i = 1 # this is an infinite while loop
while i >= 1
    println(i)
    global i += 1
end # to abort use ctrl c

# Nesting (include control flow block in another control flow block)

i = 1
while true
    println(i)
    if i >= 5
        break # break out of the loop immediately
    end
    global i += 1
end

# infinite loop with a built in escape
begin
    print("You're in the lost Forest. Go left or right? ")
    i = lowercase(readline())
    while i == "right"
        print("You're in the lost Forest. Go left or right? ")
        global i = lowercase(readline())
    end
    println("You got out of the lost Forest!")
end


### For loop (repeats code for a specified number of iterations, once number of 
# iterations have been reached, the for loop ends)

for i in 1:10
    println(i) # here i is a temp var that exists only within the body of the loop
    # so if print i outside loop will error since it is used locally
end

for i in 5:15
    println(i)
end

for i in -10:10
    println(i)
end

for i in 5:2:11
    println(i)
end

for i in 10:-2:1
    println(i)
end

for i in 10:-1:1
    println(i)
end

# can use chars as an iterator
for characters in 'a':'z'
    println(characters)
end

for characters in 'a':2:'z'
    println(characters)
end

for characters in 'z':-1:'a'
    println(characters)
end

# use unicode characters as an iterator
for greekalphabet in 'α':'ω'
    println(greekalphabet)
end

# dsiplay a list of ascii chars along with their numbers
for i in 1:127
    println(i, "\t", Char(i))
end

# use data structures as iterators
d1 = Dict("A" => 1, "B" => π, "C" => "doggo")
for (key, value) in d1
    println("key = $key\tvalue = $value")
end

# populate empty dict using for loop
d2 = Dict()
for i in 1:10
    d2[i] = i^2
end
d2

tp1 = (1, π, "doggo")
for i in tp1
    println(i)
end
# bcs tuples are immutable, cannot use for loop to populate an empty tuple

a1 = [1, π, "doggo"]
for i in a1
    println(i)
end

# populate empty array using push! func within a for loop body
a2 = []
for i in 1:10
    push!(a2, i)
end
a2

# for loop with nested conditional
for i in 1:100
    if i%3 == 0 && i%5 == 0
        println("FizzBuzz")
    elseif i%3 == 0
        println("Fizz")
    elseif i%5 == 0
        println("Buzz")
    else
        println(i)
    end
end # the susunan oso penting

# for loop with a nested for loop
x,y = 5,5
A = fill(0, (x,y))

for i in 1:x
    for j in 1:y
        A[i,j] = i+j
    end
end
A

# same result as above example but fewer keystrokes coz use syntatic sugar
# syntatic sugar is allowed in julia as a way to enter code with a fewer keystrokes
# however, it does not have any impact on code's performance
x, y = 5,5
B = fill(0, (x,y))
for i in 1:x, j in 1:y
    B[i,j] = i + j
end
B
# When using syntatic sugar, this is called a double loop rather than a nested loop

# taking syntatic sugar to another level
C = [i + j for i in 1:x, j in 1:y] # this format is called a comprehension
C

# all possible combinations rolling two dice
for d1 in 1:6
    for d2 in 1:6
        counter = d2 + 6 * (d1-1)
        println("$counter\t$d1 + $d2 = $(d1+d2)")
    end
end

# all possible two dice rolls where the sum is divisible by 3
for d1 in 1:6 #for loop with a nested for loop with a nested conditional, with a nested ternary
    for d2 in 1:6
        if (d1+d2) % 3 == 0
            d2 <= 3 ? counter = d1*2-1 : counter = d1*2
            println("$counter\t$d1 + $d2 = $(d1+d2)")
        end
    end
end

### Iterate over strings in a for loop just like tuples and arrays

s = "Hello, World!"
for i in s
    println(i)
end

for i in s
    if i == 'a' || i == 'e'
        println("Your String contains either an 'a' or an 'e'")
    end
end

s1 = "julia u rock"
s2 = "i rule julia"

if length(s1) == length(s2)
    for char1 in s1
        for char2 in s2
            if char1 == char2
                println("common letter: $char1")
                break
            end
        end
    end
end

begin
    an_letters = "aefhilmnorsxAEFHILMNORSX"
    print("\nI will cheer for you! Enter a word: ")
    word = readline()
    print("Enthusiasm level. Enter a number between 1 and 10: ")
    times = parse(Int64, readline())
    println()
    for i in word
        shout = uppercase(i)
        if i in an_letters
            print("Give me an\t$i !"); sleep(1) # sleep func pauses program in secs
            println("\t$shout !!!"); sleep(0.5)
        else 
            print("Give me a\t$i !"); sleep(1)
            println("\t$shout !!!"); sleep(0,5)
        end
    end
    println("\nWhat does that spell?\n"); sleep(1)
    for j in 1:times
        println(word, " !!!"); sleep(0.25)
    end
end

### comprehension

## Array comprehension 
#= Array
[<body> <header>] =#

## Dictionary
#= Dictionary
Dict(<body> <header>) =#

[i for i in 1:5]

data = [i for i in 1:5]
data

data = [i^2 for i in 1:5]

[i*j for i in 1:5, j in 5:10]

[i for i in 1:10 if i%2 == 1]

# construct 2 dimensional array with 10 rows 2 cols, 3 separate comprehensions and separated by a space for horizontal concat
[[i for i in 1:10] [j for j in 11:20] [k for k in 21:30]]

# construct dict of odd numbers and use the string ver of the odd number as the key
Dict("$i" => i for i in 1:10 if i%2 == 1)

# bonus
s = "Hello, World!\n"
mycolors = [:black, :blue, :cyan, :green, :yellow, :magenta, :red, :white]

for color in mycolors
    printstyled(s, bold = true, color = color)
end