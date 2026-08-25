EESchema Schematic File Version 4
LIBS:power
LIBS:device
LIBS:Connector_Generic
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
Sheet 1 1
Title "Peak Control HAT Rev A - Power Output Core"
Date "2026-08-25"
Rev "A3-DRAFT"
Comp "Peak Projections"
Comment1 "24V input protection + 4x smart high-side outputs"
Comment2 "TPS272C45C represented as pin headers pending custom symbol"
$EndDescr
Text Notes 700 650 0 100 ~ 20
24V FIELD INPUT / PROTECTION
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 1
P 1200 1200
F 0 "J2" H 1118 1417 50  0000 C CNN
F 1 "24V_IN" H 1118 1326 50 0000 C CNN
	1    1200 1200
	-1 0 0 -1
$EndComp
$Comp
L Device:Fuse F1
U 1 1 2
P 1900 1200
F 0 "F1" V 1703 1200 50 0000 C CNN
F 1 "3A" V 1794 1200 50 0000 C CNN
	1    1900 1200
	0 1 1 0
$EndComp
$Comp
L Device:D_TVS D1
U 1 1 3
P 2600 1550
F 0 "D1" V 2554 1629 50 0000 L CNN
F 1 "TVS_24V_FIELD" V 2645 1629 50 0000 L CNN
	1    2600 1550
	0 1 1 0
$EndComp
$Comp
L Device:C C1
U 1 1 4
P 3100 1550
F 0 "C1" H 3215 1596 50 0000 L CNN
F 1 "47uF/50V" H 3215 1505 50 0000 L CNN
	1    3100 1550
	1 0 0 -1
$EndComp
$Comp
L Device:C C2
U 1 1 5
P 3900 1550
F 0 "C2" H 4015 1596 50 0000 L CNN
F 1 "1uF/50V" H 4015 1505 50 0000 L CNN
	1    3900 1550
	1 0 0 -1
$EndComp
Wire Wire Line
	1400 1200 1750 1200
Wire Wire Line
	2050 1200 4500 1200
Text Label 4200 1200 0 50 ~ 0
+24V_FIELD
Wire Wire Line
	1400 1300 1400 1900
Wire Wire Line
	1400 1900 4500 1900
Text Label 4200 1900 0 50 ~ 0
FIELD_GND
Wire Wire Line
	2600 1400 2600 1200
Wire Wire Line
	2600 1700 2600 1900
Wire Wire Line
	3100 1400 3100 1200
Wire Wire Line
	3100 1700 3100 1900
Wire Wire Line
	3900 1400 3900 1200
Wire Wire Line
	3900 1700 3900 1900
Text Notes 5550 650 0 100 ~ 20
TPS272C45C #1 - OUT1 / OUT2
$Comp
L Connector_Generic:Conn_02x12_Odd_Even U1
U 1 1 10
P 6900 1550
F 0 "U1" H 6950 2267 50 0000 C CNN
F 1 "TPS272C45C_RHF24" H 6950 2176 50 0000 C CNN
	1    6900 1550
	1 0 0 -1
$EndComp
Text Notes 6200 2450 0 50 ~ 0
U1 pin mapping (RHF24): OUT1=1-3; NC=4; OUT2=5-7; VS=8,9,23,24; FLT=10; SNS=11; DIA_EN=12; SEL=13; LATCH=14; EN2=15; EN1=16; GND=17; ILIMD=18; VDD=19; ILIM2=20; ILIM1=21; NC=22; exposed pad=GND
$Comp
L Device:R R11
U 1 1 11
P 5900 3000
F 0 "R11" H 5970 3046 50 0000 L CNN
F 1 "13.7k 1% ILIM1 (~1.5A nominal)" H 5970 2955 50 0000 L CNN
	1    5900 3000
	1 0 0 -1
$EndComp
$Comp
L Device:R R12
U 1 1 12
P 7600 3000
F 0 "R12" H 7670 3046 50 0000 L CNN
F 1 "13.7k 1% ILIM2 (~1.5A nominal)" H 7670 2955 50 0000 L CNN
	1    7600 3000
	1 0 0 -1
$EndComp
$Comp
L Device:R R13
U 1 1 13
P 6750 3300
F 0 "R13" H 6820 3346 50 0000 L CNN
F 1 "499R 1% SNS" H 6820 3255 50 0000 L CNN
	1    6750 3300
	1 0 0 -1
$EndComp
Text Notes 5750 3600 0 50 ~ 0
ILIMD tied to GND: constant programmed current limit (no 2x inrush phase). LATCH tied to GND: auto-retry after protected shutdown. VDD tied to GND on C-version to use internal LDO.
Text Notes 5550 4050 0 100 ~ 20
TPS272C45C #2 - OUT3 / OUT4
$Comp
L Connector_Generic:Conn_02x12_Odd_Even U2
U 1 1 20
P 6900 4950
F 0 "U2" H 6950 5667 50 0000 C CNN
F 1 "TPS272C45C_RHF24" H 6950 5576 50 0000 C CNN
	1    6900 4950
	1 0 0 -1
$EndComp
Text Notes 6200 5850 0 50 ~ 0
Same support network as U1. OUT3/OUT4 generic hardware channels.
Text Notes 700 2600 0 100 ~ 20
GPIO / DIAGNOSTIC ASSIGNMENT
Text Notes 800 2900 0 60 ~ 0
OUT1 EN1 -> GPIO16 (Projector 1 default)
Text Notes 800 3100 0 60 ~ 0
OUT2 EN2 -> GPIO19 (Viewer 1 default)
Text Notes 800 3300 0 60 ~ 0
OUT3 EN1 -> GPIO22 (Projector 2 / Aux default)
Text Notes 800 3500 0 60 ~ 0
OUT4 EN2 -> GPIO23 (Viewer 2 / Aux default)
Text Notes 800 3800 0 60 ~ 0
U1 SEL / U2 SEL -> dedicated GPIOs for SNS mux selection
Text Notes 800 4000 0 60 ~ 0
U1 FLT / U2 FLT -> 3.3V pull-up, dedicated Pi inputs
Text Notes 800 4200 0 60 ~ 0
U1 SNS / U2 SNS -> ADS1115 analog inputs through protection/filter network
Text Notes 700 4750 0 100 ~ 20
ROUTING RULE INTENT
Text Notes 800 5050 0 60 ~ 0
GPIO/I2C: 0.30 mm minimum
Text Notes 800 5250 0 60 ~ 0
3.3V: 0.50 mm minimum
Text Notes 800 5450 0 60 ~ 0
5V fan: 0.75-1.0 mm minimum
Text Notes 800 5650 0 60 ~ 0
24V branches: 1.5 mm minimum; trunk 2.0 mm+ / copper pour
Text Notes 800 5850 0 60 ~ 0
Solid ground plane on inner layer; keep 24V field copper primarily on control/I/O wing
$EndSCHEMATC
