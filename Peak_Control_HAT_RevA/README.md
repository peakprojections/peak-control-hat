# Peak Control HAT Rev A — A2 mechanical/placement skeleton

This is the first editable KiCad PCB skeleton for the Peak Projections controller HAT. It is intentionally **not routed and not yet electrically complete**. The purpose of A2 is to establish the mechanical envelope, Raspberry Pi connection, connector zones, fan geometry, and functional placement before committing the detailed schematic and footprints.

## Proposed board
- 115 mm × 70 mm extended HAT-style PCB
- 4-layer target, 1.6 mm FR-4
- Raspberry Pi 2×20 stacking header
- Raspberry Pi M2.5 mounting pattern
- 40 mm fan mount using 32 mm screw spacing, positioned over the Pi area
- 34 mm airflow cutout on Edge.Cuts
- 24 V field/control input
- 4 protected 24 V outputs: Projector, Viewer, Aux1, Aux2
- 2 field/proof inputs
- 2 IR connections: PWR, GND, SIG
- 2 parallel I2C expansion connections: 3V3, GND, SDA, SCL
- 3-wire fan connector: 5V, GND, TACH

## Functional blocks reserved
- U1/U2: TPS272C45 dual-channel smart high-side switches
- U3: I2C ADC / diagnostic front-end
- U4/U5: field-input isolation / conditioning
- Q1/Q2: IR output buffers
- Q3: fan switch/control

## Important
The TPS272C45, ADC, optocoupler/input-conditioning, protection, and connector footprints are placeholders in this A2 board. Exact manufacturer part numbers and schematic support components need to be locked before routing or ordering PCBs.

The 40-pin header pads are intentionally not assigned nets in A2. GPIO/net assignment will be driven from the schematic in the next revision.

## I2C expansion
J11 and J12 are electrically intended to be the same shared I2C bus:
1. 3V3
2. GND
3. SDA
4. SCL

Optional bus pull-up footprints will be included in the schematic but normally left unpopulated unless required by final bus capacitance/device population.


## A2 mechanical correction
The Raspberry Pi interface geometry was corrected against the official Raspberry Pi HAT mechanical specification and the KiCad RaspberryPi-HAT template. The four M2.5 hole centers are 58 mm x 49 mm apart, with centers 3.5 mm from the HAT reference edges. GPIO header pin 1 is fixed relative to the upper-left mounting hole; the board now uses that datum rather than an approximate visual placement. The 65 x 56.5 mm Pi/HAT reference footprint is drawn on Dwgs.User. The Peak PCB intentionally extends to 115 x 70 mm for terminals and control circuitry.

The 40 mm fan remains a concept feature. Its 32 mm mounting-hole pattern and 34 mm airflow cutout are positioned over the central Pi area, but final thermal/mechanical clearance should be verified against the exact Raspberry Pi model and chosen heatsink/Active Cooler before fabrication.
