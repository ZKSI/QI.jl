using QI
⊗ = kron
using Base.Test

my_tests = ["base.jl",]

println("Running tests:")

for my_test in my_tests
    println(" * $(my_test)")
    include(my_test)
end