##### Searching and Sorting Algorithms; Program Efficiency 

### Searching Algorithms 
#= A good way to examine algorithms is to look at dif searching and sorting algorithms.

Common searching algo: 
1. Linear Search Algorithm --> Goes through every item in a collection to find the one item
that its looking for. The algo gets the job done but is rather unsophisticated.
2. Binary Search Algorithm --> More sophisticated. Does not check every item in the collection. It splits
the collection into 2 even groups and determines if the desired item is in Group 1 or Group 2. 
If its in g1, the algo discards g2 and vice versa. the process is repeated until the desired 
item is located. =#

## Linear Search Algorithm
function linearsearch(haystack, needle)
    flag = false
    for i in 1:length(haystack)
        check = haystack[i] == needle
        if check
            flag = true
        end
        println("Index[$i] = $(haystack[i]) == $needle? ", check)
    end
    if flag 
        println("\n$needle is in the collection.\n")
    else
        println("\n$needle is not in the collection.\n")
    end
    return flag
end

data = rand(1:100, 10)
haystack = [data..., 42]
linearsearch(haystack, 101)
linearsearch(haystack, 42)
linearsearch(haystack, 4)
#= this type of search algo is also known as a brute force search algo, bcs it checks every single 
item in the collection. the benefits are that its easy to implement, it doesnt care if the collection 
is sorted, and it will always find a solution. the downside is that its not the most efficient. 
even if the desired item is the first item in the collection, this algo will still go on to check
every other item in the collection. =#

### Binary Search Algorithm

#= Guessing game: Select a number between 1 and 100, julia will guess it using binary 
search. The catch is that you will have to give feedback to Julia whether the guess is too
low or too high. =#

"""
    guessinggame()
Use the Binary Search Algorithm to guess a user's whole number betweeb 
1 and 100 based on the user's feedback.

After the guess is displayed, the user enters l, h or c for lower,
higher or correct.

Repeat this process until the correct number is guessed. 
Credit : Rosetta Code (rosettacode.org), with some modification.
"""
function guessinggame()
    # initialise variables
    lower = 0
    upper = 100
    attempts = 1
    println("\nThink of a number between 1 and 100")
    println("and I will guess it within 7 guesses.")
    println("Press ENTER when you are ready.")
    readline()
    # algorithm
    while true
        guess = lower + round(Int, (upper - lower) / 2, RoundUp)
        if attempts > 7
            break
        end
        println("I guess ", guess, ".\n[l]ower, [h]higher or [c]orrect? ")
        input = readline()
        while input ∉ ["l", "h", "c"]
            print("Please enter [l], [h] or [c]: ")
            input = readline()
        end
        if input == "l"
            upper = guess
        elseif input == "h"
            lower = guess
        else
            break
        end
        attempts += 1
    end
    # display result
    if attempts > 7
        println("\nI give up. Did you forget your number?")
    elseif attempts == 1 
        println("\nI win! It only took me 1 guess!")
    else
        println("\nI win! It took me $attempts guesses.")
    end
end
# enter ? in the REPL and guessinggame to see the markdown text

## Built-in Search Tools

haystack = ["no", "?", "yes", "maybe", "yes"]
needle = "yes"

needle in haystack
needle ∈ haystack

# if wanna search for the index number where the needle is located in the haystack
findfirst(isequal(needle), haystack) # first instance is located at index 3 of the array haystack
findlast(isequal(needle), haystack)
findall(isequal(needle), haystack)
# these three are examples of higher-order function. in computing, a higher-order function is a function
# that takes one or more functions as args. in the three find funcs, the first arg is a built in func
# that returns either true or false. the second argument was the collection of data to search.
# The find funcs return the index or indices, where the return value of the isequal() func is "true".

# Built In Search functions

haystack = rand(-10:10, 10)

# returns a tuple with a min value in the collection along with its index number
findmin(haystack)
findmax(haystack)
extrema(haystack) # min and max value but no index number

### Sorting Algorithms

# Example: Bogosort --> take collection of data and shuffling randomly. Like throwing a deck of cards
# into the air and seeing where they land. The bogosort algo repeats this process until it finds a 
# collection that just happens to be sorted. =#

using Random

# issorted() is a built in func that tests whether a collaction is sorted or not. 
function bogosort!(data::AbstractVector)
    counter = 1
    println("Sort = $counter:\t$data")
    while !issorted(data)
        shuffle!(data)
        counter += 1
        println("Sort = $counter:\t$data")
    end
    return data
end

data = rand(-10:10, 7)
println("\ninitial:\t$data\nbogosort!:\t", bogosort!(data))
# small data set ok but for large data set will be inefficient
# bogosort is a permanent sort

# Example: Bubble Sort
# Uses for loop with a nested for loop to compare the values of adjacent itemms in the data set.
# If the two values are not sorted, the algo swaps their order. If they are already sorted, the algo
# skips to the next pair.

