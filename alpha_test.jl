# using Debugger

using Plots

function gen_predictive_dist(n ::Int64, m ::Int64, d ::Int64, y ::Int64)

    alpha = zeros(UInt64, n)

    alpha_plus_d = zeros(UInt64, n)

    max_range = UInt128((2^m)^n)

    x_range = zeros(UInt64, max_range)

    res = zeros(Int8, max_range)

    for i = UInt128(0):UInt128(max_range - 1)

        alpha = gen_permutation(i, n, m)

        for j = 1:length(alpha)

            alpha_plus_d[j] = alpha[j] + d

        end

        println(alpha)

        res[i+1] = round(Int8, (log2(alpha[y] + d) - log2(sum(alpha_plus_d) + d*n)))

        x_range[i+1] = i

        # @bp

        # println(i, " ", res[i+1])

    end

    return x_range, res

end


function gen_permutation(i ::UInt128, n ::Int64, m ::Int64)

    set = zeros(UInt64, n)

    and_bits = UInt128(2^m - 1)

    a = UInt128(0)

    for j = 0:(n-1)

        a = and_bits & i

        set[j+1] = a >> (j * m)
        
        and_bits = and_bits << m

    end

    return set
    
end


# println(gen_permutation(UInt128(0x1), 8, 8))

# println(gen_permutation(UInt128(0x1_0000_0000_0000), 8, 16))

#res = gen_predictive_dist(6, 5, 20, 1)

x_range, res = gen_predictive_dist(3, 2, 1, 1)

p = bar(x_range, res, title="Dirichlet plot")

savefig(p, "bar.pdf")
