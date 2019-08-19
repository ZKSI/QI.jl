import .Base: length, iterate
export AbstractMatrixBasisIterator, HermitianBasisIterator, AbstractBasis,
    AbstractMatrixBasis, HermitianBasis, hermitianbasis, represent, combine
abstract type AbstractMatrixBasisIterator{T<:AbstractMatrix} end
struct HermitianBasisIterator{T} <: AbstractMatrixBasisIterator{T} 
    dim::Int
end

abstract type AbstractBasis end
abstract type AbstractMatrixBasis{T} <: AbstractBasis where T<:AbstractMatrix{<:Number} end 

struct HermitianBasis{T} <: AbstractMatrixBasis{T} 
    iterator::HermitianBasisIterator{T}

    function HermitianBasis{T}(dim::Integer) where T<:AbstractMatrix{<:Number}
        new(HermitianBasisIterator{T}(dim)) 
    end
end

"""
$(SIGNATURES)
- `dim`: dimensions of the matrix.

Returns elementary hermitian matrices of dimension `dim` x `dim`.
"""
hermitianbasis(T::Type{<:AbstractMatrix{<:Number}}, dim::Int) = HermitianBasisIterator{T}(dim)

hermitianbasis(dim::Int) = hermitianbasis(Matrix{ComplexF64}, dim)


function iterate(itr::HermitianBasisIterator{T}, state=(1,1)) where T<:AbstractMatrix{<:Number}
    dim = itr.dim
    (a, b) = state
    a > dim && return nothing

    Tn = eltype(T)
    if a > b
        x =  (im * ketbra(T, a, b, dim) - im * ketbra(T, b, a, dim)) / sqrt(Tn(2))
    elseif a < b
        x = (ketbra(T, a, b, dim) + ketbra(T, b, a, dim)) / sqrt(Tn(2))
    else
        x = ketbra(T, a, b, dim)
    end
    return x, b==dim ? (a+1, 1) : (a, b+1)
end

length(itr::HermitianBasisIterator) = itr.dim^2

function represent(basis::T, m::Matrix{<:Number}) where T<:AbstractMatrixBasis
    real.(tr.([m] .* basis.iterator))
end

function represent(basis::Type{T}, m::Matrix{<:Number}) where T<:AbstractMatrixBasis
    d = size(m, 1)
    represent(basis{typeof(m)}(d), m)
end

function combine(basis::T, v::Vector{<:Number}) where T<:AbstractMatrixBasis
    sum(basis.iterator .* v)
end