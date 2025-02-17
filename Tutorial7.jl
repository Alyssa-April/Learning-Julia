# Here, explore how functions can use different methods, and how Julia infers the dif methods through
# multiple dispatch. Create composite types also. Also look at style guide, help it to look good, more
# readable, so can collaborate easier. 

##### Methods and Multiple dispatch
#= A function can be implemented differently depending on the type of arg presented.
For example, in julia, 1+1 and 1.0+1.0 is dif coz one adds integers while the other adds floating
point numbers. In julia, these two dif scenarios are called methods. The way to find out all the 
methods that are available for any given function is to use the built-in function called methods().
    =#

# this is the list for all the available methods for the + operator.
methods(+)

#= can find out which method julia is calling using the @which macro.
macro is like a mini program. on the surface, macros resemble functions, but they perform
very differently under the hood. macros are invoked using the @ sign =#

import Pkg
Pkg.add("InteractiveUtils")
using InteractiveUtils

@which 1+1
@which 1.0 + 1.0
@which 1 + 1.0
# the act of calling a particular method is called dispatching
# a function can have many dif methods, the process julia uses to select which method to use
#  from the list of the available methods is called multiple dispatch.
# Julia allows the dispatch process to choose which of the function's methods to call 
# based on the number of arguments given and on the types of all the args. 
# other language dispatch happens based on the first arg and ignores the other args. 
# using all the args instead of just the first is known as multiple dispatch.
# julia can find the method without being told and with little to no performance performance hit. 

#= when creating your own function, you have the opportunity to set up dif methods for your function.
this is done by using the :: (colon colon type assertation operator) to assert that an arg
in ur func is of a certain datatype. can have multiple methods for the same function and the same
func can behave differently when using dif datatypes. =#

# generic function to test out different methods
function methodtest(x,y)
    println("This is the default method for $x and $y")
end
methodtest(1,2)

# set up first method for new func by using :: immediately following the arguments
# assert that both x and y are of type integer
function methodtest(x::Integer, y::Integer)
    println("$x plus $y equals ", x + y)
end
#= the datatype integer is called an abstract type since it includes all of the different types of
integers tracked in julia. The specific datatypes like Int64 and Int32 are called primitive types. 
These are the concrete types and are included within the abstract type called integer. =#

methodtest(1,2)
methodtest(1.1, 2.2)

# Float64 and Float32 are the primitive types included in AbstractFloat
function methodtest(x::AbstractFloat, y::AbstractFloat) # includes all the dif floating point numbers tracked in Julia
    println("$x times $y equals $(x*y)")
end

methodtest(1,2)
methodtest(1.1, 2.2)
methodtest(1,1.1)

# method to handle strings
function methodtest(x::String, y::String)
    println("""Concatenating $x and $y yields "$(x*' '*y)" """)
end

methodtest("Hello", "World")

# this same as up (this doggo gave)
function methodtest(x::String, y::String)
    println("""Concatenating $x and $y yields "$x $y" """)
end

# list the dif methods established by using methods()
methods(methodtest)

# check which method is being used by using the @which macro
@which methodtest(1,2)
@which methodtest(1.1,2.2)
@which methodtest("Hello", "World")
@which methodtest("doggo",3.14)

#= why do we define methods for our functions (in general no need).
if func requires a specific datatype, or behave dif depending on datatype, then setting up
dif methods is a must. =#

### Composite Type
#= In julia, there are three main DTs, namely, abstract, primitive and composite. 
User defined DT is called a composite type. A composite type is a collection of named fields that can
contain a value. Composite types are the most commonly used user-defined type in Julia. 

struct Name
    <code>
end
=#

struct MyType # mytype is the name of the composite type
    x
    y::Integer
    z::AbstractFloat # x y z are the named fields
end
# the convention is to name the composite types like the built in abstract and primitive types
# start name with uppercase and use camel case if multiple words ("CamelCase")
# Also when asserting types, the convention is to use abstract types rather than primitive types

typeof(MyType)
# it is of type DT

#view named fields
fieldnames(MyType)
typeof(:x) # the fields are of type symbol

