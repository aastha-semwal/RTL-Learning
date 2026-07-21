# Day 11 - D Flip-Flop with Synchronous Reset

## Objective

Design and simulate a D Flip-Flop with synchronous reset using Verilog HDL.

---

## Concept

A D Flip-Flop stores the value of input **D** only on the rising edge of the clock.

In this design, reset is **synchronous**, which means the flip-flop checks the reset signal only at the rising edge of the clock.

---

## Synchronous Reset

```verilog
always @(posedge clk)
```

If reset is HIGH at the rising edge:

```verilog
Q <= 1'b0;
```

Otherwise:

```verilog
Q <= D;
```

---

## Truth Table

| Clock | Reset | D | Q |
|-------|-------|---|---|
| ↑ | 1 | X | 0 |
| ↑ | 0 | 0 | 0 |
| ↑ | 0 | 1 | 1 |
| No Edge | X | X | Previous Value |

---

## Verification

The design was verified using:

- Verilog Testbench
- Icarus Verilog
- GTKWave

The following cases were tested:

- Initial synchronous reset
- Load D = 1
- Load D = 0
- Apply synchronous reset again
- Verify output changes only on clock edge

---

## Learning Outcomes

- Sequential Logic
- D Flip-Flop
- Synchronous Reset
- Event Control (`@(posedge clk)`)
- Testbench Writing
- Waveform Verification
- RTL Verification

---

## Difference from Day 10

| Day 10 | Day 11 |
|---------|---------|
| Asynchronous Reset | Synchronous Reset |
| `always @(posedge clk or posedge reset)` | `always @(posedge clk)` |
| Reset works immediately | Reset works only on clock edge |

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- GitHub