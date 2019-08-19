@testset "MatrixBases" begin

@testset "HermitianBasisIterator" begin
    d = 4
    m = collect(HermitianBasisIterator{Matrix{ComplexF64}}(d))
    @test [tr(m[i]' * m[j]) for i=1:d, j=1:d] ≈ Matrix{Float64}(I, d, d)
end

@testset "represent, combine" begin
    d = 4
    A = reshape(collect(1:16), d, d) + reshape(collect(1:16), d, d)'
    vA = represent(HermitianBasis{Matrix{ComplexF64}}(d), A)
    Ap = combine(HermitianBasis{Matrix{ComplexF64}}(d), vA)
    @test A ≈ Ap
    B = A*A'
    vB = represent(HermitianBasis{Matrix{ComplexF64}}(d), B)
    Bp = combine(HermitianBasis{Matrix{ComplexF64}}(d), vB)
    @test B ≈ Bp

    vB = represent(HermitianBasis{Matrix{ComplexF32}}(d), B)
    @test eltype(vB) == Float32
end

end