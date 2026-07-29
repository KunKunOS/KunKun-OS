bits 16
org 0x7E00
start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    mov si, msg
    call print
print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print
.done:
	jmp $
msg db "KunKunOS v0.0.5 - 2026/7/29", 0x0D, 0x0A
	db "For technical reasons, the shell in v0.0.4 has been temporarily shutdown", 0
times 2048 - ($ - $$) db 0