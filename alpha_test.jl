using Debugger

function gen_predictive_dist(n ::Int64, m ::Int64, d ::Int64, y ::Int64)

    alpha = zeros(UInt64, n)

    alpha_plus_d = zeros(UInt64, n)

    max_range = UInt128((2^m - 1)^n)

    res = zeros(UInt8, max_range)

    for i = UInt128(0):UInt128(max_range)

        alpha = gen_permutation(i, n, m)

        for j = 1:length(alpha)

            alpha_plus_d[j] = alpha[j] + d

        end

        res[i+1] = div((alpha[y] + d), (sum(alpha_plus_d) + d*n))

    end

    return res

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

@enter res = gen_predictive_dist(6, 5, 20, 1)

for r in res

    println(r)

end
