export sx, sy, sz, qft, hadamard, grover

sx = ComplexF64[0 1; 1 0]
sy = ComplexF64[0 1im; -1im 0]
sz = ComplexF64[1 0; 0 -1]

export 𝕀, I
if VERSION < v"1.2"
  @deprecate 𝕀 LinearAlgebra.I
  (I::UniformScaling)(n::Integer) = Diagonal(fill(I.λ, n))
end
𝕀(::Type{T}, dim=2) where T<: Number = Matrix(one(T)*I(dim))
𝕀(dim=2) = 𝕀(ComplexF64, dim)


"""
$(SIGNATURES)
- `d`: dimension of operator.

Prepares gate realized a [quantum Fourier transform](https://en.wikipedia.org/wiki/Quantum_Fourier_transform) of dimension `d`.
"""
qft(d::Int) = [exp(2π*1im*i*j/d) for i=0:d-1, j=0:d-1]/sqrt(d)

"""
$(SIGNATURES)
- `d`: dimension of operator.

Prepares [Grover operator](https://en.wikipedia.org/wiki/Grover%27s_algorithm) of dimension `d`.
"""
grover(dim::Int) = ones(ComplexF64,dim,dim)*2/dim - I

"""
$(SIGNATURES)
- `d`: dimension of operator.

Prepares [Hadamard operator](https://en.wikipedia.org/wiki/Hadamard_transform) of dimension `d`.
"""
function hadamard(dim::Int)
  if floor(log2(dim))!=log2(dim)
    throw(ArgumentError("Hadamard dim has to be power of 2"))
  end

  d=floor(log2(dim))
  H=1/sqrt(2)*[1 1;1 -1]
  mtx = 1
  for i=1:d
    mtx = mtx ⊗ H
  end
  return mtx
end


