# Day 25 - SPI Master & SPI Slave Integration

## Overview

This project integrates the SPI Master and SPI Slave modules developed separately and demonstrates complete SPI communication using Verilog HDL.

The SPI Master transmits serial data to the SPI Slave over the MOSI line while simultaneously receiving serial data from the Slave through the MISO line.

---

## Features

- SPI Mode-0 Communication
- Full Duplex Data Transfer
- Parameterized Data Width
- Configurable Clock Divider
- Busy & Done Status Signals
- Synthesizable RTL
- Complete Testbench
- GTKWave Support

---

## Folder Structure

```
SPI_Integration/
│
├── spi_top.v
├── spi_top_tb.v
├── spi_top.vcd
└── README.md
```

---

## Block Diagram

```
          +----------------+
          |   SPI MASTER   |
          +----------------+
           | MOSI     MISO |
           |               |
           | SCLK     CS_N |
           |               |
          +----------------+
                  ||
                  ||
          +----------------+
          |    SPI SLAVE   |
          +----------------+
```

---

## Files

### spi_top.v

Top-level integration module connecting:

- SPI Master
- SPI Slave

---

### spi_top_tb.v

Complete testbench that verifies:

- Reset
- Start Signal
- Data Transmission
- Data Reception
- Busy Signal
- Done Signal

---

## Simulation

Compile

```bash
iverilog -Wall -o spi_top_sim spi_top.v spi_top_tb.v ../SPI_Master/spi_master.v ../SPI_Slave/spi_slave.v
```

Run

```bash
vvp spi_top_sim
```

Open Waveform

```bash
gtkwave spi_top.vcd
```

---

## Simulation Result

```
Master TX : A5
Master RX : 1E

Slave TX  : 3C
Slave RX  : A5
```

---

## Concepts Learned

- SPI Protocol
- Full Duplex Communication
- FSM Design
- Shift Registers
- Serial Communication
- RTL Design
- Testbench Development
- Waveform Analysis

---

## Applications

- EEPROM
- Flash Memory
- ADC/DAC
- Sensors
- FPGA Interfaces
- Embedded Systems
- Microcontrollers

---

## Author

**Aastha Semwal**

B.Tech Electronics & Communication Engineering

RTL Design Learning Journey

Day 25 – SPI Communication

---

## License

Educational Project