
;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region variable declarations
;---------------------------------------------------------------------------------------------------------------------

; Dashboard
var $dash = "main_dash"
var $screen = 0

; Half char sizes
var $cw = 3
var $ch = 4

; Screens
var $screen_display = "024"
var $screen_control = "135"
var $screen_viewing = "012"

; Colours
var $o2r = 0
var $o2g = 128
var $o2b = 255
var $ch4r = 178
var $ch4g = 34
var $ch4b = 34

; Flight control parameters
var $cmndr_pit = 0
var $pilot_pit = 0
var $cmndr_yaw = 0
var $pilot_yaw = 0
var $cmndr_rol = 0
var $pilot_rol = 0
var $pit_cmd = 0
var $yaw_cmd = 0
var $rol_cmd = 0

; RCS parameters
var $rcs_state = 1
var $rcs_fuel = "o2"
var $fwd_dors_rcs_1 = 0
var $fwd_dors_rcs_2 = 0
var $fwd_dors_rcs_3 = 0
var $fwd_dors_rcs_4 = 0
var $fwd_vent_rcs_1 = 0
var $fwd_vent_rcs_2 = 0
var $fwd_vent_rcs_3 = 0
var $fwd_vent_rcs_4 = 0
var $fwd_port_rcs_1 = 0
var $fwd_port_rcs_2 = 0
var $fwd_port_rcs_3 = 0
var $fwd_port_rcs_4 = 0
var $fwd_star_rcs_1 = 0
var $fwd_star_rcs_2 = 0
var $fwd_star_rcs_3 = 0
var $fwd_star_rcs_4 = 0
var $mid_dors_rcs_1 = 0
var $mid_dors_rcs_2 = 0
var $mid_dors_rcs_3 = 0
var $mid_dors_rcs_4 = 0
var $mid_vent_rcs_1 = 0
var $mid_vent_rcs_2 = 0
var $mid_vent_rcs_3 = 0
var $mid_vent_rcs_4 = 0
var $mid_port_rcs_1 = 0
var $mid_port_rcs_2 = 0
var $mid_port_rcs_3 = 0
var $mid_port_rcs_4 = 0
var $mid_star_rcs_1 = 0
var $mid_star_rcs_2 = 0
var $mid_star_rcs_3 = 0
var $mid_star_rcs_4 = 0
var $aft_dors_rcs_1 = 0
var $aft_dors_rcs_2 = 0
var $aft_dors_rcs_3 = 0
var $aft_dors_rcs_4 = 0
var $aft_vent_rcs_1 = 0
var $aft_vent_rcs_2 = 0
var $aft_vent_rcs_3 = 0
var $aft_vent_rcs_4 = 0
var $aft_port_rcs_1 = 0
var $aft_port_rcs_2 = 0
var $aft_port_rcs_3 = 0
var $aft_port_rcs_4 = 0
var $aft_star_rcs_1 = 0
var $aft_star_rcs_2 = 0
var $aft_star_rcs_3 = 0
var $aft_star_rcs_4 = 0

; SAS parameters
var $sas_pit = 0
var $sas_yaw = 0
var $sas_rol = 0
var $sas_pit_mode = "pro"
var $sas_yaw_mode = "pro"
var $sas_rol_mode = "down"


;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region parameter functions
;---------------------------------------------------------------------------------------------------------------------

