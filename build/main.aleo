program shamirss_leo.aleo;

struct Shares:
    is as [u32; 3u32];
    ss as [field; 3u32];


function main:
    input r0 as u32.public;
    input r1 as u32.private;
    add r0 r1 into r2;
    output r2 as u32.private;
