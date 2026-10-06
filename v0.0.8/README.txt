Development timeline:
v0.0.1:
The OS was born!
Has just a line of text

v0.0.2:
Added a new line of text (More NASM knowledge)

v0.0.3:
More lines of text
Clears the screen of BIOS POSTS before showing text (Still studying NASM)

v0.0.4:
Has the first shell (Maybe this is the newest and most unusable command prompt in the world)
Uses the "R" key to restart

Known bugs(Called "Learning experience") about v0.0.4:
Strange behavior with the Backspace key and the Enter key.
Unable to enter a full world (LOL, I added a "AUTO-NEWLINE", failed here, please don't be like me and add this) 

Good points about v0.0.4:
Uses 0XFFFF:0X0000 instead if 0x19 (0x19 is useless in real machines~~~)

v0.0.5:
FINALLY BROKE FREE FROM THE 512 BYTES CHAIN!
Now loads a 2KB kernel (Maybe this is the smallest kernel in the world I guess......)
Disabled the shell in v0.0.4 (Too buggy, will make a comeback on v0.0.6)
Still runs in 16bit (You'll have to wait 2147483647 years for 32 bit, lol.)

v0.0.6
The shell is fixed and made a comeback!
3 Commands in total: N is "New additions", V is "Version", R is "Restart"

v0.0.7
Changed the welcome screen.
Added a new command "H" (Which is to show all commands)
An easter egg is in the OS, have some luck to find it~
(Fact: The official abbreviation of KunKunOS is "KKOS" now)

v0.0.8
Removed the easter egg (It's now the kernel panic screen! You can confirm it in the source code.)
Now you can type a full word (WARNING: DO NOT ENTER ANYTHING MORE THAN 63 CHARACTERS! IT WILL CRASH THE OS!)
Added non-ACPI shutdowns (Command: shutdown. Don't ask why I didn't add ACPI shutdowns.)
(You'll have to what 65536 years for 32-bit KunKunOS, it's in planning!)


Some interesting discarded thoughts I was about to add:
The original v0.0.3 (The color update)
More lines of text but with color
Reason(s) I threw it: That's NOT an update at all!

The original v0.0.5 (Shell fix)
Fix the shell and add more commands
Reason(s) I threw it: I knew that staying on the 512 bytes is just a shackle, why not use CHS to get a 2KB kernel




------------------- The KunKunOS developer and the main engineer of KunKunOS and a NASM learner