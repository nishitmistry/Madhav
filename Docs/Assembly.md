# Assembly

In assembly language, the distinction between an instruction and a directive comes down to **who** is processing the command: the CPU or the Assembler.

---

### **1. Instructions (The "Doing")**

An **instruction** is a command that is eventually converted into machine code (binary) and executed by the **CPU**. It tells the hardware exactly what to do during program runtime.

- **Action:** Moves data, performs math, or controls program flow.
- **Result:** Becomes part of the final executable file.
- **Examples:** `MOV`, `ADD`, `PUSH`, `JMP`.

### **2. Directives (The "Organizing")**

A **directive** (also called a "pseudo-op") is a command for the **Assembler** software itself. It is not converted into machine code and is never "seen" by the CPU. Instead, it guides the assembler on how to build the program.

- **Action:** Allocates memory, defines constants, or organizes sections of code.
- **Result:** Used during the assembly process and then discarded.
- **Examples:** `SECTION .data`, `DB` (Define Byte), `EQU`, `END`.

---

### **Key Comparison Table**

| Feature          | Instruction            | Directive                      |
| ---------------- | ---------------------- | ------------------------------ |
| **Processed By** | CPU (at runtime)       | Assembler (at assembly time)   |
| **Machine Code** | Generates binary code  | Generates no machine code      |
| **Purpose**      | Tells CPU what to _do_ | Tells Assembler how to _build_ |
| **Example**      | `ADD EAX, EBX`         | `DB 10` (defines a byte)       |

---

Would you like me to show you a code snippet where both are used together to see how they interact?
