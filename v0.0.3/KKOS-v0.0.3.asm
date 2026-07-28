org 0x7C00
start:
	mov si, msg
	mov ah, 0x00
	mov al, 0x03
	int 0x10
print_loop:
	lodsb
	or al, al
	jz done
	mov ah, 0x0E
	int 0x10
	jmp print_loop
done:
	jmp $

msg db "KunKun OS v0.0.3 - 2026/7/28 - Complied on Beijing time 17:15", 0x0D, 0x0A
	db "Now it is cleaner than the last two updates~", 0

times 510 - ($ - $$) db 0
dw 0xAA55