# populate composite type with values, enter values like in tuple or func
mt = MyType("doggo", 1, 3.14)
# when a type is applied like a func, it is called a constructor

typeof(mt)
# the DT of the var mt is MyType (the composite type we just created)
# CT is constructed similar to a dict, rather than use Dict(), use name of CT,
# but no need to enter separate keys, since ady have named fields in the CT that act as the keys to
# the values. bcs the named fields are of type symbol, can access the values using the dot notation
# just like you would in a named tuple. 

# access field values
mt.x
mt.y
mt.z

# see memory usage
d = Dict('x' => "doggo", 'y' => 1, 'z'=>3.14)
tp = ("doggo", 1, 3.14)
ntp = (x = "doggo", y = 1, z = 3.14)
a = ["doggo", 1, 3.14]

varinfo()
# dict most mem, tuple least, CT use more mem than tuple but lot less than array
# if need container to hold data but tuple too restrictive, but dont need everything of array,
# can set up own CT 

# CT are immutable by default
mt.x = "catto"

# however, you can create mutable CT 
mutable struct MyMutable
    x
    y::Integer
    z::AbstractFloat
end

mm = MyMutable("doggo", 1, 3.14)
mm.x
mm.x = "catto"
mm
mm.x = π
mm.x

mm.y = "doggo"
# name field y must be of type integer
mm.y = 100
# for x can cause we never make any assertations, so julia use the type any for named field x

### Exercise
# Create a Custom Data Storage and Retrieval Tool using Composite Types, Functions and Methods

struct Pet
    age::Integer
    weight::Integer
end

struct Dog
    id::Pet
    color::String
    breed::String
end

struct Cat
    id::Pet
    food::String
    instrument::String
end

# one function with two methods coz behave dif for a dog or a cat
# for each method, interpolate dif values from dif named fields from the CTs, 
# by using the dot format to access the values
function tellmeabout(animal::Dog)
    println("I am a $(animal.id.age) year old $(animal.color) $(animal.breed).")
end

function tellmeabout(animal::Cat)
    println("I love to eat $(animal.food) and play the $(animal.instrument).")
end

# can use the constructor for the CT pet as a value in the constructor for the CTs Dog and Cat
eggdog = Dog(Pet(2,1), "white", "egg.dog mix")

bongocat = Cat(Pet(25,25), "catnip", "bongos")

tellmeabout(eggdog)

tellmeabout(bongocat)
# here we opted to create our own CTs bcs it allows more flexibility than a tuple and 
# use a lot less mem than a dict

methods(tellmeabout)

typeof(Pet)
typeof(Dog)
typeof(Cat)
typeof(eggdog)
typeof(bongocat)
fieldnames(Pet)
fieldnames(Dog)
fieldnames(Cat)
eggdog
bongocat
eggdog.breed
eggdog.id
eggdog.id.weight
bongocat.instrument
bongocat.id.age
typeof(eggdog.breed)
typeof(eggdog.id)
typeof(eggdog.id.weight)

# teaches us the power of own custom CTs combined with using dif methods for custom functions

### Style Guide
#= one of the primary purposes of a language is to communicate tots and ideas with other people. 
coming up with ur own style may seem appealing, but a unique stye may be difficult to share work with others.
and it could be more difficult for someone to help u when u run into a problem.
Guidelines are from the github repository of John Myles White. But he recommends following the 
official style guide found in the Julia documentation. =#

#=
1. Never place more than 80 characters on a line.
2. Always include a single space after a comma (x, y, z)
3. Never insert a space before a comma (this is wrong (x , y , z))
4. Always insert a single space before and after an operator (1 + 1), except for the
   ^ and : operators, which never have spaces around them (10^3); (1:10)
5. The spacing before-and-after rule applies to "kwargs" as well (foo(a = 1))
6. Avoid writing overly specific Types
7. Use naming conventions consistent with Julia base
8. Type names using capitalisation and CamelCase (AbstractFloat)
9. Functions are lowercase with multiple words squashed together (isequal())
10. When necessary use underscores as word separators (remotecall_fetch)
11. Conciseness is valued, but avoid abbreviation (good: indexin) (bad: indxin)
