@testset "Partial transpose" begin

@testset "Dense matrices" begin
  ρ =  [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16]
  trans1 = [1 2 9 10; 5 6 13 14; 3 4 11 12; 7 8 15 16]
  trans2 = [1 5 3 7; 2 6 4 8; 9 13 11 15; 10 14 12 16]
  
  res1 = ptranspose(ρ, [2, 2], [1])
  res2 = ptranspose(ρ, [2, 2], [2])
  
  @test norm(res1 - trans1) ≈ 0. atol=1e-15
  @test norm(res2 - trans2) ≈ 0. atol=1e-15

  @test_throws DimensionMismatch ptranspose(ones(2, 3), [2, 2], 1)
  @test_throws DimensionMismatch ptranspose(ones(4, 4), [2, 3], 1)
  @test_throws BoundsError ptranspose(ones(4, 4), [2, 2], 3)
end

end
