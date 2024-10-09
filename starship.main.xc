var $doors_state = 1
var $doors_point = 1
var $doors_press = 0
var $doors_slice = 0.005

var $legs_state = 1
var $legs_point = 1
var $legs_press = 0
var $legs_slice = 0.005
var $legs_adj_state = 0
var $legs_adj_pos = 0
var $legs_adj_neg = 0

var $bridge_lamp_state = 0

var $fuel_screen = screen("dash_low_port", 0)
var $eng_screen = screen("dash_low_port", 1)

function @TankDisplay($x:number, $y:number, $w:number, $h:number, $f:number, $t:text, $l1:text, $l2:text)
	; x coords, y coords, width, height, fraction, type, label 1, label 2
	; interior dimensions
	var $i_x = $x + 1
	var $i_y = $y + 1
	var $i_w = $w - 2
	var $i_h = $h - 2
	; fuel height
	var $f_h = $i_h * $f
	; fuel type
	var $c = white
	var $lc = gray
	if $t == "o2"
		$c = cyan
		$lc = red
	elseif $t == "h2"
		$c = yellow
		$lc = blue
	$fuel_screen.draw_rect($x, $y, $x + $w, $y + $h, white)
	$fuel_screen.draw_rect($i_x, $i_y + $i_h - $f_h, $i_x + $i_w, $i_y + $i_h, $c, $c)
	$fuel_screen.write($x + ($w / 2) - 16, $y + $h + 3, white, text("{00.00}%", $f * 100))
	$fuel_screen.write($x + ($w / 2) - ((size($l1) / 2) * 6), $y + ($h / 2) - 8, $lc, $l1)
	$fuel_screen.write($x + ($w / 2) - ((size($l2) / 2) * 6), $y + ($h / 2), $lc, $l2)

function @EngineDisplay($x:number, $y:number, $r:number, $t:number, $m:number, $o:number, $h:number, $l1:text, $l2:text)
	; x coords, y coords, radius, thrust, maximum, h2 flow, o2 flow, label 1, label 2
	$eng_screen.draw_circle($x, $y, ($r - 1) * ($t / $m), blue, blue)
	if $t > 0
		$eng_screen.draw_circle($x, $y, $r, green)
	else
		$eng_screen.draw_circle($x, $y, $r, red)
	$eng_screen.write($x - ((size($l1) / 2) * 6), $y - 16, white, $l1)
	$eng_screen.write($x - ((size($l2) / 2) * 6), $y - 4, white, $l2)
	$eng_screen.write($x - 19, $y + 8, white, text("{00.00}kN", $t))
	$eng_screen.write($x - 40, $y + $r + 1, cyan, text("{00.00}", $o))
	$eng_screen.write($x + 10, $y + $r + 1, yellow, text("{00.00}", $h))

