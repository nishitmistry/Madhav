# === CONFIG ===
QEMU=qemu-system-x86_64 
BUILD_DIR=$(ROOT_DIR)/bin
ROOT_DIR := $(CURDIR)


export PATH := $(ROOT_DIR)/toolchain/i686-elf/bin:$(PATH)

export TARGET = i686-elf
export TARGET_ASM = nasm
export TARGET_ASMFLAGS = -f elf
export TARGET_CFLAGS = -std=c99 -g  -ffreestanding -nostdlib
export TARGET_CC = $(TARGET)-gcc
export TARGET_CXX = $(TARGET)-g++
export TARGET_LD = $(TARGET)-gcc
export TARGET_LINKFLAGS = -nostdlib
export TARGET_LIBS = -lgcc


BINUTILS_VERSION = 2.37
BINUTILS_URL = https://ftp.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.xz

GCC_VERSION = 11.2.0
GCC_URL = https://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.xz