function @reset_rcs_parameters()
	$fwd_dors_rcs_1 = 0
	$fwd_dors_rcs_2 = 0
	$fwd_dors_rcs_3 = 0
	$fwd_dors_rcs_4 = 0
	$fwd_vent_rcs_1 = 0
	$fwd_vent_rcs_2 = 0
	$fwd_vent_rcs_3 = 0
	$fwd_vent_rcs_4 = 0
	$fwd_port_rcs_1 = 0
	$fwd_port_rcs_2 = 0
	$fwd_port_rcs_3 = 0
	$fwd_port_rcs_4 = 0
	$fwd_star_rcs_1 = 0
	$fwd_star_rcs_2 = 0
	$fwd_star_rcs_3 = 0
	$fwd_star_rcs_4 = 0
	$mid_dors_rcs_1 = 0
	$mid_dors_rcs_2 = 0
	$mid_dors_rcs_3 = 0
	$mid_dors_rcs_4 = 0
	$mid_vent_rcs_1 = 0
	$mid_vent_rcs_2 = 0
	$mid_vent_rcs_3 = 0
	$mid_vent_rcs_4 = 0
	$mid_port_rcs_1 = 0
	$mid_port_rcs_2 = 0
	$mid_port_rcs_3 = 0
	$mid_port_rcs_4 = 0
	$mid_star_rcs_1 = 0
	$mid_star_rcs_2 = 0
	$mid_star_rcs_3 = 0
	$mid_star_rcs_4 = 0
	$aft_dors_rcs_1 = 0
	$aft_dors_rcs_2 = 0
	$aft_dors_rcs_3 = 0
	$aft_dors_rcs_4 = 0
	$aft_vent_rcs_1 = 0
	$aft_vent_rcs_2 = 0
	$aft_vent_rcs_3 = 0
	$aft_vent_rcs_4 = 0
	$aft_port_rcs_1 = 0
	$aft_port_rcs_2 = 0
	$aft_port_rcs_3 = 0
	$aft_port_rcs_4 = 0
	$aft_star_rcs_1 = 0
	$aft_star_rcs_2 = 0
	$aft_star_rcs_3 = 0
	$aft_star_rcs_4 = 0
	output_number("o2_rcs", 0, 0)
	output_number("ch4_rcs", 0, 0)
	if $rcs_fuel == "o2"
		output_number("o2_rcs", 0, 1)
	else
		output_number("ch4_rcs", 0, 1)

function @set_rcs_parameters()
	output_number("fwd_dors_rcs", 1, $fwd_dors_rcs_1)
	output_number("fwd_dors_rcs", 2, $fwd_dors_rcs_2)
	output_number("fwd_dors_rcs", 3, $fwd_dors_rcs_3)
	output_number("fwd_dors_rcs", 4, $fwd_dors_rcs_4)
	output_number("fwd_vent_rcs", 1, $fwd_vent_rcs_1)
	output_number("fwd_vent_rcs", 2, $fwd_vent_rcs_2)
	output_number("fwd_vent_rcs", 3, $fwd_vent_rcs_3)
	output_number("fwd_vent_rcs", 4, $fwd_vent_rcs_4)
	output_number("fwd_port_rcs", 1, $fwd_port_rcs_1)
	output_number("fwd_port_rcs", 2, $fwd_port_rcs_2)
	output_number("fwd_port_rcs", 3, $fwd_port_rcs_3)
	output_number("fwd_port_rcs", 4, $fwd_port_rcs_4)
	output_number("fwd_star_rcs", 1, $fwd_star_rcs_1)
	output_number("fwd_star_rcs", 2, $fwd_star_rcs_2)
	output_number("fwd_star_rcs", 3, $fwd_star_rcs_3)
	output_number("fwd_star_rcs", 4, $fwd_star_rcs_4)
	output_number("mid_dors_rcs", 1, $mid_dors_rcs_1)
	output_number("mid_dors_rcs", 2, $mid_dors_rcs_2)
	output_number("mid_dors_rcs", 3, $mid_dors_rcs_3)
	output_number("mid_dors_rcs", 4, $mid_dors_rcs_4)
	output_number("mid_vent_rcs", 1, $mid_vent_rcs_1)
	output_number("mid_vent_rcs", 2, $mid_vent_rcs_2)
	output_number("mid_vent_rcs", 3, $mid_vent_rcs_3)
	output_number("mid_vent_rcs", 4, $mid_vent_rcs_4)
	output_number("mid_port_rcs", 1, $mid_port_rcs_1)
	output_number("mid_port_rcs", 2, $mid_port_rcs_2)
	output_number("mid_port_rcs", 3, $mid_port_rcs_3)
	output_number("mid_port_rcs", 4, $mid_port_rcs_4)
	output_number("mid_star_rcs", 1, $mid_star_rcs_1)
	output_number("mid_star_rcs", 2, $mid_star_rcs_2)
	output_number("mid_star_rcs", 3, $mid_star_rcs_3)
	output_number("mid_star_rcs", 4, $mid_star_rcs_4)
	output_number("aft_dors_rcs", 1, $aft_dors_rcs_1)
	output_number("aft_dors_rcs", 2, $aft_dors_rcs_2)
	output_number("aft_dors_rcs", 3, $aft_dors_rcs_3)
	output_number("aft_dors_rcs", 4, $aft_dors_rcs_4)
	output_number("aft_vent_rcs", 1, $aft_vent_rcs_1)
	output_number("aft_vent_rcs", 2, $aft_vent_rcs_2)
	output_number("aft_vent_rcs", 3, $aft_vent_rcs_3)
	output_number("aft_vent_rcs", 4, $aft_vent_rcs_4)
	output_number("aft_port_rcs", 1, $aft_port_rcs_1)
	output_number("aft_port_rcs", 2, $aft_port_rcs_2)
	output_number("aft_port_rcs", 3, $aft_port_rcs_3)
	output_number("aft_port_rcs", 4, $aft_port_rcs_4)
	output_number("aft_star_rcs", 1, $aft_star_rcs_1)
	output_number("aft_star_rcs", 2, $aft_star_rcs_2)
	output_number("aft_star_rcs", 3, $aft_star_rcs_3)
	output_number("aft_star_rcs", 4, $aft_star_rcs_4)
	output_number("bay_rcs_pitch_pump", 0, abs($pit_cmd))
	output_number("bay_rcs_yaw_pump", 0, abs($yaw_cmd))
	output_number("bay_rcs_roll_pump", 0, abs($rol_cmd))

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region draw screen components
;---------------------------------------------------------------------------------------------------------------------

