bits 16
org 0x7E00

BUF_SIZE equ 64

start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    mov si, welcome_msg
    call print
    jmp main_loop

main_loop:
    mov word [buf_pos], 0
    mov si, prompt
    call print

read_loop:
    mov ah, 0x00
    int 0x16

    cmp al, 0x0D
    je enter_pressed

    cmp al, 0x08
    je backspace

    cmp al, 0x20
    jb read_loop

    mov bx, [buf_pos]
    cmp bx, BUF_SIZE - 1
    jae buffer_full

    mov [buffer + bx], al
    inc word [buf_pos]

    mov ah, 0x0E
    int 0x10
    jmp read_loop

backspace:
    mov bx, [buf_pos]
    cmp bx, 0
    je read_loop

    dec word [buf_pos]
    mov bx, [buf_pos]
    mov byte [buffer + bx], 0

    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp read_loop

buffer_full:
    jmp 0x0000:0x8E00

enter_pressed:
    mov bx, [buf_pos]
    mov byte [buffer + bx], 0

    call newline

    cmp word [buf_pos], 0
    je main_loop

    mov si, buffer
    call parse_command
    jmp main_loop

parse_command:
    mov di, cmd_version
    call strcmp_ci
    jc do_version

    mov di, cmd_help
    call strcmp_ci
    jc do_help

    mov di, cmd_reboot
    call strcmp_ci
    jc do_reboot

    mov di, cmd_new
    call strcmp_ci
    jc do_new
	
	mov di, cmd_shutdown
    call strcmp_ci
    jc do_shutdown



    mov si, unknown_msg
    call print
    call newline
    ret

do_version:
    mov si, version_msg
    call print
    call newline
    ret

do_help:
    mov si, help_msg
    call print
    call newline
    ret

do_shutdown:
	cli
	hlt
	jmp $

do_reboot:
    jmp 0xFFFF:0x0000

do_new:
    mov si, new_msg
    call print
    call newline
    ret

;now you users don't need to care about capital or lowercase!
strcmp_ci:
    push si
    push di
.loop:
    mov al, [si]
    mov bl, [di]

    cmp al, ' '
    je .check_cmd_end
    cmp al, 0
    je .check_cmd_end

    cmp bl, 0
    je .not_equal

    cmp al, 'A'
    jb .no_lower1
    cmp al, 'Z'
    ja .no_lower1
    add al, 0x20
.no_lower1:
    cmp bl, 'A'
    jb .no_lower2
    cmp bl, 'Z'
    ja .no_lower2
    add bl, 0x20
.no_lower2:

    cmp al, bl
    jne .not_equal

    inc si
    inc di
    jmp .loop

.check_cmd_end:
    cmp bl, 0
    jne .not_equal
    jmp .equal

.not_equal:
    pop di
    pop si
    clc
    ret

.equal:
    pop di
    pop si
    stc
    ret

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

buffer   times BUF_SIZE db 0
buf_pos  dw 0

welcome_msg db "KunKunOS v0.0.8", 0x0D, 0x0A
            db "Type 'help' for help", 0x0D, 0x0A, 0
prompt      db 0x0D, 0x0A, ">>> ", 0
unknown_msg db 0x0D, 0x0A, "Unknown command", 0x0D, 0x0A
            db "Type 'help' for help", 0
version_msg db 0x0D, 0x0A, "KunKunOS v0.0.8 - 2026/10/6", 0x0D, 0x0A
            db "Licensed under GNU GPL v3.0", 0
new_msg     db 0x0D, 0x0A, "We have Non ACPI-shutdowns!", 0
help_msg    db 0x0D, 0x0A
            db "version - Show version", 0x0D, 0x0A
            db "help    - Show this help", 0x0D, 0x0A
            db "reboot  - Reboot the PC", 0x0D, 0x0A
			db "shutdown - Non ACPI-shutdown", 0x0D, 0x0A
            db "new     - Show new additions", 0x0D, 0x0A, 0

cmd_version db "version", 0
cmd_help    db "help", 0
cmd_reboot  db "reboot", 0
cmd_new     db "new", 0
cmd_shutdown db "shutdown", 0

times 4096 - ($ - $$) db 0