var $doors_state = 0
var $doors_point = 0
var $doors_press = 0
var $doors_slice = 0.005

var $legs_state = 0
var $legs_point = 0
var $legs_press = 0
var $legs_slice = 0.005
var $legs_adj_state = 0
var $legs_adj_pos = 0
var $legs_adj_neg = 0

var $bridge_lamp_state = 0

var $sas_roll_up = 0
var $sas_pro_pitch = 0
var $sas_pro_yaw = 0

var $fuel_screen = screen("dash_low_port", 0)
var $eng_screen = screen("dash_low_port", 1)
var $batt_screen = screen("dash_port", 12)
var $sas_screen = screen("dash_low_star", 0)

function @pitch_pid($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative

function @yaw_pid($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative

function @roll_pid($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative

function @BattDisplay($x:number, $y:number, $w:number, $h:number, $b:number, $l1:text, $l2:text)
	; x coords, y coords, width, height, fraction, type, label 1, label 2
	; interior dimensions
	var $i_x = $x + 1
	var $i_y = $y + 1
	var $i_w = $w - 2
	var $i_h = $h - 2
	; battery charge
	var $b_h = $i_h * $b
	; colours
	var $c = blue
	var $lc = white
	$batt_screen.draw_rect($x, $y, $x + $w, $y + $h, white)
	$batt_screen.draw_rect($i_x, $i_y + $i_h - $b_h, $i_x + $i_w, $i_y + $i_h, $c, $c)
	$batt_screen.write($x + ($w / 2) - 16, $y + $h + 3, white, text("{00.00}%", $b * 100))
	$batt_screen.write($x + ($w / 2) - ((size($l1) / 2) * 6), $y + ($h / 2) - 8, $lc, $l1)
	$batt_screen.write($x + ($w / 2) - ((size($l2) / 2) * 6), $y + ($h / 2), $lc, $l2)

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

function @sas_roll_up() : number
	if $sas_screen.button_rect(10, 10, 40, 40, white)
		$sas_screen.write(30 - ((size("roll up") / 2) * 6), 30, green, "roll up")
		return 1
	else
		$sas_screen.write(30 - ((size("roll up") / 2) * 6), 30, red, "roll up")
		return 0


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
	var $pitch_cmd = 0
	if $sas_screen.button_rect(10, 60, 50, 100, white)
		$sas_pro_pitch = !$sas_pro_pitch
	if $sas_pro_pitch == 1
		; Assume target of prograde pitch = 0
		$sas_screen.write(30 - ((size("pit") / 2) * 6), 72, green, "pit")
		$sas_screen.write(30 - ((size("pro") / 2) * 6), 80, green, "pro")
		var $prograde_pitch = input_number("flight_computer", 19)
		$pitch_cmd = @pitch_pid(0, $prograde_pitch, 3, 0.1, 5)
	else
		$sas_screen.write(30 - ((size("pit") / 2) * 6), 72, red, "pit")
		$sas_screen.write(30 - ((size("pro") / 2) * 6), 80, red, "pro")
		var $cmndr_pit = input_number("commander_seat", 1)
		var $pilot_pit = input_number("pilot_seat", 1)
		$pitch_cmd = $cmndr_pit + $pilot_pit
	if $pitch_cmd > 0
		output_number("rcs_fwd_dors", 2, $pitch_cmd)
		output_number("rcs_aft_dors", 2, $pitch_cmd)
		output_number("rcs_fwd_vent", 1, $pitch_cmd)
		output_number("rcs_aft_vent", 1, $pitch_cmd)
	else
		output_number("rcs_fwd_dors", 1, -$pitch_cmd)
		output_number("rcs_aft_dors", 1, -$pitch_cmd)
		output_number("rcs_fwd_vent", 2, -$pitch_cmd)
		output_number("rcs_aft_vent", 2, -$pitch_cmd)
	; Engine gimbal pitch
	output_number("main_eng_dors", 1, -$pitch_cmd)
	output_number("main_eng_vent", 1, -$pitch_cmd)
	output_number("main_eng_port", 1, -$pitch_cmd)
	output_number("main_eng_star", 1, -$pitch_cmd)

	; Yaw
	var $yaw_cmd = 0
	if $sas_screen.button_rect(10, 110, 50, 150, white)
		$sas_pro_yaw = !$sas_pro_yaw
	if $sas_pro_yaw == 1
		; Assume target of prograde yaw = 0
		$sas_screen.write(30 - ((size("yaw") / 2) * 6), 122, green, "yaw")
		$sas_screen.write(30 - ((size("pro") / 2) * 6), 130, green, "pro")
		var $prograde_yaw = input_number("flight_computer", 20)
		$yaw_cmd = @yaw_pid(0, $prograde_yaw, 3, 0.1, 5)
	else
		$sas_screen.write(30 - ((size("yaw") / 2) * 6), 122, red, "yaw")
		$sas_screen.write(30 - ((size("pro") / 2) * 6), 130, red, "pro")
		var $cmndr_yaw = input_number("commander_seat", 2)
		var $pilot_yaw = input_number("pilot_seat", 2)
		$yaw_cmd = $cmndr_yaw + $pilot_yaw
	if $yaw_cmd > 0
		output_number("rcs_fwd_port", 2, $yaw_cmd)
		output_number("rcs_aft_port", 2, $yaw_cmd)
		output_number("rcs_fwd_star", 1, $yaw_cmd)
		output_number("rcs_aft_star", 1, $yaw_cmd)
	else
		output_number("rcs_fwd_port", 1, -$yaw_cmd)
		output_number("rcs_aft_port", 1, -$yaw_cmd)
		output_number("rcs_fwd_star", 2, -$yaw_cmd)
		output_number("rcs_aft_star", 2, -$yaw_cmd)
	; Engine gimbal yaw
	output_number("main_eng_dors", 2, $yaw_cmd)
	output_number("main_eng_vent", 2, $yaw_cmd)
	output_number("main_eng_port", 2, $yaw_cmd)
	output_number("main_eng_star", 2, $yaw_cmd)

	; Roll
	var $roll_cmd = 0
	if $sas_screen.button_rect(10, 10, 50, 50, white)
		$sas_roll_up = !$sas_roll_up
	if $sas_roll_up == 1
		; Assume target of horizon_roll = 0
		$sas_screen.write(30 - ((size("roll") / 2) * 6), 22, green, "roll")
		$sas_screen.write(30 - ((size("up") / 2) * 6), 30, green, "up")
		var $horizon_roll = input_number("flight_computer", 5)
		$roll_cmd = @roll_pid(0, -$horizon_roll, 0.3, 0.01, 2.5)
	else
		$sas_screen.write(30 - ((size("roll") / 2) * 6), 22, red, "roll")
		$sas_screen.write(30 - ((size("up") / 2) * 6), 30, red, "up")
		var $cmndr_roll = input_number("commander_seat", 5)
		var $pilot_roll = input_number("pilot_seat", 5)
		$roll_cmd = ($cmndr_roll + $pilot_roll) / 10
	if $roll_cmd > 0
		output_number("rcs_fwd_dors", 4, $roll_cmd)
		output_number("rcs_aft_dors", 4, $roll_cmd)
		output_number("rcs_fwd_vent", 4, $roll_cmd)
		output_number("rcs_aft_vent", 4, $roll_cmd)
		output_number("rcs_fwd_port", 4, $roll_cmd)
		output_number("rcs_aft_port", 4, $roll_cmd)
		output_number("rcs_fwd_star", 4, $roll_cmd)
		output_number("rcs_aft_star", 4, $roll_cmd)
	else
		output_number("rcs_fwd_dors", 3, -$roll_cmd)
		output_number("rcs_aft_dors", 3, -$roll_cmd)
		output_number("rcs_fwd_vent", 3, -$roll_cmd)
		output_number("rcs_aft_vent", 3, -$roll_cmd)
		output_number("rcs_fwd_port", 3, -$roll_cmd)
		output_number("rcs_aft_port", 3, -$roll_cmd)
		output_number("rcs_fwd_star", 3, -$roll_cmd)
		output_number("rcs_aft_star", 3, -$roll_cmd)

	; RCS pumps
	output_number("rcs_fwd_pump", 0, 0)
	output_number("rcs_aft_pump", 0, 0)
	if $roll_cmd <> 0
		output_number("rcs_fwd_pump", 0, abs($roll_cmd))
		output_number("rcs_aft_pump", 0, abs($roll_cmd))
	if $pitch_cmd <> 0 or $yaw_cmd <> 0
		output_number("rcs_fwd_pump", 0, max(abs($pitch_cmd), abs($yaw_cmd)))
		output_number("rcs_aft_pump", 0, max(abs($pitch_cmd), abs($yaw_cmd)))

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

	; Legs control
	var $legs_button = input_number("dash_port", 3)
	if ($legs_button and !$legs_press)
		$legs_point!!
	$legs_press = $legs_button
	if $legs_point > $legs_state
		$legs_state = $legs_state + $legs_slice
	if $legs_point < $legs_state
		$legs_state = $legs_state - $legs_slice

	; Smooth leg motion calculations
	if $legs_state <= 0.5
		$legs_adj_state = ($legs_state * 2)
		$legs_adj_state ^= 3
		$legs_adj_state = 1 - ($legs_adj_state / 2)
		$legs_adj_pos = $legs_adj_state * 1.25 - 0.25
		$legs_adj_neg = -$legs_adj_state * 1.25 + 0.25
	else
		$legs_adj_state = ((1 - $legs_state) * 2)
		$legs_adj_state ^= 3
		$legs_adj_state = $legs_adj_state / 2
		$legs_adj_pos = $legs_adj_state * 1.25 - 0.25
		$legs_adj_neg = -$legs_adj_state * 1.25 + 0.25

	; Send motion results to the leg joints
	output_number("dors_lo_hip_pos", 0, $legs_adj_pos)
	output_number("dors_lo_hip_neg", 0, $legs_adj_neg)
	output_number("dors_hi_hip_pos", 0, $legs_adj_pos)
	output_number("dors_hi_hip_neg", 0, $legs_adj_neg)
	output_number("dors_lo_kne_pos", 0, $legs_adj_neg)
	output_number("dors_lo_kne_neg", 0, $legs_adj_pos)
	output_number("dors_hi_kne_pos", 0, $legs_adj_neg)
	output_number("dors_hi_kne_neg", 0, $legs_adj_pos)
	output_number("vent_lo_hip_pos", 0, $legs_adj_pos)
	output_number("vent_lo_hip_neg", 0, $legs_adj_neg)
	output_number("vent_hi_hip_pos", 0, $legs_adj_pos)
	output_number("vent_hi_hip_neg", 0, $legs_adj_neg)
	output_number("vent_lo_kne_pos", 0, $legs_adj_neg)
	output_number("vent_lo_kne_neg", 0, $legs_adj_pos)
	output_number("vent_hi_kne_pos", 0, $legs_adj_neg)
	output_number("vent_hi_kne_neg", 0, $legs_adj_pos)
	output_number("port_lo_hip_pos", 0, $legs_adj_pos)
	output_number("port_lo_hip_neg", 0, $legs_adj_neg)
	output_number("port_hi_hip_pos", 0, $legs_adj_pos)
	output_number("port_hi_hip_neg", 0, $legs_adj_neg)
	output_number("port_lo_kne_pos", 0, $legs_adj_neg)
	output_number("port_lo_kne_neg", 0, $legs_adj_pos)
	output_number("port_hi_kne_pos", 0, $legs_adj_neg)
	output_number("port_hi_kne_neg", 0, $legs_adj_pos)
	output_number("star_lo_hip_pos", 0, $legs_adj_pos)
	output_number("star_lo_hip_neg", 0, $legs_adj_neg)
	output_number("star_hi_hip_pos", 0, $legs_adj_pos)
	output_number("star_hi_hip_neg", 0, $legs_adj_neg)
	output_number("star_lo_kne_pos", 0, $legs_adj_neg)
	output_number("star_lo_kne_neg", 0, $legs_adj_pos)
	output_number("star_hi_kne_pos", 0, $legs_adj_neg)
	output_number("star_hi_kne_neg", 0, $legs_adj_pos)

	; Leg state dash display
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
	output_number("dors_anchor", 0, !$anchors_toggle)
	output_number("vent_anchor", 0, !$anchors_toggle)
	output_number("star_anchor", 0, !$anchors_toggle)
	output_number("port_anchor", 0, !$anchors_toggle)
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

	; Battery charge display
	$batt_screen.blank()
	var $fwd_battery_1 = input_number("fwd_battery_1", 2)
	var $fwd_battery_2 = input_number("fwd_battery_2", 2)
	var $aft_battery_1 = input_number("aft_battery_1", 2)
	var $aft_battery_2 = input_number("aft_battery_2", 2)
	var $aft_battery_3 = input_number("aft_battery_3", 2)
	var $aft_battery_4 = input_number("aft_battery_4", 2)
	@BattDisplay( 77,  9, 50, 60, $fwd_battery_1, "fwd", "batt_1")
	@BattDisplay(140,  9, 50, 60, $fwd_battery_2, "fwd", "batt_2")
	@BattDisplay( 14, 91, 50, 60, $aft_battery_1, "aft", "batt_1")
	@BattDisplay( 77, 91, 50, 60, $aft_battery_2, "aft", "batt_2")
	@BattDisplay(140, 91, 50, 60, $aft_battery_3, "aft", "batt_3")
	@BattDisplay(203, 91, 50, 60, $aft_battery_4, "aft", "batt_4")

	; RCS controls
	var $rcs_on = input_number("dash_low_port", 2)
	output_number("dash_low_port", 10, $rcs_on)
	output_number("dash_low_port", 11, !$rcs_on)
	var $rcs_h2_o2 = input_number("dash_low_port", 3)
	output_number("dash_low_port", 12, $rcs_h2_o2)
	output_number("dash_low_port", 13, !$rcs_h2_o2)
	; Enable/disable RCS use H2 or O2
	if $rcs_on == 0
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
	var $h2_resv_pump_on = input_number("dash_low_port", 5)
	output_number("dash_low_port", 16, $h2_resv_pump_on)
	output_number("dash_low_port", 17, !$h2_resv_pump_on)
	var $o2_resv_pump_on = input_number("dash_low_port", 6)
	output_number("dash_low_port", 18, $o2_resv_pump_on)
	output_number("dash_low_port", 19, !$o2_resv_pump_on)
	; Move fuel
	if $h2_resv_pump_on == 1
		if $to_main_resv == 1
			output_number("h2_resv_pump", 0, 1)
		else
			output_number("h2_resv_pump", 0, -1)
	if $o2_resv_pump_on == 1
		if $to_main_resv == 1
			output_number("o2_resv_pump", 0, 1)
		else
			output_number("o2_resv_pump", 0, -1)

	; Fuel load controls
	var $prop_load_unload = input_number("dash_low_port", 7)
	output_number("dash_low_port", 20, $prop_load_unload)
	output_number("dash_low_port", 21, !$prop_load_unload)
	var $h2_pump_on = input_number("dash_low_port", 8)
	output_number("dash_low_port", 22, $h2_pump_on)
	output_number("dash_low_port", 23, !$h2_pump_on)
	var $o2_pump_on = input_number("dash_low_port", 9)
	output_number("dash_low_port", 24, $o2_pump_on)
	output_number("dash_low_port", 25, !$o2_pump_on)
	; Load/unload fuel
	if $h2_pump_on == 1
		if $prop_load_unload == 1
			output_number("h2_load_pump", 0, 1)
		else
			output_number("h2_load_pump", 0, -1)
	else
		output_number("h2_load_pump", 0, 0)
	if $o2_pump_on == 1
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