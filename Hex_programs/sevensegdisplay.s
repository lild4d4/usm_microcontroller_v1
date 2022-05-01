.globl main

main:
    li t0, 0x0
    add t1,t0,0x4
    add t2,t0,0x8

repeat:
    add t3,t0,0xFFFF
    sw  t3,0(t2)
    j repeat