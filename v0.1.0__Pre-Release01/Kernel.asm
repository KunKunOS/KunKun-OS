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
	cmp al, 'H'
	je helps
	cmp al, 'h'
	je helps
	cmp al, 'F'
	je kfs
	cmp al, 'f'
	je kfs
	
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
	
helps:
    mov si, help
    call print
    call newline
    jmp main_loop

reboot:
    jmp 0xFFFF:0x0000
	
kfs:
    mov si, kfs_msg
    call print
    mov ah, 0x02
    mov al, 32 
    mov bx, 0x8E00 
    mov cx, 0x0011
    mov dh, 0x00
    mov dl, 0x00
    int 0x13
	jc err
    mov si, 0x8E20
    call print
    jmp main_loop


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
err:
	mov si, err_msg
    call print
welcome_msg db "KunKunOS v0.1.0 Pre-Release01", 0x0D, 0x0A
            db "Type 'H' for help", 0x0D, 0x0A
			db "WARNING: THIS IS A PRE-RELEASE. THERE ARE BUGS AND ISSUES, USE AT YOUR OWN RISK.", 0
prompt       db  0x0D, 0x0A, ">>> ", 0
unknown_msg  db " is a(n) Unknown command", 0
version_msg  db 0x0D, 0x0A, "KunKunOS v0.1.0 - Pre-Release01 - 2026/8/18", 0x0D, 0x0A
			 db "Made from pure NASM", 0x0D, 0x0A
			 db "This software and the user interface is protected by GNU GPL v3.0", 0
help db 0x0D, 0x0A, "V = version, R = reboot, N = new addtions, H = help, F = Load the disk", 0x0D, 0x0A
	 db 0x0D, 0x0A, "***WARNING: THE DISK READING IS NOT READY. USE IT AT YOUR OWN RISK!***", 0
kfs_msg db 0x0D, 0x0A, "Loading the disk......", 0
err_msg db 0x0D, 0x0A, "Error code: 0x01", 0x0D, 0x0A
		db 0x0D, 0x0A, "The system cannot read the extened disk.", 0x0D, 0x0A
times 4096 - ($ - $$) db 0