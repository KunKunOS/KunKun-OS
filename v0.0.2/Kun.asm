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
msg db "KunKunOS v0.0.2 - Complied in 2026/7/28 - Bejing time 15:45", 0x0D, 0x0A
	db "Just wait for v0.0.3", 0
times 510 - ($ - $$) db 0
dw 0xAA55
