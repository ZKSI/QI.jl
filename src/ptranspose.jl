export ptranspose
"""
$(SIGNATURES)
- `ρ`: quantum state.
- `idims`: dimensins of subsystems.
- `isystems`: transposed subsystems.

Return [partial transposition](http://en.wikipedia.org/wiki/Peres-Horodecki_criterion) of matrix `ρ` over the subsystems determined by `isystems`.
"""
function ptranspose(ρ::AbstractMatrix{<:Number}, idims::Vector{Int}, isystems::Vector{Int})
    dims = reverse(idims)
    systems = length(idims) .- isystems .+ 1

    if size(ρ,1)!=size(ρ,2)
        throw(ArgumentError("Non square matrix passed to ptrace"))
    end
    if prod(dims)!=size(ρ,1)
        throw(ArgumentError("Product of dimensions do not match shape of matrix."))
    end
    if maximum(systems) > length(dims) ||  minimum(systems) < 1
        throw(ArgumentError("System index out of range"))
    end

    offset = length(dims)
    tensor = reshape(ρ, [dims; dims]...)
    perm = collect(1:(2offset))
    for s in systems
        idx1 = findall(x->x==s, perm)[1]
        idx2 = findall(x->x==(s + offset), perm)[1]
        perm[idx1], perm[idx2] = perm[idx2], perm[idx1]
    end
    tensor = permutedims(tensor, invperm(perm))
    reshape(tensor, size(ρ))
end

"""
$(SIGNATURES)
- `ρ`: quantum state.
- `idims`: dimensins of subsystems.
- `sys`: transposed subsystem.
"""
ptranspose(ρ::AbstractMatrix{<:Number}, idims::Vector{Int}, sys::Int) = ptranspose(ρ, idims, [sys])

function _ptranspose(ρ::AbstractMatrix{<:Number}, idims::Vector{Int}, isystems::Vector{Int})
    ns = length(idims)

    ex1 = Expr(:ref, :x)
    ex2 = Expr(:ref, ρ)

    I = Expr(:tuple, [gensym() for _=1:ns]...)
    J = Expr(:tuple, [gensym() for _=1:ns]...)

    K = copy(I)
    L = copy(J)

    r = Expr(:tuple)
    for (k, (i, j)) in enumerate(zip(K.args, L.args))
        push!(r.args, :($i:$(idims[k])), :($j:$(idims[k])))
    end
    for s in isystems
        K.args[s], L.args[s] = L.args[s], K.args[s]
    end
    push!(ex1.args, I, J)
    push!(ex2.args, L, K)

    ex = Expr(:(:=), ex1, ex2)
    ex, r
    @eval @cast $ex $r
end