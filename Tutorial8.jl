##### Text Editor, Debugging, Packages, Plotting

### Text Editor
#= The REPL is great for short codes, but not so great for long code. Also cannot save code
when typing in the REPL. To save need text editor. A basic example of a text editor is MS Notepad.
But most programmers look for something a little more sophisticated. So what I am using now is a text editor. =#

function myforloop(stop)
    for i in i:stop
        println(i)
    end
end
# got arrows to collapse or expand the blocks
# to highlight, left click and drag

#= once we save a .jl file of functions, we can use those functions in another file.
before can use the functions, must tell julia to include your files in the global scope
by using include().
Can also use notepad to save functions, but dont use tab, use four spaces. then save the notepad
in the same folder, with extension .jl, save as all files not as .txt =#

include("Tutorial6.jl")
# all the funcs are added to the global scope

### Testing and Debugging; Exceptions and Assertions
#= When writing code, its imp to develop a Defensive Programming Attitude, which will help to avoid 
having bugs in the first place. To avoid bugs:

1. Modularise programs into bite-sized chunks.
2. Reuse chunks of code with functions.
3. Write the specifications of functions. 
4. Check conditions on inputs and outputs.

5. After write code dy, test and validate it before making it available to users. 

The basic testing classes are: 
a) Unit Testing --> Validates each piece of the program and tests each function separately
b) Integration Testing --> Performed after unit testing. the test integrates all units and retests them to
ensure that each unit interacts well with each other. 
c) Regression Testing --> Performed after all the changes have been made. The test is rerun to 
ensure compliance.

Basic Testing Approaches:
a) Black Box testing --> Explores the paths through specifications. It tests the functionality of the program
and is performed by someone other than the programmer. The tester is not allowed to view the code but
instead, merely tests to see if the output matches the expectations outlined in the specifications. 
b) Glass Box Testing --> Explores the paths through the actual code. It tests the internal structure of the
code and tests all possible paths for every statement and branch.
c) Modern View --> Embraces the notion that the line between Black Box Testing and Glass Box Testing has 
blurred and become less relevant. What's important is that you develop a robust testing protocol that
tests functionality and non-functionality while removing programmer bias. 

Debugging --> Finding and fixing errors in code manually rather than using some outside software to 
automate the process. 

Tools to help in debugging your program:
1. Check for syntax errors. For example, typos, missing parentheses, missing quotes, etc...
Usually get error message for this.
2. Semantic Errors. For example, the expression does not make any sense. You may or may not get an error
message here.
3. "Print" Debugging. Use println() inside of your functions, inside loops, use it to display inputs,
outputs and parameters. The println() func inside of functions can slow down the program, so # them out
once already debugged the program. 

4. Use the scientific method:
a) Define a question
b) Gather information and resources
c) Form an exploratory hypothesis
d) Test the hypo by performing an experiment and collecting data.
e) Analyse data
f) Interpret data and draw conclusions.
If cannot solve, form a new hypo and repeat the process.

5. Draw pictures
6. Take a break!
7. Use Rubber Duck Debugging --> Describe ur issue outloud to an inanimate obj. 

There are 3 types of error that you may encounter when running a prog with a bug.
a) Syntax Error --> Easy to correct 
b) Runtime Error --> Happens when the program contains an illegal operation. The program will stop and 
an error message will be displayed. 
c) Logic Error --> Most difficult to spot and correct coz wont get error message. You will know this error
happens when the resulting output is dif from the known expectation. =#

# Example of BoundsError
test = [1, 2, 3] # error when try to access beyond the limits of the array
test[4]

# MethodError: when try to convert an inappropriate type
convert(Int, test)

# UndefVarError: when try to reference a non-existing UndefVarError
z

# ERROR: syntax --> forget to close () or quotation marks
a = length)

#= Exceptions --> Julia provides handlers for exceptions using the "try...catch...end" block
try
    <code>
catch
    <code>
end =#

# @warn is a macro that you can use to display a warning message
try
    print("Tell me one number: ")
    a = parse(Int, readline())
    print("Tell me another number: ")
    b = parse(Int, readline())
    println("$a times $b is $(a*b)")
    println("$a divided by $b is $(a/b)")
catch
    @warn "Bug in user input."
end

#= Assertions --> when wanna be sure that the assumptions on the state of your computation are what
you expected. Can use Assert statement to raise an Assertion Error if the assumptions are not met. 
@assert is a macro that throws an assertion error if a condition is false. Using an assertion is an example
of good Defensive Programming. =#

#= The @assert macro checks if the length of the grades list is at least 1. If the list is empty 
(i.e., length(grades) < 1), it throws an assertion error with the message "Missing grades data".
This ensures that the function has at least one grade to work with before proceeding. =#
function avg(grades)
    @assert length(grades) >= 1 "Missing grades data"
    return round(sum(grades) / length(grades); digits = 2)
end

grades1 = []
avg(grades1)

grades2 = [92, 86, 88]
avg(grades2)

### Packages
#= In julia, a package is software that is outside of the base Julia code. Some of the packages were
written by the creators of julia, or individuals or teams who simply have an interest in julia. 

