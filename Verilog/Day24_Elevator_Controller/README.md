# Day 24 - Elevator Controller

## Overview
A finite state machine (FSM) based Elevator Controller implemented in Verilog HDL.

## Features
- 4 Floor Elevator
- Up Movement
- Down Movement
- Door Open / Close
- Moore FSM
- Synthesizable RTL

## Files
- elevator_controller.v
- elevator_controller_tb.v

## Tools
- Verilog HDL
- Icarus Verilog
- GTKWave

## Compile
```bash
iverilog -Wall -o elevator_sim elevator_controller.v elevator_controller_tb.v
```

## Run
```bash
vvp elevator_sim
```

## Learning Outcomes
- FSM Design
- State Transitions
- Sequential Logic
- Testbench Writing