# SimpleRISC — Pipelined SystemVerilog CPU

A from-scratch SystemVerilog implementation of the SimpleRISC processor.

The project implements the SimpleRISC ISA as a pipelined CPU, including the datapath, control unit, register file, ALU, memory system, branching, CALL/RET, delayed branching, and immediate modes.

The CPU is simulated using Icarus Verilog.

---

## Features

- Pipelined CPU datapath
- SimpleRISC instruction set
- 16 × 32-bit general-purpose registers
- 32-bit datapath
- Arithmetic operations
  - ADD
  - SUB
  - MUL
  - DIV
  - MOD
  - CMP
- Logical operations
  - AND
  - OR
  - NOT
- Shift operations
  - LSL
  - LSR
  - ASR
- MOV
- NOP
- Load / Store
- Conditional branches
  - BEQ
  - BGT
- Unconditional branch
  - B
- CALL / RET
- Persistent comparison flags
- Immediate operands
- U and H immediate modes
- Delayed branching
- Separate instruction and data memory
- Two-port memory access for instruction fetch and data access

---

## Architecture

The processor is organized as a 5 stage pipeline:

```text
IF → OF → EX → MA → RW
````

where:

- **IF** — Instruction Fetch
- **OF** — Operand Fetch / Decode
- **EX** — Execute
- **MA** — Memory Access
- **RW** — Register Writeback

Pipeline registers separate the stages:

```text
IF → IFOF → OF → OFEX → EX → EXMA → MA → MARW → RW
```

---

## Datapath

The execution stage contains separate functional units for the major operation classes:

```text
                  ┌── Adder
                  ├── Multiplier
Operands ─────────┼── Divider
                  ├── Shift Unit
                  ├── Logical Unit
                  └── Move Unit
                         │
                         ▼
                       ALU
```

The ALU selects the result corresponding to the decoded instruction.

---

## Register File

The processor contains:

```text
16 registers × 32 bits
```

with two read ports and one write port.

Register `R15` is used as the return-address register for `CALL` / `RET`.

---

## Comparison Flags

`CMP` produces the comparison flags:

```text
equal
greater
```

These are stored in persistent flag registers.

The flags are updated when the `CMP` instruction reaches the execute stage and are subsequently consumed by branch instructions such as `BEQ` and `BGT`.

---

## Branching

The processor uses delayed branching.

The instruction following a branch is therefore part of the branch delay slot.

For example:

```text
B target
<delay-slot instruction>
...
target:
```

`CALL` is treated as an unconditional branch while also saving the return address.

Because the processor uses word-addressed instruction memory, the return address for `CALL` is:

```text
PC + 2
```

This accounts for the delayed branch instruction.

---

## Memory

Instruction and data memory are separate.

The processor uses word addressing for the memories.

The instruction memory and data memory can therefore be accessed independently during the same cycle.

The memory arrays use a 10-bit index:

```text
address[9:0]
```

---

## Immediate Modes

The processor supports immediate operands, including the `U` and `H` modes defined by the SimpleRISC specification.

Immediate decoding is handled before the execute stage and the selected immediate is passed through the pipeline to the ALU.

---

## Hazard Handling

The implementation does not contain general-purpose hardware hazard detection or forwarding.

Hazards that are not handled directly by the datapath are therefore expected to be handled by software/instruction scheduling according to the processor's timing.

The memory structural hazard is handled by the separate instruction/data memory access paths.

---

## Verification

The CPU was developed bottom-up.

Individual components were tested first:

```text
mux
mux2
mux3
program counter
control unit
register file
immediate / branch target unit
adder
multiplier
divider
shift unit
logical unit
move unit
ALU
memory access unit
pipeline registers
```

Individual instructions were then tested through the complete CPU.

The instruction-level tests cover:

```text
ADD
SUB
MUL
DIV
MOD
CMP
AND
OR
NOT
MOV
LSL
LSR
ASR
NOP
LD
ST
BEQ
BGT
B
CALL
RET
```

Immediate modes were also tested, including positive and negative values.

After instruction-level verification, multi-instruction programs were used to test interaction between instructions and pipeline stages.

---

## Running the CPU

### Requirements

- SystemVerilog simulator
- Icarus Verilog
- macOS/Linux/Windows environment with a working shell

### Compile

From the project directory:

```bash
iverilog -g2012 -o sim rtl/*.sv tests/[name_of_test_file].sv
```

### Run

```bash
vvp sim
```

The testbench prints the processor state and reports the results of the checks.

---

## Writing a Program

At the current stage, programs can be loaded directly into instruction memory from the testbench.

For example:

```systemverilog
dut.instruction_memory.memory[0] = 32'b...;
dut.instruction_memory.memory[1] = 32'b...;
dut.instruction_memory.memory[2] = 32'b...;
```

The CPU can then be run for a chosen number of clock cycles:

```systemverilog
run_cycles(20);
```

and the architectural state can be inspected through the register file and memory.

Example register check:

```systemverilog
check_register(3, 32'd12);
```

---

## Project Structure

A suggested repository layout is:

```text
.
├── rtl/
│   ├── CPU.sv
│   ├── ALU.sv
│   ├── control_unit.sv
│   ├── register_file.sv
│   ├── program_counter_manager.sv
│   ├── instruction_memory.sv
│   ├── data_memory.sv
│   ├── ...
│
├── tests/
│   ├── CPU_tb.sv
│   ├── ALU_tb.sv
│   ├── register_file_tb.sv
│   ├── ...
│
├── programs/
│   └── ...
│
├── README.md
└── REPORT.md
```

The exact filenames may vary depending on the repository organization.

---

## Design Philosophy

This project is primarily a hands-on implementation of a known educational RISC architecture.

The goal was to understand how an ISA becomes an actual clocked datapath:

```text
ISA
 ↓
instruction encoding
 ↓
control signals
 ↓
datapath
 ↓
pipeline
 ↓
clocked state
 ↓
working CPU
```

Rather than treating the processor as a black box, the implementation was built and debugged component by component.

---

## Current Status

The CPU currently passes the instruction-level test suite and has been exercised with multi-instruction programs.

The implementation is intended as an educational CPU implementation and simulation project rather than a production processor.

---

## Future Work

Possible future improvements include:

- assembler for SimpleRISC
- program loader
- cleaner program-level test framework
- waveform-based debugging
- SystemVerilog assertions
- automated regression tests
- additional example programs
- more formal verification
- hardware hazard detection / forwarding, if desired

---

## License
