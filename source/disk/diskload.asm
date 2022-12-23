disk_load:
    push dx         ; store DX on stack so we can check number of sectors actually read later

    mov ah, 0x02    ; int 13h/ah=02h, BIOS read disk sectors into memory
    mov al, dh      ; number of sectors we want to read
    mov ch, 0x00    ; cylinder 0
    mov dh, 0x00    ; head 0
    mov cl, 0x02    ; start reading at CL sector (sector 2 in this case, right after our bootsector)

    int 0x13        ; BIOS interrupts for disk functions

    jc disk_error   ;jump if disk read error (carry flag set/ = 1)

    pop dx          ; restore dx from the stack
    cmp dh, al      ; if AL(# of sectors actually read) != DH (# sectors we wanted to read)
    jne disk_error  ; error, sectors read not equal to number we wanted to read
    ret
    
disk_error:
    mov bx, disk_error_msg
    call print_string
    hlt

disk_error_msg: 
    db 'We have encountered an error reading the disk.', 0