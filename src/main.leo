// The 'shamirss_leo' program.
program shamirss_leo.aleo {

    const max_n: u32 = 10u32; // Number of shares to generate
    const max_k: u32 = 5u32; // Number of shares required to recover secret

    const n: u32 = 3u32;
    const k: u32 = 2u32;
    const km1: u32 = 1u32;

    struct Share {
        x: u32,
        y: field,
    }

    function generate_shares(secret: field, coefficients: [field; 4 /*max_k-1*/]) -> [Share; 10 /*max_n*/] {
        assert(n <= max_n);
        assert(k <= max_k);
        assert(n >= k);

        // Assuming a field type is defined elsewhere with modular arithmetic
        // let prime_modulus = choose_prime_greater_than(secret);
        // let field = new Field(prime_modulus);

        //let coefficients: [field; 4 /*max_k-1*/] = [0field; 4 /*max_k-1*/]; // Randomly generate coefficients
        // for i:u32 in 0u32..(km1 /*k-1u32*/) {
        //     coefficients[i] = ChaCha::rand_field();
        // }

        //let shares: [Share; 10 /*n*/] = [Share {x: 0u32, y: 0field}; 10 /*n*/]; // Initialize array of shares
        let shares: [Share; 10 /*n*/] = [
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field},
            Share {x: 0u32, y: 0field}]; // Initialize array of shares

        for i:u32 in 0u32..n {
            let x:field = i as field;
            let /*mut*/ y:field = secret;

            let /*mut*/ xpower:field = 1field;
            for j:u32 in 0u32..(km1 /*k-1u32*/) {
                xpower = xpower * x;
                y += coefficients[j] * xpower;
            }

            shares[i] = Share { x: i, y: y };
        }

        return shares;
    }

    function recover_secret(shares: [Share; 5 /*k*/]) -> field {
        assert(n <= max_n);
        assert(k <= max_k);
        assert(n >= k);

        // let prime_modulus = ...; // Same prime modulus as in generate_shares
        // let field = new Field(prime_modulus);

        let /*mut*/ secret:field = 0field;

        for i:u32 in 0u32..k {
            let /*mut*/ lagrange_product:field = 0field;

            for j:u32 in 0u32..k {
                if i != j {
                    lagrange_product *= (0field - shares[j].x as field) / (shares[i].x as field - shares[j].x as field);
                }
            }

            secret += shares[i].y as field * lagrange_product;
        }

        return secret;
    }


    transition main(public a: u32, b: u32) -> u32 {
        let rand_fields :[field; 4/*max_k-1*/] = [
            5298347509234875091384672345field, 
            6093485123450913845341535field, 
            34598745019283741451234104396field, 
            8714098127409182414368459183475field
        ]; 
        generate_shares(4549523035494294242134523field, rand_fields);

        let c: u32 = a + b;
        return c;
    }
}
