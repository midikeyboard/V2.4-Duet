; bed.g
; called to perform automatic bed compensation via G32
;
;M561 ; clear any bed transform
;G29  ; probe the bed and enable compensation

G28 ; home
G30 P0 X15 Y25 Z-99999 ; probe near a leadscrew
G30 P1 X15 Y320 Z-99999 ; probe near a leadscrew
G30 P2 X335 Y320 Z-99999 ; probe near a leadscrew
G30 P3 X335 Y25 Z-99999 S4 ; probe near a leadscrew and calibrate 3 motors