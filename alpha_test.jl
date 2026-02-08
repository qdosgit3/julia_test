

function p_y_given_theta(alpha_len ::Int64, d ::Int64, y ::Int64)

    alpha = zeros(UInt64, alpha_len)

    alpha_plus_d = zeros(UInt64, alpha_len)

    res = zeros(UInt16, 65536^16)

    for i = UInt128(0):2 #UInt128(typemax(UInt128))

        alpha = generate_permutation(i, alpha_len)

        for j = 1:length(alpha)

            alpha_plus_d[j] = alpha[j] + d

        end

        res = sum(alpha_plus_d)

    end

end


function generate_permutation(i ::UInt128, alpha_len ::Int64)

    alpha = zeros(UInt64, alpha_len)

    and_bits = UInt128(0xFFFF)

    a = UInt128(0)

    shift_size = div(128, alpha_len)

    for j = 0:7

        println(bitstring(and_bits))

        println()

        a = and_bits & i

        alpha[j+1] = a >> (j * shift_size)
        
        and_bits = and_bits << shift_size

    end

    return alpha
    
end


generate_permutation(UInt128(1), 8)

#permutation_generator(8, 100)
