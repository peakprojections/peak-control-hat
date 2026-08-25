# Peak Control HAT Rev A — electrical design

## Design goals

Rev A is a four-channel Raspberry Pi HAT-style 24 V field-output controller for Peak rigs. The hardware channels are intentionally generic (`OUT1`–`OUT4`) so software and external contactor selection determine whether a channel behaves as projector, viewer, or auxiliary power control.

Default deployment mapping:

| Channel | Pi GPIO | Default use |
|---|---:|---|
| OUT1 | GPIO16 | Projector 1 / NO contactor |
| OUT2 | GPIO19 | Viewer 1 / NC contactor |
| OUT3 | GPIO22 | Projector 2 or Aux scheduled channel |
| OUT4 | GPIO23 | Viewer 2 or Aux normally-on/reboot channel |

The output electrical behavior is universal: GPIO LOW = 24 V output OFF; GPIO HIGH = 24 V output ON. NO/NC behavior belongs to the external contactor, not to inverted GPIO logic.

## Output driver

Use 2 × Texas Instruments TPS272C45C in RHF 24-pin VQFN, two channels per device. Version C is preferred because VDD may be tied to GND to use the internal low-voltage regulator while the 3.3 V Raspberry Pi GPIO still directly drives the logic inputs.

RHF24 pin mapping for A/C versions:

- OUT1: pins 1, 2, 3
- NC: pin 4
- OUT2: pins 5, 6, 7
- VS: pins 8, 9, 23, 24
- FLT: pin 10
- SNS: pin 11
- DIA_EN: pin 12
- SEL: pin 13
- LATCH: pin 14
- EN2: pin 15
- EN1: pin 16
- GND: pin 17 plus exposed PowerPad
- ILIMD: pin 18
- VDD: pin 19
- ILIM2: pin 20
- ILIM1: pin 21
- NC: pin 22

### Current limit

TI specifies approximately `RILIM(kΩ) = 20.5 / ICL(A)`. Rev A starts with 13.7 kΩ, 1% from ILIM1 and ILIM2 to GND, producing approximately 1.50 A nominal current limit per channel. This is intentionally far above the ~0.1 A Finder contactor-coil load while retaining useful AUX capacity and short-circuit protection.

ILIMD is tied to GND for a constant programmed current limit with no temporary 2× inrush phase. Contactor coils do not require the higher inrush allowance.

LATCH is tied to GND for automatic retry after protected thermal/overcurrent shutdown. This keeps a temporary field short from requiring a Pi reboot to recover.

### Diagnostics

Each TPS272C45C provides one multiplexed SNS output and one active-low open-drain FLT output.

- `SEL=0`: SNS represents channel 1
- `SEL=1`: SNS represents channel 2
- DIA_EN enables diagnostic behavior
- FLT gets a 3.3 V pull-up and returns to a Pi digital input
- SNS uses a 499 Ω, 1% sense resistor to GND before the ADC input

At approximately 1 A load current the datasheet nominal SNS current is ~0.83 mA, so 499 Ω produces ~0.41 V. The 499 Ω value also keeps the published maximum fault-current sense level below the 3.3 V logic rail, subject to final clamp/filter verification.

Two TPS devices therefore require only two ADC channels for all four output currents because each device multiplexes its two channels through SEL.

## 24 V input

Rev A field input block is:

`24V terminal -> fuse -> reverse-polarity stage -> TVS surge clamp -> bulk/ceramic decoupling -> +24V_FIELD`

Initial protection values/topology to validate before fabrication:

- F1: 3 A replaceable/resettable protection target
- bulk: 47 µF / 50 V minimum
- local ceramic: 1 µF / 50 V plus device-local 100 nF where appropriate
- TVS: select from the final IEC/surge target after checking clamp voltage against TPS272C45C transient limits
- reverse polarity: prefer low-loss MOSFET/ideal-diode topology over a series diode if component count/cost is reasonable

The board does **not** power the Raspberry Pi from 24 V in Rev A. Pi power remains on a separate certified 24-to-5 V converter or normal Pi supply.

## Proof inputs

Two field inputs use 24 V-side optocoupler input networks with the external terminal pair labeled `IN / GND`. A dry contact or open-collector field device closes IN toward FIELD_GND. The isolated logic side returns to a Pi GPIO with a 3.3 V pull-up.

These are intended for projector current-switch proof-of-run and future status/interlock sensing.

## I2C / ADC

Pi GPIO2/GPIO3 remain SDA/SCL. The bus serves:

- onboard ADC for TPS current sense and future analog monitoring
- I2C-A expansion connector
- I2C-B expansion connector
- optional future internal expansion / 8-output design

Keep GPIO0/GPIO1 (ID_SD/ID_SC) unused by application circuitry so HAT identification EEPROM support remains possible.

## IR and fan

IR TX remains centered around GPIO18 where practical because hardware PWM/timing support is useful. IR output terminals are buffered rather than exposing Pi GPIO directly.

Fan control uses a separate MOSFET driver and does not consume a smart 24 V output channel.

## Routing intent

Conservative trace widths are deliberate:

| Net class | Rev A target |
|---|---:|
| GPIO / I2C | >= 0.30 mm |
| ADC / sense | 0.25–0.30 mm, short and quiet |
| 3.3 V | >= 0.50 mm |
| 5 V fan | >= 0.75–1.0 mm |
| 24 V individual branches | >= 1.5 mm |
| 24 V main trunk | >= 2.0 mm and/or copper pour |

Preferred four-layer use:

- L1: components + signal/power routing
- L2: continuous GND reference plane
- L3: 24 V / low-voltage power regions (not a blanket 24 V plane beneath the Pi)
- L4: secondary signal routing

Place the 24 V protection and both TPS272C45C devices on the control/I/O wing, with short direct copper paths from the drivers to OUT1–OUT4 terminals. Keep analog SNS routing away from output copper and fan/IR switching edges.

## Future eight-output board

Rev A uses direct Pi GPIO for simplicity. The software/hardware naming should remain generic enough that an 8-output Rev B can use an I2C/SPI GPIO expander feeding four TPS272C45C devices without changing the public output semantics.
