

function permutation_generator(alpha:: Int64)

    alpha = zeros(UInt64, 8)

    for i = UInt128(0):2 #UInt128(typemax(UInt128))

        and_bits = UInt128(0xFFFF)

        for j = 0:7

            println(bitstring(and_bits))

            println()
            
            and_bits = and_bits << 16


        end

    end

end



permutation_generator(Int64(8))
