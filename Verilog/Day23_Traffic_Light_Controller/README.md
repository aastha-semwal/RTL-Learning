# Day 23 - Industry Traffic Light Controller

## Overview
Designed an Industry Style Traffic Light Controller using Verilog HDL.

## Features
- Moore FSM
- Timer Based State Transition
- Pedestrian Request
- Emergency Vehicle Priority

## States
- RED
- GREEN
- YELLOW
- PEDESTRIAN
- EMERGENCY

## Files
- traffic_light_controller.v
- traffic_light_controller_tb.v

## Tools
- Verilog HDL
- Icarus Verilog
- GTKWave

## Compile

```bash
iverilog -Wall -o traffic_light_sim traffic_light_controller.v traffic_light_controller_tb.v
```

## Run

```bash
vvp traffic_light_sim
```

## Learning Outcome

- Moore FSM
- Timer Design
- Priority Logic
- Traffic Signal Controller