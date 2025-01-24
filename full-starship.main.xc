
;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region variable declarations
;---------------------------------------------------------------------------------------------------------------------

; Screens
var $screen_0 = screen("main_dash", 0)
var $screen_1 = screen("main_dash", 1)

var $selected_display_screen_0 = 0

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region user defined functions
;---------------------------------------------------------------------------------------------------------------------

function @get_color($color:text)
	if $color == "black"
		return black
	elseif $color == "white"
		return white
	elseif $color == "red"
		return red
	elseif $color == "green"
		return green
	elseif $color == "blue"
		return blue
	elseif $color == "yellow"
		return yellow
	elseif $color == "pink"
		return pink
	elseif $color == "orange"
		return orange
	elseif $color == "cyan"
		return cyan
	elseif $color == "gray"
		return gray
	elseif $color == "purple"
		return purple
	elseif $color == "brown"
		return brown
	else
		return white

function @draw_level_rect_screen_0($x:number, $y:number, $width:number, $height:number, $thick:number, $line:text, $color:text, $fraction:number)
	var $b = black
	var $l = @get_color($line)
	var $c = @get_color($color)
	var $w = $width / 2
	var $h = $height / 2
	var $t = $thick / 2
	var $f = $fraction * (($h - $t) * 2) + $t
	; outer filled rect in line
	$screen_0.draw_rect($x - $w - $t, $y - $h - $t, $x + $w + $t, $y + $h + $t, $l, $l)
	; inner filled rect in black
	$screen_0.draw_rect($x - $w + $t, $y - $h + $t, $x + $w - $t, $y + $h - $t, $b, $b)
	; inner filled rect in color
	$screen_0.draw_rect($x - $w + $t, $y + $h - $f, $x + $w - $t, $y + $h - $t, $c, $c)

function @draw_button_screen_1($x:number, $y:number, $width:number, $thick:number, $display:number)
	var $b = black
	var $c = white
	var $w = $width / 2
	var $t = $thick / 2
	if $display == $selected_display_screen_0
		$c = yellow
	else
		$c = gray
	; outer filled rect in color
	$screen_1.draw_rect($x - $w - $t, $y - $w - $t, $x + $w + $t, $y + $w + $t, $c, $c)
	; inner filled rect in black
	$screen_1.draw_rect($x - $w + $t, $y - $w + $t, $x + $w - $t, $y + $w - $t, $b, $b)
	if $screen_1.button_rect($x - $w + $t, $y - $w + $t, $x + $w - $t, $y + $w - $t, color(0, 0, 0, 0))
		$selected_display_screen_0 = $display

;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
; #region update (tick function)
;---------------------------------------------------------------------------------------------------------------------

update

	$screen_0.blank(black)

	@draw_button_screen_1(30, 30, 40, 5, 0)
	@draw_button_screen_1(90, 30, 40, 5, 1)
	@draw_button_screen_1(150, 30, 40, 5, 2)
	@draw_button_screen_1(210, 30, 40, 5, 3)
	@draw_button_screen_1(270, 30, 40, 5, 4)
	@draw_button_screen_1(30, 90, 40, 5, 5)
	@draw_button_screen_1(90, 90, 40, 5, 6)
	@draw_button_screen_1(150, 90, 40, 5, 7)
	@draw_button_screen_1(210, 90, 40, 5, 8)
	@draw_button_screen_1(270, 90, 40, 5, 9)

	if $selected_display_screen_0 == 0
		@draw_level_rect_screen_0(150, 150, 80, 120, 8, "blue", "green", 0.8)
	elseif $selected_display_screen_0 == 1
		@draw_level_rect_screen_0(150, 150, 60, 100, 4, "red", "orange", 0.6)


;---------------------------------------------------------------------------------------------------------------------
; #endregion
;---------------------------------------------------------------------------------------------------------------------
