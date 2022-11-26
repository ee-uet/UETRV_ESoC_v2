## UETRV_ESoC_v2
UETRV_ECORE_v2 is a RISC-V based SoC derived from [UETRV_ESoC](https://github.com/ee-uet/UETRV_ESoC) with a few changes; it has been passed through the Cadence VLSI flow for submission to Google and Efabless' Open MPW-8 shuttle program using Skywater's open-source 130 nm PDK. The verilog RTL used in this repo is generated from Scala source, available [here](https://github.com/ee-uet/UETRV_ESoC). Further details about the peripheral memory map, bootloader, example programs, testbenches etc. are also provided in that repo.

## Updates from UETRV_ESoC
The following are the differences between UETRV_ESoC_v2 and UETRV_ESoC:

* Fixed width of address bus in the instruction bus. Previously, the address bus was 2 bits narrower than required for the instruction memory size specified in the config.scala file.
* Fixed selection of the motor control module to be accessed using the address given to data bus. Previously, although three motor control modules were instantiated, only the first motor module was accessible.
* Fixed data memory to be word-addressable. Previously, data memory was byte-addressable which did not map properly to the Skywater PDK's SRAMs.
* Added 2 inputs and 2 outputs to the motor control module, to aid in controlling stepper motors for a plotter's operation. The 2 inputs have been used to read the state of homing switches, and the 2 outputs have been used to provide the direction inputs to the stepper motor driver, but this usage of the IOs been done using firmware, thus they can be easily used for other purposes by modifying the firmware written in C language.
* Increased instruction memory size to 8 KB and data memory size to 4 KB. As shown in the image below, the 4 lower SRAMs constitute the instruction memory and the 2 upper SRAMs constitute the data memory.

<img src="docs/full_chip_layout.png" alt="layout rendered using klayout" width="500"/>