Add packages to local environment. Got two ways:
1. Add a package directly from the REPL. 
2. Use Julia's built-in Package Manager. =#

# Add a package from the REPL
Pkg.add("OhMyREPL")

#= enter ] in REPL to enter the Package Manager, this environment is called a Pkg REPL, and is 
displayed in a dif colour, so as to not be confused with the primary Julia REPL.

1. To display all the options within the Pkg REPL, type ? and hit enter. 

2. To see a list of all ur installed Packages, type in "status"

3. To add a package from the package REPL, type in "add" followed by the package name w/o () and w/o ""

4. To exit the Pkg REPL, and enter the Julia REPL, use the backspace key. <--

Before can use the newly installed packages, you need to call them by using the keyword
"using", followed by the name of the package. This is required for every new Julis sesh.
Although they were downloaded to the comp, julia does not assume that we want to use them for 
every sesh. =#

using OhMyREPL

# The code is now displayed in dif colours due to the OhMyREPL package, which has transformed the REPL into 
# something that looks like a fancy Text Editor. =#
println("Hello, World!")
1 + 1

using BenchmarkTools
# this package adds a macro called @benchmark which provides a sophisticated tool to measure the 
# performance of your programs

function addtable(x,y)
    A = fill(0, (x,y))
    for i in 1:x
        for j in 1:y
            A[i,j] = i+j
        end
    end
    return A
end

@benchmark addtable(5,5)
# nanosecond is 1 sec / one billion
# the @benchmark macro runs the function multiple times and records the length of time for each
# run. 
@benchmark addtable(50,50)
# microseconds is 1 sec / 1 million
# so here we can see that the mean time is over 100 times slower to generate an add table
# that is 50x50 compared to 5x5 (nested loops becomes increasingly less efficient as the
# number of loops gets larger.)
@benchmark addtable(500,500)
# now its over ten thousand times slower. 
# So now we know why program efficiency is important.

#= Some packages are already included in Julia, so no need to add them. But still have
to call them before can use them.

1. Random
2. Statistics
3. Linear Algebra =#

using Random

# uses a uniform dist to generate random numbers
rand()

# uses a normal dist, meaning over a large sample size the average value will be 0 and
# the data will have a std dev of 1, so most data will fall between -1 and 1
r1 = randn(5)
r2 = randn(5,5)
r3 = randn(5,5,5)

# generate random strings, can come in handy if need a random password generator
r5 = randstring(10)

# randomly shuffle ur collection of data
# use underscore if not using the iterator for any calculations
cards = [rand(1:10) for _ in 1:5]
shuffle(cards) # this is a temporary shuffle
shuffle!(cards) # permanent shuffle

using Statistics

r = rand(100)
avg = mean(r)
med = median(r)
stdev = std(r) # how widely the data collection is spread out

using LinearAlgebra

A = rand(2,2)
b = rand(2,1)

x, y = A \ b
x
y

A[1]*x + A[3]*y
A[2]*x + A[4]*y

#= Resources to discover more packages
1. JuliaHub
2. Julia Observer =#

### Plotting
#= In computing, the term graph refers to a form of data visualisation using vertices
and edges, or nodes and lines, to represent networks. Here, we will learn the charts,
its called plots in computing. =#

# one of the plotting packages
Pkg.add("Makie")
using Makie
Pkg.add("GLMakie")
using GLMakie

y = rand(10)

# generate a line plot (in makie, plots are called scenes)
scene = lines(y)
# pan by right click and drag
# zoom in and out
# what we see are the default values for a plot in Makie

# different line colour, color is of type symbol
scene = lines(y, color = :pink)
# can see list of available colours in the Colors.jl documentation

scene = lines(y, color = :magenta, linewidth = 3)

# save scene to computer, go to REPL and use save()
save("myplot.png", scene)

# makie is using range from -10 to 10 for x coords
x = -10:0.01:10
f(x) = x^2 # this is for y coords

scene = lines(x, f, color = :red, linewidth = 2)

# scatter plots
x = rand(100)
y = rand(100)
z = rand(100)

# this uses 1 to 100 for x coords, and y values for y axis
scene = scatter(y, color = :green, markersize = 15)

# this generated scatter plot using array x and y for the x and y coords respectively
scene = scatter(x, y, color = :orange, markersize = 12)

# this generated 3d plot
scene = scatter(x, y, z, color = :magenta, markersize = 20)
# orbit around the plot by left-clicking and drag

x1 = -10:0.01:10
x2 = -10:10

scene = lines(x1, f, color = :red, linewidth = 2)
# add to an existing plot by using the bang operator
scene = scatter!(x2, f, color = :blue, markersize = 20)

# bar plot
y = rand(10)
scene = barplot(y, color = :dodgerblue)

# heatmap plot
grid = rand(8,8)
scene = heatmap(grid, colormap = :heat)

# add titles and labels (cannot dy got new one must see documentation)
scene[Axis][:names][:axisnames] = ("Left-Right", "Down-Up")
scenewithtitle = title(scene, "My Heatmap")

# presentation quality plots can be found using the MakieLayout 