# Task 1 — Second Highest Set Bit

> *Combinational Verilog module for finding the position of the second most significant `1` bit in a parameterized input vector*

## Overview

This task implements a synthesizable Verilog module that returns the position of the **second highest set bit** in the input vector.

The solution is written **without `always` blocks**, using only `assign`, `wire`, `generate`, parameterization by input width, as was required by task.

## How It Works

The module processes the input vector in several stages:

1. Builds a vector showing whether there is at least one `1` at or above each position
2. Extracts the position of the **most significant `1`** in one-hot form
3. Masks that bit out of the original vector
4. Repeats the same procedure to find the next most significant `1`
5. Encodes the resulting one-hot position into a binary index

Thus, the position of second most significant 1 is found.
If the input vector contains fewer than two set bits, the output becomes `0`.

## Synthesis Notes

This structural design synthesizes into a pure combinational path consisting of:
- Cascaded **OR-trees** and bitwise masking for priority detection.
- A **one-hot to binary encoder**.
## Project Structure

The directory contains:

- `get_second_highest_1.v` — module implementation
- `get_second_highest_1_tb.v` — testbench
- `Makefile` — build and simulation commands

## Requirements

- `Icarus Verilog`

## Run
To see all the options available:
```sh
make help
```

To compile and run the testbench:

```sh
make test
```

To clean generated files:

```sh
make clean
```

## Notes
The module assumes the standard bit numbering convention:

bit 0 is the least significant bit, thereas larger indices correspond to more significant positions