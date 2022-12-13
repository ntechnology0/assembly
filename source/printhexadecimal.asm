;;; Ascii '0'-'9' = hex 0x30-0x39
;;; Ascii 'A'-'F' = hex 0x41-0x46
;;; Ascii 'a'-'f' = hex 0x61-0x66

print_hexadecimal:
    pusha        ; pushing all the registers to the stack
    mov cx, 0    ; initializing the loop counter

print_loop:
    cmp cx, 4    ; check if we're at the end of the loop
    je end_loop

    mov ax, dx
    and ax, 0x000F ; turn first 3 hex to 0, keep final digit to convect to ascii
    add al, 0x30   ; get ascii number
    cmp al, 0x39   ; check if hex value 0-9 (<= 0x39) or A-F ( > 0x39)
    
    jle move_to_bx
    add al, 0x07   ; to get ascii 'A' - 'F'

move_to_bx:
    mov bx, hexadecimal_string + 5  ; base address of hexadecimal_string + length of string
    sub bx, cx                      ; substract loop counter
    mov [bx], al
    ror dx, 4                       ; rotate right by 4 digits
                                    ; 0x12AB -> 0xB12A -> 0xAB12 -> 0x2AB1 -> 0x12AB
    add cx, 1                       ; increment looper counter
    jmp print_loop                  ; loop for next hex digit in DX

end_loop:
    mov bx, hexadecimal_string
    call print_string

    popa         ; returning all the registers values from the stack
    ret          ; returning to the caller

;;; data variables
hexadecimal_string: db '0x0000',  0xA, 0xD, 0