org 0x7C00
start:
	mov si, msg
print_loop:
	lodsb
	or al, al
	jz done
	mov ah, 0x0E
	int 0x10
	jmp print_loop
done:
	jmp $
msg db "KunKunOS v0.0.1 - Complied in 2026/7/28", 0
times 510 - ($ - $$) db 0
dw 0xAA55

	