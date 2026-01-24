# Disk I/O (BIOS INT 13h)

This guide covers reading disk sectors using **CHS (Cylinder-Head-Sector)** addressing in 16-bit Real Mode.

---

### 📥 Register Setup (Function 0x02)

To read from a disk, load these registers before calling `int 0x13`:

- **AH**: `0x02` (Read mode)
- **AL**: Number of sectors to read
- **CH**: Cylinder number (Starts at **0**)
- **CL**: Sector number (Starts at **1**)
- **DH**: Head number (Starts at **0**)
- **DL**: Drive number (BIOS provides this in `DL` at boot)
- **ES:BX**: Memory address to load data ()

---

### 🛠 Implementation Example

```assembly
; Read 1 sector from the boot drive into 0x0000:0x8000
mov ah, 0x02    ; BIOS read sector function
mov al, 1       ; Read 1 sector
mov ch, 0x00    ; Cylinder 0
mov dh, 0x00    ; Head 0
mov cl, 0x02    ; Sector 2 (Sector 1 is the bootloader)
; DL is already set by BIOS

push 0x0000
pop es          ; ES = 0x0000
mov bx, 0x8000  ; BX = 0x8000

int 0x13        ; BIOS Disk Interrupt
jc disk_error   ; Carry Flag (CF) set means error

```

---

### ⚠️ Critical Notes

1. **Index Offset**: Cylinders and Heads are **0-indexed**, but Sectors are **1-indexed**.
2. **Error Handling**: Always check the **Carry Flag** (`jc`) after the interrupt. If set, the error code is returned in `AH`.
3. **Segment Limits**: Ensure `ES:BX` does not exceed the 64KB segment boundary during a multi-sector read.

---
