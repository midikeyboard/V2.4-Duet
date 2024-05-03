; homez.g
; called to home the Z axis
;
G1 X175 Y175 F8000 ; go to first probe point
G30                 ; home Z by probing the bed
G29 S1