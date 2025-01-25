
;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region variable declarations
;---------------------------------------------------------------------------------------------------------------------

; Screens
var $screen_display = "024"
var $screen_control = "135"
var $screen_viewing = "012"

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region user defined functions
;---------------------------------------------------------------------------------------------------------------------

function @blank_screen($dash:text, $screen:number)
	var $s = screen($dash, ($screen_display.$screen):number)
	$s.blank(black)

function @draw_level_rect($dash:text, $screen:number, $x:number, $y:number, $width:number, $height:number, $thick:number, $lr:number, $lg:number, $lb:number, $vr:number, $vg:number, $vb:number, $fraction:number)
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

function @draw_battery($dash:text, $screen:number, $x:number, $y:number, $scale:number, $name:text, $label1:text, $label2:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $c = input_number($name, 2)
	var $w = $s.char_w / 2
	var $charge = text("{00.00}%", $c * 100)
	var $thrput = text("{00.0}W", input_number($name, 3))
	@draw_level_rect($dash, $screen, $x, $y, $scale * 40, $scale * 40, $scale, 255, 255, 255, 0, 0, 255, $c)
	$s.text_size($scale)
	$s.write($x - (size($label1) * $w), $y - ($scale * 20.5) - ($s.char_h * 2), white, $label1)
	$s.write($x - (size($label2) * $w), $y - ($scale * 20.5) - $s.char_h, white, $label2)
	$s.write($x - (size($charge) * $w), $y - ($s.char_h / 2), white, $charge)
	$s.write($x - (size($thrput) * $w), $y + ($scale * 21.5), white, $thrput)

function @draw_tank($dash:text, $screen:number, $x:number, $y:number, $density:text, $volume:text, $type:text, $label1:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $d = input_number($density, 0)
	var $c = input_text($density, 1)
	var $l = input_number($volume, 0)
	var $v = input_number($volume, 1)
	var $kg = text("{00}kg", $d * $v)
	var $comp = text($type & " {00.00}%", ($c.$type):number * 100)
	var $w = $s.char_w / 2
	if $type == "O2"
		@draw_level_rect($dash, $screen, $x, $y, 80, 100, 2, 255, 255, 255, 0, 128, 255, $l)
	elseif $type == "CH4"
		@draw_level_rect($dash, $screen, $x, $y, 80, 100, 2, 255, 255, 255, 178, 34, 34, $l)
	$s.write($x - (size($label1) * $w), $y - 51 - $s.char_h, white, $label1)
	$s.write($x - (size($kg) * $w), $y - ($s.char_h / 2), white, $kg)
	$s.write($x - (size($comp) * $w), $y + 49 - $s.char_h, white, $comp)

function @draw_solar_panel($dash:text, $screen:number, $x:number, $y:number, $name:text, $label1:text)
	var $s = screen($dash, ($screen_display.$screen):number)
	var $w = $s.char_w / 2
	var $gp = text("{00.0}W", input_number($name, 0))
	$s.draw_rect($x - 7, $y - 20, $x + 7, $y + 20, gray)
	$s.draw_rect($x - 20, $y - 7, $x + 20, $y + 7, gray)
	$s.draw_rect($x - 20, $y - 20, $x + 20, $y + 20, white)
	$s.write($x - (size($gp) * $w), $y + 21, white, $gp)
	$s.write($x - (size($label1) * $w), $y - $s.char_h / 2, white, $label1)

function @draw_button($dash:text, $screen:number, $x:number, $y:number, $width:number, $thick:number, $display:number)
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
; #region update (tick function)
;---------------------------------------------------------------------------------------------------------------------

update

	for 0,2 ($i)

		@blank_screen("main_dash", $i)

		@draw_button("main_dash", $i, 30, 30, 40, 5, 0)
		@draw_button("main_dash", $i, 90, 30, 40, 5, 1)
		@draw_button("main_dash", $i, 150, 30, 40, 5, 2)
		@draw_button("main_dash", $i, 210, 30, 40, 5, 3)
		@draw_button("main_dash", $i, 270, 30, 40, 5, 4)
		@draw_button("main_dash", $i, 30, 90, 40, 5, 5)
		@draw_button("main_dash", $i, 90, 90, 40, 5, 6)
		@draw_button("main_dash", $i, 150, 90, 40, 5, 7)
		@draw_button("main_dash", $i, 210, 90, 40, 5, 8)
		@draw_button("main_dash", $i, 270, 90, 40, 5, 9)

		if $screen_viewing.$i == 0
			var $s = screen("main_dash", ($screen_display.$i):number)
			$s.write(174, 136, white, "batteries")
			@draw_battery("main_dash", $i, 160, 40, 1, "bridge_port_battery", "bridge", "port")
			@draw_battery("main_dash", $i, 240, 40, 1, "bridge_star_battery", "bridge", "starb'd")
			@draw_battery("main_dash", $i, 140, 140, 1, "cargo_port_battery", "cargo", "port")
			@draw_battery("main_dash", $i, 260, 140, 1, "cargo_star_battery", "bridge", "starb'd")
			@draw_battery("main_dash", $i, 140, 240, 1, "bay_vent_battery", "engine", "ventral")
			@draw_battery("main_dash", $i, 180, 240, 1, "bay_port_battery", "engine", "port")
			@draw_battery("main_dash", $i, 220, 240, 1, "bay_dors_battery", "engine", "dorsal")
			@draw_battery("main_dash", $i, 260, 240, 1, "bay_star_battery", "engine", "starb'd")
			@draw_tank("main_dash", $i, 60, 90, "ch4_tank_density", "ch4_tank_volume", "CH4", "CH4 tank")
			@draw_tank("main_dash", $i, 60, 210, "o2_tank_density", "o2_tank_volume", "O2", "O2 tank")
		elseif $screen_viewing.$i == 1
			@draw_solar_panel("main_dash", $i, 30, 100, "solar_panel_1", "1")
			@draw_solar_panel("main_dash", $i, 30, 150, "solar_panel_2", "2")
			@draw_solar_panel("main_dash", $i, 30, 200, "solar_panel_3", "3")
			@draw_solar_panel("main_dash", $i, 30, 250, "solar_panel_4", "4")
			@draw_solar_panel("main_dash", $i, 80, 100, "solar_panel_5", "5")
			@draw_solar_panel("main_dash", $i, 80, 150, "solar_panel_6", "6")
			@draw_solar_panel("main_dash", $i, 80, 200, "solar_panel_7", "7")
			@draw_solar_panel("main_dash", $i, 80, 250, "solar_panel_8", "8")
			@draw_battery("main_dash", $i, 140, 160, 1, "cargo_port_battery", "cargo", "port")
			@draw_battery("main_dash", $i, 180, 160, 1, "bridge_port_battery", "bridge", "port")
			@draw_battery("main_dash", $i, 220, 160, 1, "bridge_star_battery", "bridge", "starb'd")
			@draw_battery("main_dash", $i, 260, 160, 1, "cargo_star_battery", "bridge", "starb'd")
			@draw_battery("main_dash", $i, 140, 240, 1, "bay_vent_battery", "engine", "ventral")
			@draw_battery("main_dash", $i, 180, 240, 1, "bay_port_battery", "engine", "port")
			@draw_battery("main_dash", $i, 220, 240, 1, "bay_dors_battery", "engine", "dorsal")
			@draw_battery("main_dash", $i, 260, 240, 1, "bay_star_battery", "engine", "starb'd")
		elseif $screen_viewing.$i == 2
			@draw_level_rect("main_dash", $i, 150, 150, 60, 100, 4, 255, 0, 0, 255, 128, 0, 0.6)


;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
