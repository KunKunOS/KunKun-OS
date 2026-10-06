bits 16
org 0x8E00
start:
	mov ah, 0x00
    mov al, 0x03
    int 0x10
	mov si, msg
print_loop:
	lodsb
	or al, al
	jz done
	mov ah, 0x0E
	int 0x10
	jmp print_loop
done:
	cli
	hlt
	jmp $
msg db 0x0D, 0x0A, "FATAL_SOFTWARE_ERROR",0x0D, 0x0A
	db 0x0D, 0x0A, "ERROR CODE: 001 | BUFFER_OVERWRITE_PROTECTION", 0x0D, 0x0A
	db 0x0D, 0x0A, "Please restart", 0x0D, 0x0A, 0
times 4096 - ($ - $$) db 0
