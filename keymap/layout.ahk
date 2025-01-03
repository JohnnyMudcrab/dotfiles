#SingleInstance Force

; ===== Erste Reihe (^ 1 2 3 4 5 6 7 8 9 0 ß ´) =====
SC029::Send "{^} "      ; Taste: ^ (Zirkumflex)
+SC029::Send "~"       ; Taste: ^ +Shift

+SC003::Send "°"       ; Taste: 2 +Shift

SC00C::SendText "\"    ; Taste: ß

SC00D::Send "{#}"      ; Taste: ´
+SC00D::Send "*"       ; Taste: ´ +Shift

; ===== Umlaute mit AltGr =====
<^>!a::Send "ä"        ; Taste: a +AltGr
<^>!+a::Send "Ä"       ; Taste: a +AltGr +Shift
<^>!o::Send "ö"        ; Taste: o +AltGr
<^>!+o::Send "Ö"       ; Taste: o +AltGr +Shift
<^>!u::Send "ü"        ; Taste: u +AltGr
<^>!+u::Send "Ü"       ; Taste: u +AltGr +Shift
<^>!s::Send "ß"        ; Taste: s +AltGr

; ===== Klammern =====
SC027::Send "("        ; Taste: ö
+SC027::Send ")"       ; Taste: ö +Shift
SC028::Send "["        ; Taste: ä
+SC028::Send "]"       ; Taste: ä +Shift
SC02B::Send "{{}"      ; Taste: #
+SC02B::Send "{}}"     ; Taste: # +Shift

; ===== Andere Sonderzeichen =====
SC01A::Send "-"        ; Taste: ü
+SC01A::Send "{+}"     ; Taste: ü +Shift
SC01B::Send "'"        ; Taste: +
+SC01B::Send "`""      ; Taste: + +Shift
<^>!SC01B::Send "~"    ; Taste: + +AltGr

; ===== Interpunktion =====
+SC033::Send ";"       ; Taste: , +Shift
<^>!SC033::Send "´ "   ; Taste: , +AltGr (Akut)
+SC034::Send ":"       ; Taste: . +Shift
<^>!SC034::Send "`` "  ; Taste: . +AltGr (Gravis)
SC035::Send "/"        ; Taste: -
+SC035::Send "_"       ; Taste: - +Shift

; ===== Navigation mit AltGr =====
<^>!h::Send "{Left}"      ; Taste: h +AltGr
<^>!+h::Send "{Home}"     ; Taste: h +AltGr +Shift
<^>!j::Send "{Down}"      ; Taste: j +AltGr
<^>!+j::Send "{PgDn}"     ; Taste: j +AltGr +Shift
<^>!k::Send "{Up}"        ; Taste: k +AltGr
<^>!+k::Send "{PgUp}"     ; Taste: k +AltGr +Shift
<^>!l::Send "{Right}"     ; Taste: l +AltGr
<^>!+l::Send "{End}"      ; Taste: l +AltGr +Shift
<^>!d::Send "^{Left}"     ; Taste: d +AltGr (Wort zurück)
<^>!+d::Send "^+{Left}"   ; Taste: d +AltGr +Shift (Wort zurück + Markierung)
<^>!f::Send "^{Right}"    ; Taste: f +AltGr (Wort vor)
<^>!+f::Send "^+{Right}"  ; Taste: f +AltGr +Shift (Wort vor + Markierung)

; ===== System =====
CapsLock::Send "{Escape}"  ; Taste: CapsLock

; ===== Tools =====

;----------------------------------------------------------------------------
;Volume control, Alt+Scroll wheel (and Mbutton)

#HotIf GetKeyState("Alt", "P")  ; Nur aktiv wenn Alt gedrückt ist
WheelUp::Volume_Up
WheelDown::Volume_Down
MButton::Volume_Mute
#HotIf  ; Ende der Alt-Bedingung

;----------------------------------------------------------------------------
; Search selection with Ctrl+Shift+G

^+g::
{
    A_Clipboard := ""        ; Clear clipboard
    Send "^c"               ; Copy selection
    Sleep 25               ; Wait a bit
    Run "http://www.google.com/search?q=" A_Clipboard
}

;----------------------------------------------------------------------------
;Suspend hotkeys

!s::Suspend
