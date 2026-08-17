bits 16
org 0x8E00
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
msg db 0x0D, 0x0A, "Congratulation! You have entered [REDACTED] mode", 0x0D, 0x0A
	db "Have good luck to try to decrypt this RC4:", 0x0D, 0x0A
	db "U2FsdGVkX19Ye5dRYo+Y4Q/UzmqpIPczEoDWsU01rR979r/FNcM+wvaEDkimErAD8XQMlvfVJU3p3VN1I20IfJ5fhoZE4GkC", 0x0D, 0x0A
	db "Key: KKOS", 0x0D, 0x0A, 
	db "Restart to go back in to normal mode.", 0
times 4096 - ($ - $$) db 0
