
;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region variable declarations
;---------------------------------------------------------------------------------------------------------------------

; Screens
var $screen_display = "024"
var $screen_control = "135"
var $screen_viewing = "000"

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

function @draw_button($dash:text, $screen:number, $x:number, $y:number, $width:number, $thick:number, $display:number)
	var $s = screen($dash, ($screen_control.$screen):number)
	var $b = black
	var $c = white
	var $w = $width / 2
	var $t = $thick / 2
	print($screen_viewing.$screen)
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
			var $bay_vent_battery = input_number("bay_vent_battery", 2)
			var $bay_port_battery = input_number("bay_port_battery", 2)
			var $bay_dors_battery = input_number("bay_dors_battery", 2)
			var $bay_star_battery = input_number("bay_star_battery", 2)
			@draw_level_rect("main_dash", $i, 50, 270, 20, 20, 1, 255, 255, 255, 0, 0, 255, $bay_vent_battery)
			@draw_level_rect("main_dash", $i, 70, 270, 20, 20, 1, 255, 255, 255, 0, 0, 255, $bay_port_battery)
			@draw_level_rect("main_dash", $i, 90, 270, 20, 20, 1, 255, 255, 255, 0, 0, 255, $bay_dors_battery)
			@draw_level_rect("main_dash", $i, 110, 270, 20, 20, 1, 255, 255, 255, 0, 0, 255, $bay_star_battery)
		elseif $screen_viewing.$i == 1
			@draw_level_rect("main_dash", $i, 150, 150, 60, 100, 4, 255, 0, 0, 255, 128, 0, 0.6)


;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
