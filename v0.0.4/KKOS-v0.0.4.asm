bits 16
org 0x7C00

start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    mov si, msg
    call print

main_loop:
    mov si, prompt
    call print
    mov ah, 0x00
    int 0x16
    cmp al, 0x0D
    je enter_pressed
	cmp al, "R" ;thanks NASM for letting me write like this ~~~
	je reboot
    mov ah, 0x0E
    int 0x10
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    jmp main_loop
enter_pressed:
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    jmp main_loop
reboot:
	jmp 0xFFFF:0x0000 ;beautiful!

print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print

.done:
    ret
msg db "KunKun OS v0.0.4 - 2026/7/28 - UTC+8 22:27", 0x0D, 0x0A
    db "This is a prototype shell", 0x0D, 0x0A,
	db "Press 'R' to restart!" 
prompt db ">>> ", 0
times 510 - ($ - $$) db 0
dw 0xAA55