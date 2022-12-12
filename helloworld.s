.global _start
.align 2

_start: mov X0, #1
        adr X1, helloworld_str
        mov X2, #36
        mov X16, #4
        svc #0x00

        mov X0, #0
        mov X16, #1
        svc #0x00

helloworld_str: .ascii "Hello Oussama, How are you doing ?\n"