# Day 02 - Introduction to Verilog

## What is HDL?

HDL (Hardware Description Language) is a language used to describe the structure and behavior of digital circuits.

## What is Verilog?

Verilog is a Hardware Description Language (HDL) used to design and verify digital circuits.

## Difference between HDL and Verilog

- HDL is a category of hardware description languages.
- Verilog is one type of HDL.

## Difference between Verilog and C Language

| Verilog | C Language |
|----------|------------|
| Hardware Description Language | Programming Language |
| Used to design digital circuits | Used to develop software |
| Executes concurrently | Executes sequentially |

## What is VHDL?

VHDL stands for Very High Speed Integrated Circuit Hardware Description Language.

## Difference between VHDL and Verilog

| Verilog | VHDL |
|----------|------|
| Easy syntax | More complex syntax |
| Similar to C language | Similar to Ada language |
| Widely used in industry | Used in aerospace and defense |

## Levels of Abstraction

1. Switch Level
2. Gate Level
3. Dataflow Level
4. Behavioral Level

## Switch Level

- Uses PMOS and NMOS transistors.
- Lowest level of abstraction.

Syntax:

pmos instance_name(output, source, gate);
nmos instance_name(output, source, gate);

## Gate Level

Uses logic gates like AND, OR, NOT, NAND, NOR, XOR and XNOR.

Syntax:

gate_name instance_name(output, input1, input2);

Example:

and g1(y, a, b);

## My Understanding

Today I learned the basics of Verilog, HDL, VHDL, Levels of Abstraction, Switch Level and Gate Level Modeling.

