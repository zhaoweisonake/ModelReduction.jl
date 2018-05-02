# This file is a part of JuliaFEM.
# License is MIT: see https://github.com/JuliaFEM/ModelReduction.jl/blob/master/LICENSE

"""
    block_multiply(X, R, A)

Perform matrix multiplication block-wise: B = X*R*X'*A
"""
function block_multiply(X, R, A; n=3)
    N, M = size(X)
    T = floor.(Int, linspace(0, N, n+1))
    spans = collect(T[i]+1:T[i+1] for i=1:n)
    B = similar(A)
    fill!(B, 0.0)
    local i, j
    for i=1:n
        for j=1:n
            a = spans[i]
            b = spans[j]
            B[a,:] += X[a,:]*R*transpose(X[b,:])*A[b,:]
        end
    end
    return B
end
