##### How Julia Handles DataTypes and Data Structures

### Data Structures (a particular way of organising, accessing and manipulating data)
# a sophisticated datatype that contains an arbitrary number of elements

## Dictionary (flexible way to handle a lot of dif types of data)
# key-value pair to store and retrieve data

d1 = Dict() # initialize empty Dict
typeof(d1) # type dict containing elements of type Any

d1 = Dict("A" => 1, "B" => 3, "C" => 5, "D" => 7)
# a b c d dictionary keys, 1 3 5 7 dictionary values, => is called pair constructor
# data not in the order we type in bcs data is not stored sequentially in dicts

d1

# lookup individual entries
d1["A"]
d1["C"]

#change value stored in any keys, dictionaries are mutable (can be changed)
d1["A"] = 10
d1["E"] = 100
d1

d2 = Dict("A" => 10, "B" => 30, "C" => 60, "D" => 50)
d3 = Dict("A" => 100, "E" => 150, "F" => 210)
keys(d1) # list all the keys in the dictionary
values(d1) # list all the values in the dictionary
merge(d2, d3) # merge dicts, if got conflict, julia will keep the key in the last dict entered
merge(d3,d2)

push!(d3, "G" => 350) # push bang function, adds key value pair to dict
# the mutation is permanent, now key g ady added to d3
d3

pop!(d2, "B") # permanently delete pair from dict
d2

# look up entries
"A" in keys(d1) # see got key A or not in the dict
2 in values(d2) # check if got 2 in values of dict

#= dicts are not indexed, cannot select data by index number, sort the data or select 
a range of data =#


## Tuple (allows data to be selected with the use of an index)

exit()
tp1 = () # initialise empty Tuple
typeof(tp1)

tp2 = (1, ) # put comma following the value eventhough only one entry
typeof(tp2)

tp3 = (1)
typeof(tp3) # no comma julia thinks just setting up var and not creating a Tuple

tp4 = (1, 3.14, 'c', "doggo", :red)
typeof(tp4)
tp4

# so the tuple assigns each value an index number ikut the order i put
# the indexing starts at 1
tp4[1]
tp4[2]
tp4[5]
tp4[end] # display last element in tuple
tp4[begin]
tp4[1:3]
tp4[3:end]
tp4[2: end - 1]
tp4[2:4]
tp4[1:2:5] # index 1 to 5 but skipping in increments of 2
tp4[2:2:end]

# unpack elemetns of a tuple and assign them to separate variables 
a,b,c,d,e = tp4
a
b
c
d
e

# tuples are immutable, dah set up tk boleh change
tp4[1] = 4

# can concatenate tuples with other tuples to form new tuples
tp5 = (1,2,3)
tp6 = (4,5)
tp7 = (tp5, tp6) # creating a tuple made out of tuples
typeof(tp7)
tp8 = (tp5..., tp6...) # use splat operator to unpack the tuple (get only individual elements)
tp8

# basic math using tuples
tp9 = (10,20,30,40,50)
tp9[2] + 1
tp9[3] * 4

sum(tp9) # add up all elements in tuple

# add 10 to each elemeent in tp9
b = 10
tp9 + b # cause error
tp9 * b # error

# julia got built in fucn called broadcast to broadcat operator over collection of data
tp9 .+ b
tp9 .* b

length(tp9) # number of elements

minimum(tp9) # min val in tuple
maximum(tp9)
extrema(tp9) # max and min val in tuple

tp10 = (1,2, "doggo")

#check if element is inlcuded in tuple
1 in tp10
1 ∈ tp10 # unicode \in tab
1 ∉ tp10 # \notin 

y = 212
x = 100
# swap values

interim = x
x = y
y = interim
# not efficient to do this

x = 100
y = 212

(x,y) = (y,x)
x
y
# use tuples to swap variables


## Named Tuple (hibrid of dict and tuple)

exit()

ntp = (word = "doggo", num = 3.14, sym = :red)
typeof(ntp)
# key-value pair to store and retrieve data, but unlike dict the keys in nt are stored as type symbol
ntp

ntp[1]
ntp[end]
ntp[end-1]

ntp[2:end] # error, cannot use ranges with nt

# can index by using the key symbol
ntp[:word]
ntp[:num]

# or can use dot immediately followed by the key
ntp.num
ntp.sym

# built in functions for named tuples
dump(ntp) # lists the keys, values types and values of the nt

keys(ntp)
pairs(ntp)
values(ntp)

## Array (arrays are mutable and can be indexed)
#= julia array can be a single element like a scalar, a 1D collection of 
el like vector, 2d like matrix and collection of elements in an arbitraty 
number of dimensions like a tensor. =#

exit()

a = [] # initialise empty Array
typeof(a) # a is a 1d array by default

s = [1] # scalar
typeof(s)
# in julia its a 1d array with 1 element

cv = [1,2,3] # column vector, 1d array with 1 col with an arbitraty number of elements
typeof(cv)

rv = [1 2 3] # row vector which in julia is 2d array with one row that contains an arbitraty number of element
typeof(rv)

