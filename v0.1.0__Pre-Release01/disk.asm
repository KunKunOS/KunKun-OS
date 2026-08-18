;the "disk"
bits 16
org 0x0000;DONT YOU DARE RUN THIS AS CODE
KFS1_SUPER:
    db "KFS-1" 
    dw 0x0001 
    dw 0x0001
    dw 0x0020 
    dw 0x0000
    db 0x00             ; IDK why you need to reserve 1 byte
    times 16 - ($ - KFS1_SUPER) db 0  ;DON'T YOU DARE TOUCH, Or your PC will break
FILE1_ENTRY:
    db "README"         ; 文件名（6 字节）
    db "TXT"            ; 扩展名（3 字节）
    db 0x00             ;1byte, 0 is normal
    dw 0x0001
    dw 0x0001
FILE1_DATA:
    db "========================================", 0x0D, 0x0A
    db "  KFS-1 File System - README", 0x0D, 0x0A
    db "========================================", 0x0D, 0x0A
    db "  Welcome to KunKunOS v0.1.0!", 0x0D, 0x0A
    db "  This is the 01 zone - User Data Area.", 0x0D, 0x0A
    db "  ", 0x0D, 0x0A
    db "  Features:", 0x0D, 0x0A
    db "    - Max size: 16KB", 0x0D, 0x0A
    db "    - Files: README.TXT", 0x0D, 0x0A
    db "    - Free space: IDK", 0x0D, 0x0A
    db "  ", 0x0D, 0x0A
    db "  Made by a 12-year-old in 2026.", 0x0D, 0x0A
    db "========================================", 0x0D, 0x0A, 0
    times 16384 - ($ - $$) db 0