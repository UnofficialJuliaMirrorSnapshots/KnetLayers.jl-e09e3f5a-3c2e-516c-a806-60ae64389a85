include("header.jl")

@testset "mlp" begin
     atype = KnetLayers.arrtype
     x =atype(randn(10,2))
     m = MLP(10,5,2;winit=randn,binit=zeros)
     y = m(x)
     @test true
end
