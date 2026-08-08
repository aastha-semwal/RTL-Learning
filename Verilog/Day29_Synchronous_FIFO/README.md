# Day 29 - Parameterized Synchronous FIFO

## Beginner explanation

A FIFO (First-In, First-Out) is a small data buffer. The first value written into it is the first value read out. This FIFO is **synchronous**, which means every input and output uses the same `clk` signal.

## Architecture

```text
wr_en, wr_data --> +-------------------------------+ --> rd_data
                  | memory | write pointer | count |
rd_en ----------> |        | read pointer          |
                  +-------------------------------+
                              |              |
                            full           empty
```

## Parameters

| Parameter | Default | Meaning |
|---|---:|---|
| `DATA_WIDTH` | 8 | Bits stored in each entry |
| `FIFO_DEPTH` | 8 | Number of entries |

`FIFO_DEPTH` must be a power of two and at least 2, such as 2, 4, 8, or 16. The `$clog2(FIFO_DEPTH)` pointer width and natural pointer wraparound rely on this assumption. The RTL includes an elaboration-time guard that rejects an unsupported depth.

## Interface

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | FIFO clock |
| `reset` | Input | Synchronous active-high reset |
| `wr_en`, `wr_data` | Input | Write request and write data |
| `rd_en`, `rd_data` | Input/Output | Read request and registered read data |
| `full` | Output | FIFO contains `FIFO_DEPTH` items |
| `empty` | Output | FIFO contains no valid items |
| `overflow` | Output | One-clock pulse: write requested while full |
| `underflow` | Output | One-clock pulse: read requested while empty |

## Read/write behavior

| Write | Read | Result |
|---:|---:|---|
| 1 | 0 | Valid write increases count |
| 0 | 1 | Valid read decreases count |
| 1 | 1 | Both pointers move; count stays unchanged |
| 1 | 0, while full | Write is blocked and `overflow` pulses |
| 0 | 1, while empty | Read is blocked and `underflow` pulses |

## Reset, pointers, and count

Reset is synchronous: it takes effect only at a rising `clk` edge when `reset=1`. It clears pointers, count, output data, and error pulses. The memory itself is not reset because `count=0` marks every entry invalid.

The write pointer selects the next memory location to write. The read pointer selects the oldest data to read. The occupancy count decides `full` and `empty`, and allows the FIFO to distinguish an empty buffer from a full buffer even when pointers match.

## Verification

The testbench uses an independent reference FIFO model and checks reset, normal ordering, full, empty, overflow, underflow, simultaneous valid read/write, and pointer wraparound. It creates `fifo.vcd` for GTKWave.

## Compile and simulate with Icarus Verilog

```bash
iverilog -g2012 -Wall -o sync_fifo_sim sync_fifo.v sync_fifo_tb.v
vvp sync_fifo_sim
gtkwave fifo.vcd
```

## Expected output

```text
PASS: reset and empty FIFO behavior
PASS: normal FIFO ordering
PASS: full flag and overflow protection
PASS: empty flag and underflow protection
PASS: simultaneous read/write keeps occupancy correct
PASS: pointer wraparound preserves FIFO ordering
ALL SYNCHRONOUS FIFO TESTS PASSED
```

## Concepts learned

- Parameterized RTL and `$clog2`
- Synchronous FIFO memory and circular pointers
- Occupancy count, full, and empty flags
- Overflow and underflow protection
- Simultaneous read/write behavior
- Self-checking testbenches and VCD waveforms
