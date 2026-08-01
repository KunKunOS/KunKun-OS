bits 16
org 0x7C00
start:
    push dx ;200% protection, put in stack
    mov ah, 0x00 ;good old printing
    mov al, 0x03
    int 0x10
    mov si, loading_msg
    call print
    pop dx ;get the value out of the stack and copy to dx
    mov ax, 0x0000 ;put 0x0000 to ax
    mov es, ax ;copy ax to es
    mov bx, 0x7E00 ;this is bx
    mov ah, 0x02 ;read disk
    mov al, 0x08 ;read 8 (4KB)
    mov ch, 0x00 ;start from 0
    mov cl, 0x02 ;please DO NOT WRITE 0x01 (unless you want to see a infinite MBR)
    mov dh, 0x00 ;start from 0
    int 0x13 
    jc load_error ;if int 0x13 falied, go to load_error
    jmp 0x0000:0x7E00 ;jump to the kernel
load_error:
    mov si, error_msg
    call print
    jmp $

print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print
.done:
    ret

loading_msg db "KunKunOS v0.0.5: Loading from MBR...", 0x0D, 0x0A, 0
error_msg   db "Disk read failed. Try and restart, if it cannot help, file the problem on GitHub", 0
times 510 - ($ - $$) db 0
dw 0xAA55