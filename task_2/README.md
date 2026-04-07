# Task 2 — Buffer

> *Synthesizable Verilog implementation of a buffer with read, write and clean operations*

## Overview

This task implements a synchronous buffer with parameterized address width, data width and identifier  width.

Each buffer line stores a valid bit, an `id` and data itself.

The module supports three operations: `write`, `read` and `clean`. Only one of these control signals is assumed to be active at a time.

## How It Works

### Write

When `write` is asserted:
- `data_in` is written into the selected buffer line;
- `id` is stored as the identifier of that line;
- the valid bit for the selected address is set.

### Clean

When `clean` is asserted:
- the valid bit of the selected line is cleared.

### Read

When `read` is asserted, the module checks:
- whether the selected line is valid;
- whether the stored identifier  matches the input `id`.

If both conditions are true, `data_out` is updated with the stored data, while `val` is asserted on the next cycle for exactly one clock tick.
If either condition fails `val` remains deasserted.

## What's interesting about this module?

Although there's nothing too complex about this module, it's worth mentioning that this buffer is conceptually very close to a **direct-mapped cache line store**.
Notice how:

- the input address directly selects one buffer line
- each line contains `valid + id + data`
- a read performs a id comparison
- success corresponds to a cache **hit**
- mismatch or invalid line corresponds to a cache **miss**

So while this module is not a full cache, it behaves like a simplified tagged memory structure similar to a **direct-mapped cache** without replacement logic.

## Project Structure

The directory contains:

- `buffer.v` — module implementation
- `buffer_tb.v` — testbench
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
On reset, only valid bits are cleared. Stored identifiers and data were decided to be left unchanged, since they are considered meaningless while the corresponding valid bit is zero and cleaning them would have been unnecessary.