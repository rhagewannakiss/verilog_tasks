# Verilog Test Tasks

Two Verilog modules written as a test assignment for a digital design / logic design track.

## Overview

This repository contains two independent Verilog tasks:

1. **Finding the position of the second highest set bit** in an input vector of parameterized width
2. **Buffer** with read, write and clean operations, parameterized by address, data and identificator widths

Each task is placed in a separate directory and includes:
- Verilog source code
- testbench
- `Makefile`
- local `README.md`

## Tasks

### Task 1 — Second Highest Set Bit

A purely combinational module that returns the position of the **second most significant `1`** in the input vector.

The implementation avoids `always` blocks and uses only continuous assignment style (`assign`, `generate`).

### Task 2 —  Buffer

A synchronous buffer that supports `write`, `read` and `clean`.

Each buffer line stores:
- valid bit
- tag (`id`)
- data (`data_in`)

A read is considered successful only if the selected line is valid and the stored id matches the input id.

The output valid signal is asserted for exactly one cycle after a successful read.

Usage of each module can be found in their individual `README.md` files.