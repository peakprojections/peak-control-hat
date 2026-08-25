# Peak Control HAT Rev A — TPS272C45C schematic wiring plan

This document is the canonical net plan for replacing the temporary U1/U2 `Conn_02x12_Odd_Even` placeholders with the project-local `Peak_Control_HAT:TPS272C45C` symbol.

## Generic output mapping

| Device | Channel | Net | Pi GPIO | Default use |
|---|---|---|---:|---|
| U1 | CH1 | OUT1 | GPIO16 | Projector 1 / NO contactor |
| U1 | CH2 | OUT2 | GPIO19 | Viewer 1 / NC contactor |
| U2 | CH1 | OUT3 | GPIO22 | Projector 2 / scheduled AUX |
| U2 | CH2 | OUT4 | GPIO23 | Viewer 2 / normally-on AUX |

Electrical behavior is universal: GPIO LOW = field output OFF; GPIO HIGH = field output ON. NO/NC behavior is provided by the external Finder contactor.

## TPS272C45C RHF-24 pin assignment

| Pin | Name | Rev A connection |
|---:|---|---|
| 1,2,3 | OUT1 | U1 -> OUT1 terminal; U2 -> OUT3 terminal |
| 4 | NC | No connection |
| 5,6,7 | OUT2 | U1 -> OUT2 terminal; U2 -> OUT4 terminal |
| 8,9,23,24 | VS | +24V_FIELD |
| 10 | FLT | U1_FLT / U2_FLT; 10 kΩ pull-up to +3V3; Pi GPIO20 / GPIO21 respectively |
| 11 | SNS | U1_SNS / U2_SNS; 499 Ω 1% to logic GND, then ADC input through final RC/clamp network |
| 12 | DIA_EN | +3V3 through 10 kΩ pull-up; optional GPIO control footprint may be reserved later |
| 13 | SEL | U1_SEL -> GPIO5; U2_SEL -> GPIO6 |
| 14 | LATCH | GND for automatic retry |
| 15 | EN2 | U1 -> GPIO19; U2 -> GPIO23 |
| 16 | EN1 | U1 -> GPIO16; U2 -> GPIO22 |
| 17 | GND | Logic/field 0 V plane |
| 18 | ILIMD | GND for constant programmed current limit |
| 19 | VDD | GND on TPS272C45C to use internal low-voltage regulator mode |
| 20 | ILIM2 | 13.7 kΩ 1% to GND (~1.5 A nominal limit) |
| 21 | ILIM1 | 13.7 kΩ 1% to GND (~1.5 A nominal limit) |
| 22 | NC | No connection |
| 25 / exposed pad | PowerPad / GND | Solid GND copper with thermal vias in final footprint/layout |

## Device-local bypassing

For each TPS device:

- 100 nF ceramic from VS to GND immediately adjacent to the VS pins.
- 1 µF / 50 V ceramic from VS to GND close to the device.
- Main field rail retains shared bulk capacitance near the 24 V input/protection stage.

## Output terminals

Each output terminal is a two-position field connector:

- Pin 1: switched `OUTx`
- Pin 2: `FIELD_GND`

Typical Finder coil wiring is `OUTx -> A1`, `FIELD_GND -> A2`.

## GPIO/diagnostic nets

- `OUT1_EN` = GPIO16
- `OUT2_EN` = GPIO19
- `OUT3_EN` = GPIO22
- `OUT4_EN` = GPIO23
- `U1_SEL` = GPIO5
- `U2_SEL` = GPIO6
- `U1_FLT` = GPIO20
- `U2_FLT` = GPIO21
- `U1_SNS` = ADC analog input 0
- `U2_SNS` = ADC analog input 1

GPIO0/GPIO1 remain reserved for future HAT EEPROM. GPIO2/GPIO3 remain SDA/SCL for the onboard ADC and external I²C expansion ports.

## Layout intent

- GPIO / I²C traces: 0.30 mm minimum where practical.
- 3.3 V distribution: 0.50 mm minimum.
- 5 V fan power: 0.75–1.0 mm minimum.
- Individual 24 V output branches: 1.5 mm minimum.
- Main 24 V trunk: 2.0 mm minimum and preferably a copper pour in the field-output region.
- Inner layer: solid GND reference plane.
- Keep the 24 V field copper concentrated on the control/I/O wing rather than beneath the Raspberry Pi area.
