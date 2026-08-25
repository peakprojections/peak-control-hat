# Rev A design decisions — current

- Use an extended HAT-style PCB rather than forcing all field terminals into the official Pi board outline.
- Keep mains voltage entirely off this PCB. The board handles SELV/control circuitry only; Finder contactors perform mains switching.
- Use four protected 24 V high-side outputs based around two TPS272C45 devices unless later electrical review identifies a better part.
- Default all output commands OFF at Pi boot/reset/disconnect via hardware-defined input states.
- Use two identical field inputs designed for 24 V/dry-contact-friendly sensing with isolation/conditioning before Pi GPIO.
- Expose two IR ports, each PWR/GND/SIG, with buffered signal output and selectable 3.3 V or 5 V peripheral power planned.
- Expose two parallel I2C expansion ports for nearby diagnostics/sensors/displays. Avoid long raw I2C runs through the rig.
- Include 40 mm fan mounting over a 34 mm board cutout. Fan electronics remain independent from the 24 V field outputs.
- Reserve the Raspberry Pi HAT ID pins for a future identification EEPROM.


## A2 mechanical datum
- Pi/HAT reference footprint: 65 x 56.5 mm.
- Pi mounting hole centers: (3.5,3.5), (61.5,3.5), (3.5,52.5), (61.5,52.5) mm relative to HAT reference origin.
- Hole drill: 2.75 mm NPTH target.
- GPIO pin 1: (8.37,4.77) mm in this project coordinate system, derived from the official KiCad RaspberryPi-HAT template relationship to the mounting-hole datum.
- Extended board outline remains 115 x 70 mm; this is HAT-style, not a standard-size HAT mechanical outline.
- Fan center is preliminary and must be checked against the exact Pi/heatsink choice before manufacture.


## A2 mechanical correction
- GPIO header now follows the official KiCad Raspberry Pi HAT template datum.
- Pi mounting-hole top-row centerline is y = 3.50 mm.
- Header rows are centered on that same line: y = 2.23 mm and y = 4.77 mm.
- Pin 1 remains x = 8.37 mm, y = 4.77 mm relative to this board datum.
