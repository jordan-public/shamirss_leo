// The 'shamirss_leo' program.
program shamirss_leo.aleo {
    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
}