update

	; Pilot controls
	; Throttle - Main engines
	var $throttle = (input_number("throttle", 0) + 1) / 2
	output_number("o2_pump_dors", 0, $throttle)
	output_number("o2_pump_vent", 0, $throttle)
	output_number("o2_pump_port", 0, $throttle)
	output_number("o2_pump_star", 0, $throttle)
	output_number("h2_pump", 0, $throttle / 2)
	if $throttle > 0.01 and $throttle < 0.5
		; Ignition
		output_number("main_eng_dors", 0, 1)
		output_number("main_eng_vent", 0, 1)
		output_number("main_eng_port", 0, 1)
		output_number("main_eng_star", 0, 1)

	; Pitch
	var $cmndr_pit = input_number("commander_seat", 1)
	var $pilot_pit = input_number("pilot_seat", 1)
	var $bridge_pit = $cmndr_pit + $pilot_pit
	output_number("rcs_fwd_dors", 1, -$bridge_pit)
	output_number("rcs_fwd_dors", 2, $bridge_pit)
	output_number("rcs_aft_dors", 1, -$bridge_pit)
	output_number("rcs_aft_dors", 2, $bridge_pit)
	output_number("rcs_fwd_vent", 2, -$bridge_pit)
	output_number("rcs_fwd_vent", 1, $bridge_pit)
	output_number("rcs_aft_vent", 2, -$bridge_pit)
	output_number("rcs_aft_vent", 1, $bridge_pit)
	output_number("main_eng_dors", 1, -$bridge_pit)
	output_number("main_eng_vent", 1, -$bridge_pit)
	output_number("main_eng_port", 1, -$bridge_pit)
	output_number("main_eng_star", 1, -$bridge_pit)

	; Yaw
	var $cmndr_yaw = input_number("commander_seat", 2)
	var $pilot_yaw = input_number("pilot_seat", 2)
	var $bridge_yaw = $cmndr_yaw + $pilot_yaw
	output_number("rcs_fwd_port", 1, -$bridge_yaw)
	output_number("rcs_fwd_port", 2, $bridge_yaw)
	output_number("rcs_aft_port", 1, -$bridge_yaw)
	output_number("rcs_aft_port", 2, $bridge_yaw)
	output_number("rcs_fwd_star", 2, -$bridge_yaw)
	output_number("rcs_fwd_star", 1, $bridge_yaw)
	output_number("rcs_aft_star", 2, -$bridge_yaw)
	output_number("rcs_aft_star", 1, $bridge_yaw)
	output_number("main_eng_dors", 2, $bridge_yaw)
	output_number("main_eng_vent", 2, $bridge_yaw)
	output_number("main_eng_port", 2, $bridge_yaw)
	output_number("main_eng_star", 2, $bridge_yaw)


	; Roll
	var $cmndr_roll = input_number("commander_seat", 5)
	var $pilot_roll = input_number("pilot_seat", 5)
	var $bridge_roll = $cmndr_roll + $pilot_roll
	output_number("rcs_fwd_dors", 3, -$bridge_roll)
	output_number("rcs_fwd_dors", 4, $bridge_roll)
	output_number("rcs_aft_dors", 3, -$bridge_roll)
	output_number("rcs_aft_dors", 4, $bridge_roll)
	output_number("rcs_fwd_vent", 3, -$bridge_roll)
	output_number("rcs_fwd_vent", 4, $bridge_roll)
	output_number("rcs_aft_vent", 3, -$bridge_roll)
	output_number("rcs_aft_vent", 4, $bridge_roll)
	output_number("rcs_fwd_port", 3, -$bridge_roll)
	output_number("rcs_fwd_port", 4, $bridge_roll)
	output_number("rcs_aft_port", 3, -$bridge_roll)
	output_number("rcs_aft_port", 4, $bridge_roll)
	output_number("rcs_fwd_star", 3, -$bridge_roll)
	output_number("rcs_fwd_star", 4, $bridge_roll)
	output_number("rcs_aft_star", 3, -$bridge_roll)
	output_number("rcs_aft_star", 4, $bridge_roll)

	; RCS pumps
	output_number("rcs_fwd_pump", 0, 0)
	output_number("rcs_aft_pump", 0, 0)
	if $bridge_pit <> 0 or $bridge_yaw <> 0
		output_number("rcs_fwd_pump", 0, 1)
		output_number("rcs_aft_pump", 0, 1)
	if $bridge_roll <> 0
		output_number("rcs_fwd_pump", 0, 0.1)
		output_number("rcs_aft_pump", 0, 0.1)

	; dash_port
	; Doors controls
	var $doors_button = input_number("dash_port", 0)
	if ($doors_button and !$doors_press)
		$doors_point!!
	$doors_press = $doors_button
	if $doors_point > $doors_state
		$doors_state = $doors_state + $doors_slice
	if $doors_point < $doors_state
		$doors_state = $doors_state - $doors_slice
	output_number("doors", 0, $doors_state)
	if $doors_state == 0
		output_number("dash_port", 1, 1)
	else
		output_number("dash_port", 1, 0)
	if $doors_state == 1
		output_number("dash_port", 2, 1)
	else
		output_number("dash_port", 2, 0)

	var $legs_button = input_number("dash_port", 3)
	if ($legs_button and !$legs_press)
		$legs_point!!
	$legs_press = $legs_button
	if $legs_point > $legs_state
		$legs_state = $legs_state + $legs_slice
	if $legs_point < $legs_state
		$legs_state = $legs_state - $legs_slice
	if $legs_state <= 0.5
		$legs_adj_state = ($legs_state * 2)
		$legs_adj_state ^= 3
		$legs_adj_state = 1 - ($legs_adj_state / 2)
		$legs_adj_pos = $legs_adj_state * 1.25 - 0.25
		$legs_adj_neg = -$legs_adj_state * 1.25 + 0.25

		output_number("dors_lo_hip_pos", 0, $legs_adj_pos)
		output_number("dors_lo_hip_neg", 0, $legs_adj_neg)
		output_number("dors_hi_hip_pos", 0, $legs_adj_pos)
		output_number("dors_hi_hip_neg", 0, $legs_adj_neg)
		output_number("dors_lo_kne_pos", 0, $legs_adj_neg)
		output_number("dors_lo_kne_neg", 0, $legs_adj_pos)
		output_number("dors_hi_kne_pos", 0, $legs_adj_neg)
		output_number("dors_hi_kne_neg", 0, $legs_adj_pos)

	else
		$legs_adj_state = ((1 - $legs_state) * 2)
		$legs_adj_state ^= 3
		$legs_adj_state = $legs_adj_state / 2
		$legs_adj_pos = $legs_adj_state * 1.25 - 0.25
		$legs_adj_neg = -$legs_adj_state * 1.25 + 0.25

		output_number("dors_lo_hip_pos", 0, $legs_adj_pos)
		output_number("dors_lo_hip_neg", 0, $legs_adj_neg)
		output_number("dors_hi_hip_pos", 0, $legs_adj_pos)
		output_number("dors_hi_hip_neg", 0, $legs_adj_neg)
		output_number("dors_lo_kne_pos", 0, $legs_adj_neg)
		output_number("dors_lo_kne_neg", 0, $legs_adj_pos)
		output_number("dors_hi_kne_pos", 0, $legs_adj_neg)
		output_number("dors_hi_kne_neg", 0, $legs_adj_pos)

	if $legs_state == 0
		output_number("dash_port", 4, 1)
	else
		output_number("dash_port", 4, 0)
	if $legs_state == 1
		output_number("dash_port", 5, 1)
	else
		output_number("dash_port", 5, 0)

	; Anchors control
	var $anchors_toggle = input_number("dash_port", 6)
	output_number("anchors", 0, !$anchors_toggle)
	output_number("dash_port", 7, $anchors_toggle)
	output_number("dash_port", 8, !$anchors_toggle)

	; dash_low_port
	; Main engine display
	$eng_screen.blank()
	$eng_screen.write(90, 285, white, text("Main throttle {00.00}%", $throttle * 100))
	var $main_eng_dors = input_number("main_eng_dors", 0) / 1000
	var $main_eng_vent = input_number("main_eng_vent", 0) / 1000
	var $main_eng_port = input_number("main_eng_port", 0) / 1000
	var $main_eng_star = input_number("main_eng_star", 0) / 1000
	var $h2_pump = input_number("h2_pump", 0)
	var $o2_pump_dors = input_number("o2_pump_dors", 0)
	var $o2_pump_vent = input_number("o2_pump_vent", 0)
	var $o2_pump_port = input_number("o2_pump_port", 0)
	var $o2_pump_star = input_number("o2_pump_star", 0)
	@EngineDisplay(150, 50, 40, $main_eng_dors, 1800, $o2_pump_dors, $h2_pump / 4, "main eng", "dorsal")
	@EngineDisplay(150, 220, 40, $main_eng_vent, 1800, $o2_pump_vent, $h2_pump / 4, "main eng", "ventral")
	@EngineDisplay(65, 135, 40, $main_eng_port, 1800, $o2_pump_port, $h2_pump / 4, "main eng", "port")
	@EngineDisplay(235, 135, 40, $main_eng_star, 1800, $o2_pump_star, $h2_pump / 4, "main eng", "starb'd")

	; Fuel display
	$fuel_screen.blank()
	var $h2_main_tank_a = input_number("h2_main_tank_a", 0)
	var $h2_main_tank_b = input_number("h2_main_tank_b", 0)
	var $h2_main_tank_c = input_number("h2_main_tank_c", 0)
	var $h2_main_tank_d = input_number("h2_main_tank_d", 0)
	var $o2_main_tank_a = input_number("o2_main_tank_a", 0)
	var $o2_main_tank_b = input_number("o2_main_tank_b", 0)
	var $h2_resv_tank_1 = input_number("h2_resv_tank_1", 0)
	var $h2_resv_tank_2 = input_number("h2_resv_tank_2", 0)
	var $h2_resv_tank_3 = input_number("h2_resv_tank_3", 0)
	var $h2_resv_tank_4 = input_number("h2_resv_tank_4", 0)
	var $h2_resv_tank_5 = input_number("h2_resv_tank_5", 0)
	var $h2_resv_tank_6 = input_number("h2_resv_tank_6", 0)
	var $h2_resv_tank_7 = input_number("h2_resv_tank_7", 0)
	var $h2_resv_tank_8 = input_number("h2_resv_tank_8", 0)
	var $o2_resv_tank_1 = input_number("o2_resv_tank_1", 0)
	var $o2_resv_tank_2 = input_number("o2_resv_tank_2", 0)
	var $o2_resv_tank_3 = input_number("o2_resv_tank_3", 0)
	var $o2_resv_tank_4 = input_number("o2_resv_tank_4", 0)
	@TankDisplay( 14,   9, 75, 75, $h2_main_tank_a, "h2", "h2_main", "tank_a")
	@TankDisplay(102,   9, 75, 75, $h2_main_tank_b, "h2", "h2_main", "tank_b")
	@TankDisplay( 14, 106, 75, 75, $h2_main_tank_c, "h2", "h2_main", "tank_c")
	@TankDisplay(102, 106, 75, 75, $h2_main_tank_d, "h2", "h2_main", "tank_d")
	@TankDisplay( 14, 203, 75, 75, $o2_main_tank_a, "o2", "o2_main", "tank_a")
	@TankDisplay(102, 203, 75, 75, $o2_main_tank_a, "o2", "o2_main", "tank_b")
	@TankDisplay(201,   9, 20, 30, $h2_resv_tank_1, "h2", "h2", "r1")
	@TankDisplay(256,   9, 20, 30, $h2_resv_tank_2, "h2", "h2", "r2")
	@TankDisplay(201,  54, 20, 30, $h2_resv_tank_3, "h2", "h2", "r3")
	@TankDisplay(256,  54, 20, 30, $h2_resv_tank_4, "h2", "h2", "r4")
	@TankDisplay(201, 106, 20, 30, $h2_resv_tank_1, "h2", "h2", "r5")
	@TankDisplay(256, 106, 20, 30, $h2_resv_tank_2, "h2", "h2", "r6")
	@TankDisplay(201, 151, 20, 30, $h2_resv_tank_3, "h2", "h2", "r7")
	@TankDisplay(256, 151, 20, 30, $h2_resv_tank_4, "h2", "h2", "r8")
	@TankDisplay(201, 203, 20, 30, $o2_resv_tank_1, "o2", "o2", "r1")
	@TankDisplay(256, 203, 20, 30, $o2_resv_tank_2, "o2", "o2", "r2")
	@TankDisplay(201, 248, 20, 30, $o2_resv_tank_3, "o2", "o2", "r3")
	@TankDisplay(256, 248, 20, 30, $o2_resv_tank_4, "o2", "o2", "r4")

	; RCS controls
	var $rcs_on_off = input_number("dash_low_port", 2)
	output_number("dash_low_port", 10, $rcs_on_off)
	output_number("dash_low_port", 11, !$rcs_on_off)
	var $rcs_h2_o2 = input_number("dash_low_port", 3)
	output_number("dash_low_port", 12, $rcs_h2_o2)
	output_number("dash_low_port", 13, !$rcs_h2_o2)
	; Enable/disable RCS use H2 or O2
	if $rcs_on_off == 0
		output_number("h2_resv_rcs", 0, 0)
		output_number("o2_resv_rcs", 0, 0)
	else
		if $rcs_h2_o2 == 1
			output_number("h2_resv_rcs", 0, 1)
			output_number("o2_resv_rcs", 0, 0)
		else
			output_number("h2_resv_rcs", 0, 0)
			output_number("o2_resv_rcs", 0, 1)

	; Reserve tanks controls
	var $to_main_resv = input_number("dash_low_port", 4)
	output_number("dash_low_port", 14, $to_main_resv)
	output_number("dash_low_port", 15, !$to_main_resv)
	var $h2_resv_pump_on_off = input_number("dash_low_port", 5)
	output_number("dash_low_port", 16, $h2_resv_pump_on_off)
	output_number("dash_low_port", 17, !$h2_resv_pump_on_off)
	var $o2_resv_pump_on_off = input_number("dash_low_port", 6)
	output_number("dash_low_port", 18, $o2_resv_pump_on_off)
	output_number("dash_low_port", 19, !$o2_resv_pump_on_off)
	; Move fuel
	if $h2_resv_pump_on_off == 1
		if $to_main_resv == 1
			output_number("h2_resv_pump", 0, 1)
		else
			output_number("h2_resv_pump", 0, -1)
	if $o2_resv_pump_on_off == 1
		if $to_main_resv == 1
			output_number("o2_resv_pump", 0, 1)
		else
			output_number("o2_resv_pump", 0, -1)

	; Fuel load controls
	var $prop_load_unload = input_number("dash_low_port", 7)
	output_number("dash_low_port", 20, $prop_load_unload)
	output_number("dash_low_port", 21, !$prop_load_unload)
	var $h2_pump_on_off = input_number("dash_low_port", 8)
	output_number("dash_low_port", 22, $h2_pump_on_off)
	output_number("dash_low_port", 23, !$h2_pump_on_off)
	var $o2_pump_on_off = input_number("dash_low_port", 9)
	output_number("dash_low_port", 24, $o2_pump_on_off)
	output_number("dash_low_port", 25, !$o2_pump_on_off)
	; Load/unload fuel
	if $h2_pump_on_off == 1
		if $prop_load_unload == 1
			output_number("h2_load_pump", 0, 1)
		else
			output_number("h2_load_pump", 0, -1)
	else
		output_number("h2_load_pump", 0, 0)
	if $o2_pump_on_off == 1
		if $prop_load_unload == 1
			output_number("o2_load_pump", 0, 1)
		else
			output_number("o2_load_pump", 0, -1)
	else
		output_number("o2_load_pump", 0, 0)

	; Bridge lamp controls
	var $bridge_lamp_toggle_port = input_number("strip_dash", 0)
	var $bridge_lamp_toggle_star = input_number("strip_dash", 1)
	if $bridge_lamp_toggle_port <> $bridge_lamp_state or $bridge_lamp_toggle_star <> $bridge_lamp_state
		$bridge_lamp_state!!
		output_number("strip_dash", 0, $bridge_lamp_state)
		output_number("strip_dash", 1, $bridge_lamp_state)
	output_number("port_bridge_lamp", 0, $bridge_lamp_state)
	output_number("star_bridge_lamp", 0, $bridge_lamp_state)

	;EOF