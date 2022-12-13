org 0x7c00              ; load code to memory

;; setting the video mode
mov ah, 0x00            ; int 0x10 / ah 0x00 is for video mode
mov al, 0x07            ; 80x25 text mode
int 0x10                ; BIOS video interrupt

mov bx, bootloader_name ; move memory address of string into BX register
call print_string       ; calling our print function

mov dx, 0x12AB          ; sample number to print
call print_hexadecimal  ; calling our print print function for hex numbers

jmp $                   ; ending program by looping jump here

;; including files functions
%include "printstring.asm"
%include "printhexadecimal.asm"

bootloader_name: db 'NOKTA Technologies', 0xA, 0xD, 0 ; 0/null to null terminate

times 510-($-$$) db 0 ; moves by 0s till the 510th byte.
dw 0xaa55             ; boot BIOS magic number / boot signature