function @draw_button($x:number, $y:number, $width:number, $thick:number, $shape:text, $br:number, $bg:number, $bb:number, $fr:number, $fg:number, $fb:number, $lr:number, $lg:number, $lb:number, $label1:text, $label2:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $b = color($br, $bg, $bb)
	var $f = color($fr, $fg, $fb)
	var $l = color($lr, $lg, $lb)
	var $w = $width / 2
	var $t = $thick / 2
	if $shape == "square"
		; outer filled rect in border
		$s.draw_rect($x - $w - $t, $y - $w - $t, $x + $w + $t, $y + $w + $t, $b, $b)
		; inner filled rect in fill
		$s.draw_rect($x - $w + $t, $y - $w + $t, $x + $w - $t, $y + $w - $t, $f, $f)
	else
		; outer filled circle in border
		$s.draw_circle($x, $y, $w + $t, $b, $b)
		; inner filled circle in fill
		$s.draw_circle($x, $y, $w - $t, $f, $f)
	if $label2 == ""
		$s.write($x - (size($label1) * $cw - 1), $y - $ch + 1, $l, $label1)
	else
		$s.write($x - (size($label1) * $cw - 1), $y - $s.char_h + 1, $l, $label1)
		$s.write($x - (size($label2) * $cw - 1), $y + 1, $l, $label2)

function @draw_level_rect($x:number, $y:number, $width:number, $height:number, $thick:number, $lr:number, $lg:number, $lb:number, $vr:number, $vg:number, $vb:number, $fraction:number)
	var $b = black
	var $s = screen($dash, ($screen_display.$screen):number)
	var $l = color($lr, $lg, $lb)
	var $v = color($vr, $vg, $vb)
	var $w = $width / 2
	var $h = $height / 2
	var $t = $thick / 2
	var $f = $fraction * (($h - $t) * 2) + $t
	; outer filled rect in line
	$s.draw_rect($x - $w - $t, $y - $h - $t, $x + $w + $t, $y + $h + $t, $l, $l)
	; inner filled rect in black
	$s.draw_rect($x - $w + $t, $y - $h + $t, $x + $w - $t, $y + $h - $t, $b, $b)
	; inner filled rect in level
	$s.draw_rect($x - $w + $t, $y + $h - $f, $x + $w - $t, $y + $h - $t, $v, $v)

function @draw_scale($x:number, $y:number, $length:number, $orient:text, $ticks:number, $lr:number, $lg:number, $lb:number, $tr:number, $tg:number, $tb:number, $target:number)
	$ticks = $ticks - 1
	var $s = screen($dash, ($screen_display.$screen):number)
	var $l = $length / 2
	var $c = color($lr, $lg, $lb)
	var $t = color($tr, $tg, $tb)
	var $n = $length / $ticks
	var $v = $l * $target
	if $orient == "hrz"
		$s.draw_line($x - $l, $y, $x + $l, $y, $c)
		$s.draw_line($x, $y, $x, $y + 10, $c)
		$s.draw_line($x - $l, $y - 4, $x - $l, $y + 5, $c)
		$s.draw_line($x + $l, $y - 4, $x + $l, $y + 5, $c)
		for 0, $ticks ($i)
			$s.draw_line($x - $l + ($i * $n), $y, $x - $l + ($i * $n), $y + 5, $c)
		$s.draw_line($x + $v - 2, $y - 5, $x + $v, $y, $t)
		$s.draw_line($x + $v + 2, $y - 5, $x + $v, $y, $t)
	else
		$s.draw_line($x, $y - $l, $x, $y + $l, $c)
		$s.draw_line($x, $y, $x - 10, $y, $c)
		$s.draw_line($x + 4, $y - $l, $x - 5, $y - $l, $c)
		$s.draw_line($x + 4, $y + $l, $x - 5, $y + $l, $c)
		for 0, $ticks ($i)
			$s.draw_line($x, $y - $l + ($i * $n), $x - 5, $y - $l + ($i * $n), $c)
		$s.draw_line($x + 5, $y - $v - 2, $x, $y - $v, $t)
		$s.draw_line($x + 5, $y - $v + 2, $x, $y - $v, $t)

function @draw_battery($x:number, $y:number, $scale:number, $name:text, $label1:text, $label2:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $c = input_number($name, 2)
	var $charge = text("{00.00}%", $c * 100)
	var $thrput = text("{00.0}W", input_number($name, 3))
	@draw_level_rect($x, $y, $scale * 40, $scale * 40, $scale, 255, 255, 255, 0, 0, 255, $c)
	$s.text_size($scale)
	$s.write($x - (size($label1) * $cw), $y - ($scale * 20.5) - ($s.char_h * 2), white, $label1)
	$s.write($x - (size($label2) * $cw), $y - ($scale * 20.5) - $s.char_h, white, $label2)
	$s.write($x - (size($charge) * $cw), $y - $ch, white, $charge)
	$s.write($x - (size($thrput) * $cw), $y + ($scale * 21.5), white, $thrput)

function @draw_tank($x:number, $y:number, $density:text, $volume:text, $type:text, $label1:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $d = input_number($density, 0)
	var $c = input_text($density, 1)
	var $l = input_number($volume, 0)
	var $v = input_number($volume, 1)
	var $kg = text("{00}kg", $d * $v)
	var $comp = text($type & " {00.00}%", ($c.$type):number * 100)
	if $type == "O2"
		@draw_level_rect($x, $y, 80, 100, 2, 255, 255, 255, $o2r, $o2g, $o2b, $l)
	elseif $type == "CH4"
		@draw_level_rect($x, $y, 80, 100, 2, 255, 255, 255, $ch4r, $ch4g, $ch4b, $l)
	$s.write($x - (size($label1) * $cw), $y - 51 - $s.char_h, white, $label1)
	$s.write($x - (size($kg) * $cw), $y - ($s.char_h / 2), white, $kg)
	$s.write($x - (size($comp) * $cw), $y + 49 - $s.char_h, white, $comp)

function @draw_solar_panel($x:number, $y:number, $name:text, $label1:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $gp = text("{00.0}W", input_number($name, 0))
	$s.draw_rect($x - 7, $y - 20, $x + 7, $y + 20, gray)
	$s.draw_rect($x - 20, $y - 7, $x + 20, $y + 7, gray)
	$s.draw_rect($x - 20, $y - 20, $x + 20, $y + 20, white)
	$s.write($x - (size($gp) * $cw), $y + 21, white, $gp)
	$s.write($x - (size($label1) * $cw), $y - $s.char_h / 2, white, $label1)

function @draw_sun_tracker($x:number, $y:number, $length:number, $orient:text, $ticks:number, $sensor:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $vis = input_number($sensor, 1)
	var $pos = -1
	if $vis > 0
		$pos = input_number($sensor, 0)
	var $p = text("{0.00}", $pos)
	@draw_scale($x, $y, $length, $orient, $ticks, 255, 255, 255, 255, 255, 0, $pos)
	if $orient == "hrz"
		$s.write($x - (size($p) * $cw), $y + 11, white, $p)
	else
		$s.write($x - (size($p) * $s.char_w) - 10, $y - $s.char_h / 2, white, $p)

function @draw_rcs($x:number, $y:number, $orient:text, $one:number, $two:number, $three:number, $four:number)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $m = 10
	var $u = 0
	var $d = 0
	var $l = 0
	var $r = 0
	var $c = color(255, 255, 255)
	if $rcs_fuel == "o2"
		$c = color($o2r, $o2g, $o2b)
	elseif $rcs_fuel == "ch4"
		$c = color($ch4r, $ch4g, $ch4b)
	if $orient == "dors"
		$u = $one * $m
		$d = $two * $m
		$l = $four * $m
		$r = $three * $m
	elseif $orient == "vent"
		$u = $two * $m
		$d = $one * $m
		$l = $three * $m
		$r = $four * $m
	elseif $orient == "port"
		$u = $four * $m
		$d = $three * $m
		$l = $two * $m
		$r = $one * $m
	else
		$u = $three * $m
		$d = $four * $m
		$l = $one * $m
		$r = $two * $m
	$s.draw_line($x - 3, $y - 4, $x + 4, $y - 4, white)
	$s.draw_line($x - 4, $y - 3, $x - 4, $y + 4, white)
	$s.draw_line($x - 3, $y + 4, $x + 4, $y + 4, white)
	$s.draw_line($x + 4, $y - 3, $x + 4, $y + 4, white)
	if $u > 0
		$s.draw_triangle($x, $y - 5, $x - 3, $y - 5 - $u, $x + 3, $y - 5 - $u, $c, $c)
	if $d > 0
		$s.draw_triangle($x, $y + 5, $x - 3, $y + 5 + $d, $x + 3, $y + 5 + $d, $c, $c)
	if $l > 0
		$s.draw_triangle($x - 5, $y, $x - 5 - $l, $y - 3, $x - 5 - $l, $y + 3, $c, $c)
	if $r > 0
		$s.draw_triangle($x + 5, $y, $x + 5 + $r, $y - 3, $x + 5 + $r, $y + 3, $c, $c)

function @draw_rcs_fuel_selector($x:number, $y:number)
	var $s = screen($dash, ($screen_display.$screen):number)
	if $rcs_fuel == "o2"
		@draw_button($x - 10, $y, 20, 1, "square", 255, 255, 255, $o2r / 2, $o2g / 2, $o2b / 2, $o2r, $o2g, $o2b, "O2", "")
		@draw_button($x + 10, $y, 20, 1, "square", 255, 255, 255, 0, 0, 0, 128, 128, 128, "CH4", "")
	else
		@draw_button($x - 10, $y, 20, 1, "square", 255, 255, 255, 0, 0, 0, 128, 128, 128, "O2", "")
		@draw_button($x + 10, $y, 20, 1, "square", 255, 255, 255, $ch4r / 2, $ch4g / 2, $ch4b / 2, $ch4r, $ch4g, $ch4b, "CH4", "")
	$s.write($x - (size("Fuel") * $cw - 1), $y + 5 + $s.char_h, white, "Fuel")
	; O2 hit detection
	if $s.button_rect($x - 20, $y - 10, $x, $y + 10, color(0, 0, 0, 0))
		$rcs_fuel = "o2"
	; OFF hit detection
	if $s.button_rect($x, $y - 10, $x + 20, $y + 10, color(0, 0, 0, 0))
		$rcs_fuel = "ch4"

function @draw_rcs_control($x:number, $y:number)
	var $s = screen($dash, ($screen_display.$screen):number)
	if $rcs_state == 1
		@draw_button($x - 10, $y, 20, 1, "square", 255, 255, 255, 0, 128, 0, 0, 255, 0, "ON", "")
		@draw_button($x + 10, $y, 20, 1, "square", 255, 255, 255, 0, 0, 0, 128, 128, 128, "OFF", "")
	else
		@draw_button($x - 10, $y, 20, 1, "square", 255, 255, 255, 0, 0, 0, 128, 128, 128, "ON", "")
		@draw_button($x + 10, $y, 20, 1, "square", 255, 255, 255, 128, 0, 0, 255, 0, 0, "OFF", "")
	$s.write($x - (size("RCS") * $cw - 1), $y + 5 + $s.char_h, white, "RCS")
	; ON hit detection
	if $s.button_rect($x - 20, $y - 10, $x, $y + 10, color(0, 0, 0, 0))
		$rcs_state = 1
	; OFF hit detection
	if $s.button_rect($x, $y - 10, $x + 20, $y + 10, color(0, 0, 0, 0))
		$rcs_state = 0

function @draw_screen_selector($x:number, $y:number, $width:number, $thick:number, $display:number)
	var $s = screen($dash, ($screen_control.$screen):number)
	var $b = black
	var $c = white
	var $w = $width / 2
	var $t = $thick / 2
	if $display == $screen_viewing.$screen
		$c = yellow
	else
		$c = gray
	; outer filled rect in color
	$s.draw_rect($x - $w - $t, $y - $w - $t, $x + $w + $t, $y + $w + $t, $c, $c)
	; inner filled rect in black
	$s.draw_rect($x - $w + $t, $y - $w + $t, $x + $w - $t, $y + $w - $t, $b, $b)
	; Button hit detection
	if $s.button_rect($x - $w + $t, $y - $w + $t, $x + $w - $t, $y + $w - $t, color(0, 0, 0, 0))
		$screen_viewing.$screen = $display:text

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region draw screens
;---------------------------------------------------------------------------------------------------------------------

function @draw_screen_0()
	var $s = screen($dash, ($screen_display.$screen):number)
	$s.write(174, 136, white, "batteries")
	@draw_battery(160, 40, 1, "bridge_port_battery", "bridge", "port")
	@draw_battery(240, 40, 1, "bridge_star_battery", "bridge", "stbd")
	@draw_battery(140, 140, 1, "cargo_port_battery", "cargo", "port")
	@draw_battery(260, 140, 1, "cargo_star_battery", "cargo", "stbd")
	@draw_battery(140, 240, 1, "bay_vent_battery", "engine", "ventral")
	@draw_battery(180, 240, 1, "bay_port_battery", "engine", "port")
	@draw_battery(220, 240, 1, "bay_dors_battery", "engine", "dorsal")
	@draw_battery(260, 240, 1, "bay_star_battery", "engine", "stbd")
	@draw_tank(60, 90, "ch4_tank_density", "ch4_tank_volume", "CH4", "CH4 tank")
	@draw_tank(60, 210, "o2_tank_density", "o2_tank_volume", "O2", "O2 tank")

function @draw_screen_1()
	var $s = screen($dash, ($screen_display.$screen):number)
	$s.write(22, 20, white, "sun tracker")
	$s.write(19, 70, white, "solar panels")
	@draw_solar_panel(30, 100, "solar_panel_1", "1")
	@draw_solar_panel(30, 150, "solar_panel_2", "2")
	@draw_solar_panel(30, 200, "solar_panel_3", "3")
	@draw_solar_panel(30, 250, "solar_panel_4", "4")
	@draw_solar_panel(80, 100, "solar_panel_5", "5")
	@draw_solar_panel(80, 150, "solar_panel_6", "6")
	@draw_solar_panel(80, 200, "solar_panel_7", "7")
	@draw_solar_panel(80, 250, "solar_panel_8", "8")
	@draw_sun_tracker(55, 40, 80, "hrz", 9, "solar_sensor_roll")
	@draw_sun_tracker(120, 55, 80, "vrt", 9, "solar_sensor_pitch")
	@draw_battery(140, 160, 1, "cargo_port_battery", "cargo", "port")
	@draw_battery(180, 160, 1, "bridge_port_battery", "bridge", "port")
	@draw_battery(220, 160, 1, "bridge_star_battery", "bridge", "stbd")
	@draw_battery(260, 160, 1, "cargo_star_battery", "cargo", "stbd")
	@draw_battery(140, 240, 1, "bay_vent_battery", "engine", "ventral")
	@draw_battery(180, 240, 1, "bay_port_battery", "engine", "port")
	@draw_battery(220, 240, 1, "bay_dors_battery", "engine", "dorsal")
	@draw_battery(260, 240, 1, "bay_star_battery", "engine", "stbd")

function @draw_screen_2()
	@draw_tank(60, 90, "ch4_tank_density", "ch4_tank_volume", "CH4", "CH4 tank")
	@draw_tank(60, 210, "o2_tank_density", "o2_tank_volume", "O2", "O2 tank")
	@draw_rcs(150, 70, "dors", $fwd_dors_rcs_1, $fwd_dors_rcs_2, $fwd_dors_rcs_3, $fwd_dors_rcs_4)
	@draw_rcs(150, 30, "vent", $fwd_vent_rcs_1, $fwd_vent_rcs_2, $fwd_vent_rcs_3, $fwd_vent_rcs_4)
	@draw_rcs(130, 50, "port", $fwd_port_rcs_1, $fwd_port_rcs_2, $fwd_port_rcs_3, $fwd_port_rcs_4)
	@draw_rcs(170, 50, "star", $fwd_star_rcs_1, $fwd_star_rcs_2, $fwd_star_rcs_3, $fwd_star_rcs_4)
	@draw_rcs(150, 170, "dors", $mid_dors_rcs_1, $mid_dors_rcs_2, $mid_dors_rcs_3, $mid_dors_rcs_4)
	@draw_rcs(150, 130, "vent", $mid_vent_rcs_1, $mid_vent_rcs_2, $mid_vent_rcs_3, $mid_vent_rcs_4)
	@draw_rcs(130, 150, "port", $mid_port_rcs_1, $mid_port_rcs_2, $mid_port_rcs_3, $mid_port_rcs_4)
	@draw_rcs(170, 150, "star", $mid_star_rcs_1, $mid_star_rcs_2, $mid_star_rcs_3, $mid_star_rcs_4)
	@draw_rcs(150, 270, "dors", $aft_dors_rcs_1, $aft_dors_rcs_2, $aft_dors_rcs_3, $aft_dors_rcs_4)
	@draw_rcs(150, 230, "vent", $aft_vent_rcs_1, $aft_vent_rcs_2, $aft_vent_rcs_3, $aft_vent_rcs_4)
	@draw_rcs(130, 250, "port", $aft_port_rcs_1, $aft_port_rcs_2, $aft_port_rcs_3, $aft_port_rcs_4)
	@draw_rcs(170, 250, "star", $aft_star_rcs_1, $aft_star_rcs_2, $aft_star_rcs_3, $aft_star_rcs_4)
	@draw_rcs_control(240, 250)
	@draw_rcs_fuel_selector(240, 210)

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region update (tick function)
;---------------------------------------------------------------------------------------------------------------------

update

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region control determination
;---------------------------------------------------------------------------------------------------------------------

	; Determine pitch command
	if $sas_pit == 0
		$cmndr_pit = input_number("cmndr_seat", 1)
		$pilot_pit = input_number("pilot_seat", 1)
		$pit_cmd = $cmndr_pit + $pilot_pit

	; Determine yaw command
	if $sas_yaw == 0
		$cmndr_yaw = input_number("cmndr_seat", 2)
		$pilot_yaw = input_number("pilot_seat", 2)
		$yaw_cmd = $cmndr_yaw + $pilot_yaw

	; Determine roll command
	if $sas_rol == 0
		$cmndr_rol = input_number("cmndr_seat", 5)
		$pilot_rol = input_number("pilot_seat", 5)
		$rol_cmd = $cmndr_rol + $pilot_rol

	; Execute RCS commands
	if $rcs_state == 1
		@reset_rcs_parameters()
		if $pit_cmd > 0
			$fwd_dors_rcs_2 = $pit_cmd
			$aft_dors_rcs_2 = $pit_cmd
			$fwd_vent_rcs_1 = $pit_cmd
			$aft_vent_rcs_1 = $pit_cmd
		elseif $pit_cmd < 0
			$fwd_dors_rcs_1 = -$pit_cmd
			$aft_dors_rcs_1 = -$pit_cmd
			$fwd_vent_rcs_2 = -$pit_cmd
			$aft_vent_rcs_2 = -$pit_cmd
		if $yaw_cmd > 0
			$fwd_port_rcs_2 = $yaw_cmd
			$aft_port_rcs_2 = $yaw_cmd
			$fwd_star_rcs_1 = $yaw_cmd
			$aft_star_rcs_1 = $yaw_cmd
		elseif $yaw_cmd < 0
			$fwd_port_rcs_1 = -$yaw_cmd
			$aft_port_rcs_1 = -$yaw_cmd
			$fwd_star_rcs_2 = -$yaw_cmd
			$aft_star_rcs_2 = -$yaw_cmd
		if $rol_cmd > 0
			$mid_dors_rcs_4 = $rol_cmd
			$mid_vent_rcs_4 = $rol_cmd
			$mid_port_rcs_4 = $rol_cmd
			$mid_star_rcs_4 = $rol_cmd
		elseif $rol_cmd < 0
			$mid_dors_rcs_3 = -$rol_cmd
			$mid_vent_rcs_3 = -$rol_cmd
			$mid_port_rcs_3 = -$rol_cmd
			$mid_star_rcs_3 = -$rol_cmd
		@set_rcs_parameters()


;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region screen updates
;---------------------------------------------------------------------------------------------------------------------

	for 0,2 ($i)

		$screen = $i
		var $s = screen($dash, ($screen_display.$screen):number)
		$s.blank(black)

		@draw_screen_selector(30, 30, 40, 5, 0)
		@draw_screen_selector(90, 30, 40, 5, 1)
		@draw_screen_selector(150, 30, 40, 5, 2)
		@draw_screen_selector(210, 30, 40, 5, 3)
		@draw_screen_selector(270, 30, 40, 5, 4)
		@draw_screen_selector(30, 90, 40, 5, 5)
		@draw_screen_selector(90, 90, 40, 5, 6)
		@draw_screen_selector(150, 90, 40, 5, 7)
		@draw_screen_selector(210, 90, 40, 5, 8)
		@draw_screen_selector(270, 90, 40, 5, 9)

		if $screen_viewing.$i == 0
			@draw_screen_0()
		elseif $screen_viewing.$i == 1
			@draw_screen_1()
		elseif $screen_viewing.$i == 2
			@draw_screen_2()

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
