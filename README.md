# Madhav

A curiocity driven 32 bit x86 protected-mode operating system built from scratch featuring a custom BIOS bootloader, a monolithic kernel with paging, preemptive scheduling, a minimal filesystem (maybe fat12), and a command-line shell. The project is fully documented to teach and document my journey of OS Development.

## Commands

- install dependencies in linux `sudo apt install make nasm qemu-system mtools`

## Tools and Services

- ### Windows SubSystem Linux (WSL)

  I don't have a Mac Machine, and am too lazy to install Arch Linux on my windows machine, so i decided to use WSL which i have heard from a random guy on youtube that its better than other solution. For the nerds WSL is program which enables a windows user to run linux environment directly on windows OS.

- ### Netwide Assembler (Nasm)

  An assembler and disassembler for the Intel x86 architecture. We will be using this to convert our assembly file to object which can be injested by qemu to be ran.
  [Download Nasm](https://www.nasm.us)

- ### Qemu systems

  Install Qemu to simulate x86_64 system hardware which would be helpful when iteracting with your created Operating system and safely Develop your O.S without any corruption to your host device.
  [Download Qemu](https://www.qemu.org/download)

- ### GNU Debugger (GDB)

  Spin up your qemu debugging session with `make debug` command and then open another terminal to run `gdb` which start a gdb terminal session. Inside gdb run `target remote :1234` (by default qemu debug ran by make debug starts the gdb session at 1234 port), `set architecture i8086`(by default gdb has this enabled), `break *0x7C00` (As the bootloader starts at 0x7C00 memory location)

- ### Make

  Use Make to make our life easy, shortening huge workflows into few terms. For the nerds, Make is a command-line interface software tool that performs actions ordered by configured dependencies as defined in a configuration file called a makefiles.

- ### Xxd

  A command-line utility (part of Vim) that creates hex dumps (hexadecimal representations) of files and can also convert them back to binary.

- ### bochs

  A x86 debuging emulator to help us debug the bootloader code.

# My Operating System Roadmap

## 🚀 Milestone 1 — Bootable System

Goal: System successfully boots from disk.

- [ ] Create **512-byte bootloader (Stage-1)**
- [ ] Load **Stage-2 bootloader** from disk using disk interupt
- [ ] Jump execution from Stage-1 → Stage-2

---

## 🧩 Milestone 2 — Advanced Bootloader

Goal: Bootloader capable of loading kernel.

- [ ] Display the branding
- [ ] Enable **A20 line**
- [ ] Detect system memory using BIOS
- [ ] Implement **LBA → CHS conversion**
- [ ] Load kernel from disk
- [ ] Support **multi-sector reads**
- [ ] Enter **Protected Mode**
- [ ] Setup **GDT (Global Descriptor Table)**
- [ ] Switch CPU from real mode → protected mode
- [ ] Jump to kernel entry point

---

## ⚙️ Milestone 3 — Minimal Kernel

Goal: Basic kernel execution.

- [ ] Kernel entry point
- [ ] Disable interrupts initially
- [ ] Setup stack
- [ ] Implement `kmain()`
- [ ] Write to VGA memory directly
- [ ] Implement `printk()` or kernel logging
- [ ] Infinite kernel loop

---

## 🖥️ Milestone 4 — Hardware Basics

Goal: Kernel interacts with hardware.

- [ ] Setup **IDT (Interrupt Descriptor Table)**
- [ ] Enable hardware interrupts
- [ ] Implement **IRQ handlers**
- [ ] Timer interrupt (PIT)
- [ ] Keyboard driver
- [ ] Basic interrupt handler framework
- [ ] Interrupt debugging output

---

## 🧠 Milestone 5 — Memory Management

Goal: Kernel manages memory.

- [ ] Detect available RAM
- [ ] Implement **physical memory manager**
- [ ] Bitmap page allocator
- [ ] Implement `kmalloc`
- [ ] Setup **paging**
- [ ] Enable paging
- [ ] Virtual memory mapping
- [ ] Kernel heap

---

## 📂 Milestone 6 — Disk & Filesystem

Goal: Kernel can read files.

- [ ] Disk driver (ATA / BIOS fallback)
- [ ] Sector read/write functions
- [ ] Implement **FAT12 or FAT16 reader**
- [ ] Open files from filesystem
- [ ] Load programs from disk
- [ ] Directory listing
- [ ] File read API

---

## 🧵 Milestone 7 — Multitasking

Goal: Run multiple programs.

- [ ] Task structure
- [ ] Context switching
- [ ] Timer based scheduling
- [ ] Round robin scheduler
- [ ] Kernel threads
- [ ] User mode processes
- [ ] Process switching

---

## 👤 Milestone 8 — User Mode

Goal: Run applications outside kernel.

- [ ] Ring3 user mode support
- [ ] System call interface
- [ ] Interrupt based syscalls
- [ ] Basic libc support
- [ ] Program loader (ELF)

---

## 🖱️ Milestone 9 — Drivers

Goal: Support more hardware.

- [ ] PS/2 keyboard driver
- [ ] PS/2 mouse driver
- [ ] Serial port driver
- [ ] Disk driver improvements
- [ ] Framebuffer graphics support

---

## 🖥️ Milestone 10 — User Environment

Goal: Usable operating system.

- [ ] Kernel shell
- [ ] Command interpreter
- [ ] File utilities
- [ ] Process manager
- [ ] Basic terminal

## Retirement

- [ ] Earn millions by this selling this OS
