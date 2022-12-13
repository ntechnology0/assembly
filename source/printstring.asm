;;;
;;; -- Printing all characters in BX register
;;;

print_string:
    pusha             ; pushing all the registers to the stack
    mov ah, 0x0e      ; BIOS teleteype output int 10 / 0x0e ah

print_character:
    mov al, [bx]      ; mov character from bx to al
    cmp al, 0
    je end            ; jump if equal (al = 0) to halt label
    int 0x10          ; BIOS video interrupt
    add bx, 1         ; move to the next byte / get next character
    jmp print_character

end:
    popa              ; restore registers from the stack before returning
    ret