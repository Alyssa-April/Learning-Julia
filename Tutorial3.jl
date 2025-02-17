### Variables, Expressions and Memory

# variables are placeholders for values that can change / storage location 

x = 1
y = 2
z = x+y
x

x = 2
z = x+y # must update the value z

x + y = 2
# causes an error cause read in julia as the variable x+y is bound to  a storage loc that contains the value 2

y = 2 - x # var y is bound to a storage location that contains the val of the exp 2-x

x = 1

x = x + 1 # usually used as number counter

x

# shorthand form +=

x+=1 # --> x = x+1

x

length = 2

width = 3

area = length * width

# julia uses variable name "ans" to keep track of the value of the last evaluated Expressions

ans
ans *2 
ans

a = 1
b = 2
c = 3

a>b

a < b && b > c
a < b || b > c

ans

begin = 2
end = 2
# these are reserved words so cannot use as variable

# function called varinfo that shows list of all variables, how much memory taking up and datatypes
varinfo()

### Types

# every value of an expression has a Types

# numbers: int, float, rational, irrational
# characters
# string
# symbol
# bool
# any (all of these types fall under the umbrella type called any)


typeof(-3) # funtion that identifies datatypes
# int64 is short for 64 bit integer

typeof(0)

typeof(-1.2)
# floating point number

typeof(0.0)

typeof(NaN)
# not a number is also type float

0.1+0.2

0.1+0.2 == 0.3
# floating point numbers are not technically precise numbers, computers do calc in base 2 or binary, so only numbers 
# the computer knows are multiples of two

bitstring(0)
bitstring(1)
bitstring(0.1)
bitstring(0.2)
bitstring(0.3)


# rational numbers (fractions)
# In Julia, -1//2 represents a rational number. The // operator creates a Rational type, 
# which represents a number as a ratio of two integers. In this case, -1//2 represents
# the rational number -1/2. This type allows for exact representation of fractions, 
# avoiding the rounding errors that can occur with floating-point arithmetic.

typeof(-1//2)
# double slash stands for negative one-half

typeof(0//3)

typeof(5//2)

1//2 + 1//4

# Irrational number

pi

typeof(pi)

# acceptable ways to write numbers in julia

10^6

1000000

1_000_000

10^6 == 1000000 == 1_000_000

1

1//0 # infinite rational number

typeof(1//0)

# unacceptable ways to enter numbers in julia

1,000,000
# u get something you dont expect so ddont use commas to separate numbers

$1,000,000
# currency signs are not allowed

100% # cannot coz julia think modulo so waiting for another number 

0//0 
# 0 divided by 0 is an undefined number

# Built-in functions

sqrt(4)

cbrt(8)

convert(Int64, 3.0) # convert float to int

iseven(3)

isodd(3)

rem(5,2) # remainder

5%2 # modulo and rem same

round(3.14159, digits = 2)

round(3.55, digits = 1, RoundUp)

round(3.55, digits = 1, RoundDown)

# = --> variable assignment operator
# == --> equality test
# === --> identity test (i === j --> is i identical in value and type to j)

a = 3
b = 3.0

a == b
a === b 
# a is type int64 but b is type float64, they = value but dif type

# characters

typeof('a')

typeof('#')

# you can use unicode chars while programming in julia (go to unicode julia, unicode input)
# Tab completion sequence(s) shows the unicodes that can be generated on the screen

α # backslash alpha Tab
β
δ

Δ
π
ℯ

5/2
4/2 # returns 2.0 becuase of type float coz the slash operator which is the division 
# op always gives a floating point number as a result
# if nak integer value je...
div(5,2) # gives the integer portion of the division\

5÷2 # same but use \div Tab

√4
∛8
cbrt(8)

0.1 + 0.2 ≈ 0.3 # \approx tab gives approximately equal to

E = "mc²" # this is to do superscript --> \^2 tab

H₂O = "water" # subscript --> \_2 tab

# can use unicode as variables
α = 1
β = 2
α + β 

# Emojis
☎ # \:phone: tab

⛄

🐶

# useful built in functions for characters

Char(65) # gives the ascii character equivalent of numbers between 1 to 127
Char(90)
Char(127)

#= here is a list of special characters: --> multiline comment, close it using =#
$
%
# single line comments
!
\

=#

# string --> sequence of characters

s1 = "Hello, World!"

typeof(s1)

println(s1)

print(s1) #no extra line 

# print a string with quation marks
s2 = """This is an "interesting" tutorial.""" # triple quotes

println(s2)

# common special characters that can use within string

# \n newline
println("line 1\nline 2\nline 3")

# \t tab
println("1\t2\t3\t4\t5")

# repeat a string
snowperson = "⛄"
snowperson*snowperson
snowperson^3

repeat(snowperson, 10)

# concatenate the string
s3 = "How much wood"
s4 = " "
s5 = "would a woodchuck chuck?"
s6 = s3*s4*s5
s7 = string(s3,s4,s5) # same thing as above
repeat(s3, 3)

# interpolate a string, got two methods (not just for text, can put expression to do calc withing string)

kpatty = 1.50
cbits = 1.25
sfsoda = 1.25
kmeal = 3.50
place = "Krusty Krab"

# method 1: use dollar sign to interpolate var within quoatation marks
println("I am eating lunch at the $place.")

println("Bought separately = $(kpatty + cbits + sfsoda) dollars.") # can put expression in parentheses

println("Krabby Meal deal = $kmeal dollars")

# method 2: use comma separations outside the quotations marks

println("I am eating lunch at the ", place, ".")

println("Bought separately = ", kpatty+cbits+sfsoda, " dollars.")

println("Krabby Meal deal = ", kmeal, " dollars.")

# there is no currency formatting in julia so cannot use us dollars, euros or yens for calculation

# this causes error coz dollar sign is used for string interpolation 
println("$100")

println("\$100") 
# like this can

println("€100")

println("¥100") # these are strings so cannot use for calculations

# get string input from user
print("Enter some text: "); text = readline() # can enter multiple lines of code
text
println(text)

typeof(text)

print("Enter a number: "); text = readline() # when entered in 123, julia read it as a string, the parse function converts the string into what type u want so int here
num = parse(Int64, text)
typeof(num)

text +text # errror
num+num

i = 123
snum = string(i) # use string function to convert number into a string
typeof(i)
typeof(snum)

snum + snum # error
i + i


# Symbols (human readable unique identifiers)
# using colon followed by var name will create a datatype called symbol

color = :mycolor
typeof(color)

# bool
typeof(true)
typeof(false)

# any (if julia cant figure a datatype, it uses datatype any as the default datatype)
typeof(Any)

# print strings in dif colours using a built in func called printstyled()

s1 = "Hello, World!"
printstyled(s1, bold = true, color = :red)
# :red is a symbol
#= the available colours are
white is default
red, green, blue,
cyan, magenta, yellow, black

can use 
begin 
    <code block>
end

as a way to enter multiple lines of code in the repl
=#

begin
    printstyled("    π", bold = true, color = :green)
    println()
    printstyled("   π ", bold = true, color = :red)
    printstyled("π", bold = false, color = :magenta)
end
