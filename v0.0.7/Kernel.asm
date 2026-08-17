bits 16
org 0x7E00

start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    mov si, welcome_msg
    call print

main_loop:
    mov si, prompt
    call print
    mov ah, 0x00
    int 0x16
    cmp al, 0x0D
    je enter_pressed
    cmp al, 'R'
    je reboot
    cmp al, 'r'
    je reboot
    cmp al, 'V'
    je show_version
    cmp al, 'v'
    je show_version
	cmp al, 'N'
	je new_adds
	cmp al, 'n'
	je new_adds
	cmp al, 'H'
	je helps
	cmp al, 'h'
	je helps
	cmp al, 'K'
	je cool
	cmp al, 'k'
	je cool
	
    mov ah, 0x0E
    int 0x10
    mov si, unknown_msg
    call print
    call newline
    jmp main_loop

enter_pressed:
    call newline
    jmp main_loop

show_version:
    mov si, version_msg
    call print
    call newline
    jmp main_loop
	
new_adds:
    mov si, new_msg
    call print
    call newline
    jmp main_loop
	
helps:
    mov si, help
    call print
    call newline
    jmp main_loop

reboot:
    jmp 0xFFFF:0x0000

cool:
	jmp 0x0000:0x8E00

print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print
.done:
    ret

newline:
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret
welcome_msg db "KunKunOS v0.0.6", 0x0D, 0x0A
            db "Type 'H' for help", 0x0D, 0x0A, 0
prompt       db  0x0D, 0x0A, ">>> ", 0
unknown_msg  db " is a(n) Unknown command", 0
version_msg  db 0x0D, 0x0A, "KunKunOS v0.0.7 - 2026/8/17", 0x0D, 0x0A
			 db "Made form pure NASM", 0x0D, 0x0A
			 db "This software and the user interface is protected by GNU GPL v3.0", 0
new_msg db 0x0D, 0x0A, "The shell is back, and loads 4KB clusters!", 0
help db 0x0D, 0x0A, "V = version, R = reboot, N = new addtions, H = help.", 0x0D, 0x0A
	 db "Also, a hidden command will enable [REDACTED] mode, have some luck trying."
times 4096 - ($ - $$) db 0