function bubblesort!(data::AbstractVector)
    len = length(data)
    for i in 1:(len - 1)
        println("Outer Loop $i:\t$data")
        for j in 1:(len - 1)
            if data[j] > data[j + 1]
                data[j], data[j + 1] = data[j + 1], data[j]
                println("  Inner Loop $j:\t$data")
            end
        end
    end
    return data
end
# it has to go through all iterations even if there are no changes to be made
# more practical then bogosort but still inefficient due to the nested for loop

data = rand(-10:10, 10)
println("\nInitial:\t$data\nbubblesort!:\t", bubblesort!(data))
data

## Example: Selection Sort
#= Compares the first item in the collection with the minimum value in the remaining items. If
the first item is higher in value, then it swaps positions with the other value. If the first item 
is lower, then the algo skips it and moves to the second item. repeats process until cycled through
all the items. =#

function selectionsort!(data::AbstractVector)
    println("Initial:\t", data)
    len = length(data)
    if len < 2
        return data
    end
    for i in 1:(len - 2)
        localmin, index = findmin(data[(i+1):end])
        if localmin < data[i]
            data[i], data[i + index] = localmin, data[i]
        end
        println("Sort = $i:\t", data)
    end
    return data
end
#= the output looks cleaner but got hidden inefficientcy. it only takes few steps but we dont see
the steps being taken by the findmin() func. The findmin() func is cycling through all the remaining items
in the collection to find the item with min value. =#

data = rand(-10:10, 10)
println("\nInitial:\t$data\nselectionsort!:\t", selectionsort!(data))


## Example: Merge Sort
# Uses a recursive algorithm. 

function mergesort(data::AbstractVector)
    println("split data:\t", data)
    # base case
    if length(data) < 2
        println(" base case:\t", data)
        return data
    end
    # recursive case
    middle = length(data) ÷ 2
    leftside = mergesort(data[1:middle])
    rightside = mergesort(data[(middle + 1):end])
    merged = copy(data)
    index = rightindex = leftindex = 1
    while leftindex <= length(leftside) && rightindex <= length(rightside)
        if leftside[leftindex] <= rightside[rightindex]
            merged[index] = leftside[leftindex]
            leftindex += 1
        else 
            merged[index] = rightside[rightindex]
            rightindex += 1
        end
        index += 1
    end
    if leftindex <= length(leftside)
        merged[index:end] = leftside[leftindex:end]
    else
        merged[index:end] = rightside[rightindex:end]
    end
    println("  mergesort:\t", merged)
    return merged
end
#= most efficient sorting algo but it too has hidden inefficiency. 
it may be efficient in the number of steps required but the algo requires the use of intermediate
arrays, which take up memory. merge sort is not a permanent sort. =#

data = rand(-10:10,8)
println("\nInitial:\t$data\nmergesort:\t", mergesort(data))

### Built-In Sorting Tools

data = rand(-10:10, 10)

# sorts the collection from low to high and is not permanent
sort(data)

# sort from high to low and is not permanent
sort(data, rev = true)

# sort from low to high and is permanent
sort!(data)

# sort from high to low and is permanent
sort!(data, rev = true)

# checks whether or not a collection is already sorted from low to high
issorted(data)

# check whether or not is not sorted from low to high
!issorted(data)

#= julia has several dif sorting algorithms at its disposal. it selects the most
efficient algo based on the DT that needs to be sorted =#

data = rand(-10:10, 10)

# can choose which sorting algo u want oso
sort(data, alg = InsertionSort)
sort(data, alg = QuickSort)
sort(data, alg = MergeSort)
# performance will be noticeable with large data sets of dif DTs

### Program Efficiency

#= Learn the concepts behind measuring program efficiency. 

How to measure program efficiency:
1. Measure it using a timer (done before using benchmark tool), but the result can
vary by the computer running the Code
2. count the number of operations. becomes more difficult to do as the complexity grows.
3. Use an abstract notion of order of growth. look at worst case scenario, and determine how it
grows with complexity and then to classify it using the big O notation. In computing,
the big O notation is used to classify algorithms according to how the run time or space 
requirements grow as the input size grows. The growth rate of the function is also referred to 
as the order of the function, which is where the O comes from in the Big O notation. 
There are many dif classifications within the big o notation spectrum. =#

# Use Makie plotting package to visualise the Big O curves
using Makie
using GLMakie

O1(n) = log(n)
O2(n) = n
O3(n) = n * log(n)
O4(n) = n^2
O5(n) = 2^n

n = 0:0.01:10

# initialises a blank scene
scene = Scene()

scene = lines(n, O1, color = :blue, linewidth = 2)
scene = lines!(n, O2, color = :cyan, linewidth = 2)
scene = lines!(n, O3, color = :green, linewidth = 2)
scene = lines!(n, O4, color = :magenta, linewidth = 2)
scene = lines!(n, O5, color = :red, linewidth = 2)

# Take a look at the algo written and classify them using the big o notation
include("Tutorial9.jl")

cbrtbinarysearch(10)
# hear back this part