# matrix in julia is a 2d array with arbitraty number of rows and close
m = [1 3 5; 2 4 6]
typeof(m)

# generate random number between 0 and 1
a1 = rand(4, 2, 3) # generat 4x2x3 (3d array got 4 rows, 2 cols, 3 layers)

typeof(a1)

# arrays can contain elements of any data type withing the same array
a = [1, 3.14, "doggo", :red]

# for 1d arrays like scalars and vectors, can use brackets to look up index
s[1]
cv[2]

# ways to index 2d array
m[1,2]
m[:, 3]
m[2, :]
m[1:2, 2:3]
m[end, :]
m[:, end]

# julia is column major order, index 1 is r1c1, index 2 r2c1...
m[3]
m[4]
m[:]

# arrays can be mutated
m[1,2] = 9
m

# basic math using arrays
cv
cv[2] + 1
cv[3] * 4 
sum(cv)
sum(rv)
sum(m)

b = 4
cv .+ b
cv .* b

m
size(m) # row by col dimension for the array
length(m) # number of elements in the array
eltype(m) # element type of the array
minimum(m)
maximum(m)
extrema(m)
transpose(m)
m' # shorthand syntax for transpose function
reshape(m, 3, 2) # keeps column major order
# none of these functions cause permanent changes

# these functions are for column vectors only
sort(cv, rev = true) #sorts in rev order, not permanent
cv
sort!(cv, rev = true) # permanently mutate 
cv
push!(cv, 5)
pop!(cv)
cv

# populate arrays quickly
fill(π, 5, 5) # 5x5 matrix of pi
zeros(Int64, 3,5) # 3x5 matrix of zeros
ones(Float64, 6,4)
trues(2,8)
falses(7,8)

A = [1,2,"eggdog"]
B= [1,2, "bongocat"]

# check if element is or is not in array 
1 in A
1 ∈ A
1 ∉ A

union(A,B) # creates an array of unique el in A and b
intersect(A,B)

# Array Concatenation (create array out of arrays)

exit()
a = [1,2,3]
b = [4,5,6]

c = [a,b] # using a comma gives an array of arrays

d = [a;b] # gives a vertical concatenation of values in the arrays
vertical = vcat(a,b)# same as above

e = [a b] # horizontal concatenation
horizontal = hcat(a,b) # same as up

# Arrays and Memory

exit()

a = [1,2,3]
b = a # creating an alias called b for the array called a, 
# b is not stored in a different memory storage location, instead it is simply
# pointing to the same memory loc as the array stored in loc a

a[1] = 10
a
b # both a and b changed, any changes in a will result in changes to b and vice versa
b[2] = 20
b
a

# make a copy that will not change when make changes to array a
c = copy(a) # this is called a shallow copy
c
b[2] = 100
b
a
c # c ny not change (this is a copy at dif memory location)

c[3] = 1000
a
b
c


# Data Sturctures and Memory Usage
# How much memory is consumed by each data structure?

exit()

d = Dict(1 => "apple", 2 => "banana")
tp = ("apple", "banana")
ntp = (one = "apple", two = "banana")
a = ["apple", "banana"]

varinfo()

# dictionaries offer a lot of flexibility but take the most memory
# tuples most efficient but less flexible
# arrays offer a balance between flexibiity and efficientcy

## Using rand() to generate arrays

rand(2,3)
# generates random number between 0 and 1 using uniform dist, over large sample size the av is 0.5, but the numbers are evenly distributed between o and 1

rand()

rand(5) # 1d array with five elemetns

rand(5,5) # 2d array with 5r5c

rand(5,5,5)

# not restricted to between 0 and 1 of type float64
rand(Float64,5,5)

rand(Int64, 5,5)

rand(Bool, 5,5)

# choose range of integers to use
rand(1:10, 5,5)
rand(-10:10, 5,5)
rand(10:5:100, 5, 5)


## String Indexing and Manipulation
# strings can be indexed similar to a tuple or array coz they are a collection of chars

s1 = "Hello, World!"
s1[1]
s1[2]
s1[end]
s1[end-1]
s1[3:8]
s1[11:-1:6]
s1[11:-2:6]
s1[3:2:9]
typeof(s1)
typeof(s1[1])

length(s1)
lowercase(s1)
uppercase(s1)
reverse(s1)
occursin("Hello", s1) # lookup string within a string

hooman = s1
doggo = replace(hooman, "Hello" => "Henlo")

#convert string into array
cv1 = collect(s1)
# 1d array with elemtns of type chars

cv2 = split(s1, "") #converts string into 1d with els of type substring containing els if type string

cv3 = split(s1, " ")

# convert an array containing string elements into a string
cv4 = ["a", "b", "c"]
s2 = join(cv4)
typeof(cv4)
typeof(s2)

# string are immutable but theres a workaround
s3 = "Hello"
s[1] = 'J' # coz error

s4 = "J"*s3[2:end] # combind concatenation with string indexing
s5 = replace(s3, "H" => "J")
s3 = s5
s3 # now the change is permanent

reverse!(s1) # coz error
s6 = reverse(s1)
s1=s6
s1 # now the change is permanent