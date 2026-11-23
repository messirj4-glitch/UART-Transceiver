# UART Transceiver Using Verilog HDL

## Project Overview

A complete UART (Universal Asynchronous Receiver Transmitter) designed using Verilog HDL and implemented using Xilinx Vivado.

The project consists of an FSM-based transmitter and receiver for asynchronous serial communication.

## Features

- 8-bit data transmission and reception
- Configurable baud-rate parameter
- Start and stop bit generation
- LSB-first transmission
- UART transmitter and receiver FSM
- Framing error detection
- Loopback verification using testbench

## Design Specifications

| Parameter | Value |
|---|---|
| Clock Frequency | 100 MHz |
| Baud Rate | 9600 |
| Data Bits | 8 |
| Start Bits | 1 |
| Stop Bits | 1 |
| Parity | None |
| Data Format | 8N1 |

## Project Architecture

The design contains:
1. Baud Rate Generator
2. UART Transmitter
3. UART Receiver
4. Top-Level Module
5. Simulation Testbench

## RTL Source Files

- `uart_top.v`
- `uart_tx.v`
- `uart_rx.v`
- `baud_rate_gen.v`
- `uart_tb.v`

## Tools Used

- Verilog HDL
- Xilinx Vivado Design Suite
- Vivado Simulator

## Verification

A loopback testbench is used to transmit and receive an 8-bit data value.

Test input: `8'hA5`

Expected received data: `8'hA5`

## Project Applications

- FPGA-based communication systems
- Embedded systems
- Serial communication interfaces
- Digital system design

## Future Improvements

- Parity generation and checking
- Configurable stop bits
- Additional baud-rate options
- FPGA hardware testing

## Author

Jose Vivin Ronald A

Electronics and Communication Engineering

SRM Institute of Science and Technology, Tiruchirappalli
