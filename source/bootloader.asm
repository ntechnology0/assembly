org 0x7c00            ; load code to memory

;; setting the video mode
mov ah, 0x00          ; int 0x10 / ah 0x00 is for video mode
mov al, 0x01          ; 40x25 text mode
int 0x10              ; BIOS video interrupt

mov ah, 0x0e          ; BIOS teleteype output int 10 / 0x0e ah
mov bx, bootloader_name ; move memory address of string into BX register
call print            ; calling our print function
jmp stop

print:
    mov al, [bx]      ; mov character from bx to al
    cmp al, 0
    je end            ; jump if equal (al = 0) to halt label
    int 0x10          ; BIOS video interrupt
    add bx, 1         ; move to the next byte / get next character
    jmp print

end:
    ret

stop:
    jmp $             ; ending program by looping jump here

bootloader_name: db 'NOKTA Technologies', 0xA, 0xD, 0 ; 0/null to null terminate

times 510-($-$$) db 0 ; moves by 0s till the 510th byte.
dw 0xaa55             ; boot BIOS magic number / boot signature