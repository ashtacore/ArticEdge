# ArcticEdge CPU

ArcticEdge is an open-source CPU based on the RISC-V ISA, implemented in SystemVerilog, targeting the Nexys A7-100T FPGA board.

This is a WIP, there isn't really anything you can do with this design yet.

## Project Structure

```
ArcticEdge/
├── src/
│   ├── rtl/              # SystemVerilog RTL files
|   |   |── alu/          # SV for ALU stage (EX)
|   |   |── decode/       # SV for Instruction Decode (ID) / Register Read
|   |   |── fetch/        # SV for Instruction Fetch (IF)
|   |   |── mem/          # SV for Memory Access (MEM)
|   |   |── write_back/   # SV for Register Write Back (WB)
│   ├── tb/               # Testbench files
│   └── constraints/      # Constraint files
├── sim/                  # Simulation files
├── docs/                 # Documentation
├── scripts/              # TCL and other scripts
├── README.md             # Project overview and instructions
└── LICENSE               # License file
```

## Prerequisites

- Xilinx Vivado (2019.2 or later recommended)
- Nexys A7-100T board (for hardware implementation)

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/ashtacore/ArcticEdge.git
cd ArcticEdge
```

2. Open Xilinx Vivado

3. In Vivado, open the TCL console (usually found at the bottom of the Vivado window)

4. Navigate to the project directory in the TCL console:

5. Update the `scripts/build_project.tcl` file for your FPGA. It is currently configured for the Nexys A7-100T.
  - You may also need to update the memory related RTL files to match your system's layout. This includes:
    - `instruction_mem_bram.sv` - My implementation of a seperate instruction memory on a 4,860 Kbit block RAM

6. Run the project creation script:

```bash
source scripts/build_project.tcl
```

This script will create a new Vivado project, add all necessary source files, and set up the project for the Nexys A7-100T board.

## Manual Project Setup

If you prefer to set up the project manually or if you're using a different development environment:

1. Create a new project in your preferred IDE
2. Add the SystemVerilog files from the `src/rtl/` directory to your project
3. If using the Nexys A7-100T, add the constraint file from `src/constraints/`
4. Set the top-level module to `cpu_core` (or your actual top-level module name)

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contact

Project Link: https://github.com/ashtacore/ArcticEdge
