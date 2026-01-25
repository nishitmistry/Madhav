# Bootloader

## how computer starts up

    -- BIOS is copied from ROM into RAM
    -- BIOS starts running, initialize hardware, run POST (power-on self test)
    -- Search for operating system and loads it at 0x7c00 memory location

We will be using legacy booting where the bios scan all the bootable devices and check if 1st sector (which is 512 bytes long) ends with 0xaa55 signature.

## Clear Interrupt Flag (cli)

A command which is used to set the interupt flag of cpu to 0, As soon as you switch to Protected Mode (32-bit) or Long Mode (64-bit), the BIOS IVT becomes invalid. If a hardware interrupt (like a timer tick) fires after you switch modes but before you have set up your own IDT (Interrupt Descriptor Table), the CPU won't know where to jump and this would basically crash the bootloader. So basically this should be used when are working on some thing very important and which should not be stop on any type of interupt.

## Set Interrupt Flag (sti)

this command is opposite of clear interrupt flag (cli) opcode, such that it sets the interupt flag of cpu to 1. Thus any interrupt would result in handle being tranfered to interupt handler.
