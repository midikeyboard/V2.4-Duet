; General preferences
G90                                                       ; send absolute coordinates...
M83                                                       ; ...but relative extruder moves
M550 P"V2.4r1"                                            ; set printer name
M669 K1                                                   ; select CoreXY mode

G4 S1   												  ;wait for expansion boards to start

M552 S1 P192.168.2.70
; M552 P192.168.1.009 S1									  ;Enable network
; M553 P255.255.254.0										  ;Set subnetmask
; M554 P192.168.0.254										  ;Set gateway

; Drives
M569 P0.0 S1                                              ; Z1
M569 P0.1 S0                                              ; Z2
M569 P0.2 S1                                              ; Z3
M569 P0.3 S0                                              ; Z4
M569 P0.4 S1                                              ; X
M569 P0.5 S1                                              ; Y
M569 P121.0 S0                                            ; E1
M584 X0.4 Y0.5 Z0.0:0.1:0.2:0.3 E121.0                    ; set drive mapping
M350 X64 Y64 I1                               	          ; configure microstepping 
M350 Z64 E16 I1                                		      ; configure microstepping 
M92 X320 Y320 Z1600.00 E690.00           			      ; set steps per mm
M566 X900.00 Y900.00 Z60.00 E300.00                       ; set maximum instantaneous speed changes (mm/min)
M203 X18000.00 Y18000.00 Z3000.00 E3000.00   			  ; set maximum speeds (mm/min)
M201 X2000.00 Y2000.00 Z250.00 E10000.00     		 	  ; set accelerations (mm/s^2)
M906 X1500 Y1500 Z1500 E1200 I80              			  ; set motor currents (mA) and motor idle factor in per cent
M84 S120                                                   ; Set idle timeout
M572 D0 S0.02

; Axis Limits
M208 X0 Y0 Z0 S1                                          ; set axis minima
M208 X350 Y350 Z700 S0                                    ; set axis maxima

; Endstops
M574 X2 S1 P"!io1.in"                                      ; configure active-high endstop for low end on X via pin ^io5.in
M574 Y2 S1 P"!io2.in"                                     ; configure active-high endstop for low end on Y via pin ^io6.in
M574 Z1 S2                                                ; configure Z-probe endstop for low end on Z

; Z-Probe
M558 P8 C"121.io1.in" H3 F1000 A5 S0.03           ; set Z probe type to switch and the dive height + speeds
G31 P500 X0 Y25 Z2.694                                   ; set Z probe trigger value, offset and trigger height
M557 X0:350 Y0:350 S50                                    ; define mesh grid
M671 X-65:-65:365:365 Y-20:380:380:-20 S20

; Heaters
M308 S0 P"temp0" Y"thermistor" T100000 B4092              ; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out1" T0 Q10                                    ; create bed heater output on out0 and map it to sensor 0
M307 H0 R0.811 C279.823:279.823 D300 S1.00 V24.0 B0 I0                ; enable bang-bang mode for the bed heater and set PWM limit
M140 H0                                                   ; map heated bed to heater 0
M143 H0 S120                                              ; set temperature limit for heater 0 to 120C
M570 H0 S600
;M308 S1 P"121.temp0" Y"thermistor" T100000 B4725 C7.06e-8 ; configure sensor 1 as thermistor on pin 121.temp0
M308 S1 P"121.temp1" Y"thermistor" T100000 B4725                ; configure sensor 1 as thermistor on pin 121.temp1
M950 H1 C"121.out0" T1                                      ; create nozzle heater output on 121.out0 and map it to sensor 1
M307 H1 R2.317 K0.494:0.000 D3.28 E1.35 S1.00 B0 V22.8                ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S280                                              ; set temperature limit for heater 1 to 280C

; Fans
M950 F0 C"121.out1"                                         ; create fan 0 on pin 121.out2 and set its frequency
M106 P0 C"Cooling Fan" S0 H-1                             ; set fan 0 name and value. Thermostatic control is turned off
M950 F1 C"121.out2"                                         ; create fan 1 on pin 121.out1 and set its frequency
M106 P1 C"Hotend Fan" H1 T45 Q1000                            ; set fan 1 name and value. Thermostatic control is turned on
M950 F2 C"0.out7"  
M106 P2 H3 T35:50 C"ElectronicsFan" 					  ; fan is activated when MCU reports 35°C; runs on full speed from 50°C on
M950 F3 C"0.out8" 
M106 P3 H3 T35:50 C"ElectronicsFan" 					  ; fan is activated when MCU reports 35°C; runs on full speed from 50°C on 

; Tools
M563 P0 S"StealthBurner" D0 H1 F0                           ; define tool 0
G10 P0 X0 Y0 Z0                                           ; set tool 0 axis offsets
G10 P0 R0 S0                                              ; set initial tool 0 active and standby temperatures to 0C

; Bed leveling params
;M671 X0:0:300:300 Y0:300:300:0 S20	        	    	  ; Z positions
M671 X-30:-30:380:380 Y-10:360:360:-10 S10
M557 X10:340 Y25:340 S25                        		  ; Bed mesh grid

; Miscellaneous
M308 S3 Y"mcu-temp" A"Board" 							  ; Board thermal sensor
M912 P0 S-8                 					 		  ; MCU tempurature sensor correction (subtract 8°K)
M575 P1 S1 B57600                                         ; enable support for PanelDue
T0                                                        ; select first tool
M501
M208 Z-5 S1

M308 S6 P"temp1" Y"thermistor" A"nozzle"  T3424 B1833
M955 P121.0 I10
M950 H6 C"out4" T6
G10 p6 s0 r0
M141 H6
M143 H6 S180 
M570 H6 P4 T300
M955 P121.0 I10

; M552 S0