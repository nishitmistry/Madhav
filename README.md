# Madhav
A curiocity driven and brag worthy 32 bit x86 protected-mode operating system built from scratch featuring a custom BIOS bootloader, a monolithic kernel with paging, preemptive scheduling, a minimal filesystem, and a command-line shell. The project is fully documented to teach and document my journey of OS Development .
## Tools and Services
- ### Netwide Assembler (Nasm)
        An assembler and disassembler for the Intel x86 architecture. We will be using this to convert our assembly file to object which can be injested by qemu to be ran. 
        [Download Nasm](https://www.nasm.us)
- ### Qemu systems
        Install Qemu to simulate x86_64 system hardware which would be helpful when iteracting with your created Operating system and safely Develop your O.S without any corruption to your host device.
        [Download Qemu](https://www.qemu.org/download)
- ### GNU Debugger (GDB)
        Spin up your qemu debugging session with `make debug` command and then open another terminal to run `gdb` which start a gdb terminal session. Inside gdb run `target remote :1234` (by default qemu debug ran by make debug starts the gdb session at 1234 port), `set architecture i8086`(by default gdb has this enabled), `break *0x7C00` (As the bootloader starts at 0x7C00 memory location)
- ### Make 
        Use Make to make our life easy, shortening huge workflows into few terms.
- ### Xxd
        A command-line utility (part of Vim) that creates hex dumps (hexadecimal representations) of files and can also convert them back to binary.
