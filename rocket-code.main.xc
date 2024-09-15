const $mynumber1 = 0.000000

var $_rocket_pulse1_last_up = 0
var $_rocket_pulse2_last_up = 0
var $_rocket_counter1 = 0

var $hatch_state = 0
var $external_hatch_last_up = 0
var $internal_hatch_last_up = 0

function @pid1($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative

update

	# Hatch controls
	var $external_hatch = input_number("hatch", 0)
	var $internal_hatch = input_number(6, 0)
	var $hatch_pulse = 0
	if ($external_hatch and !$external_hatch_last_up) or ($internal_hatch and !$internal_hatch_last_up)
		$hatch_pulse!!
	$external_hatch_last_up = $external_hatch
	$internal_hatch_last_up = $internal_hatch
	if $hatch_pulse
		$hatch_state!!
	output_number("port_hatch_hinge", 0, $hatch_state)
	output_number("star_hatch_hinge", 0, $hatch_state)

	var $_input_number_6_2 = input_number(6, 2)
	output_number("ground_anchor", 0, (-($_input_number_6_2 - 1)))
	var $_input_number_6_1 = input_number(6, 1)
	output_number("legs", 0, (($_input_number_6_1 * 1.5) - 0.5))
	var $_input_number_6_3 = input_number(6, 3)
	output_number("main_thruster", 0, $_input_number_6_3)
	var $_input_number_10_0 = input_number(10, 0)
	output_number("h2_turbo_pump", 0, ((($_input_number_10_0 + 1) / 2) / 8))
	output_number("o2_turbo_pump", 0, (($_input_number_10_0 + 1) / 2))
	var $_input_number_2_9 = input_number(2, 9)
	output_number(1, 0, (round(((-$_input_number_2_9) * 100)) / 100))
	var $_input_number_3_0 = input_number(3, 0)
	output_number(1, 2, round(($_input_number_3_0 - 6203000)))
	var $_input_alias_2 = input_number("speed_sensor", 0)
	output_number(1, 4, round($_input_alias_2))
	var $_input_alias_3 = input_number("h2_tank_2", 0)
	output_number(9, 0, (round(($_input_alias_3 * 140000)) / 100))
	var $_input_alias_4 = input_number("h2_tank_1", 0)
	output_number(9, 1, (round(($_input_alias_4 * 140000)) / 100))
	var $_input_alias_5 = input_number("o2_tank", 0)
	output_number(9, 2, (round(($_input_alias_5 * 2240000)) / 100))
	var $_input_alias_6 = input_number("h2_turbo_pump", 0)
	output_number(9, 3, (round(($_input_alias_6 * 100)) / 100))
	var $_input_alias_7 = input_number("o2_turbo_pump", 0)
	output_number(9, 4, (round(($_input_alias_7 * 100)) / 100))
	var $_input_alias_8 = input_number("main_thruster", 0)
	output_number(9, 5, (round(($_input_alias_8 / 10)) / 100))
	var $_input_alias_9 = input_number("battery_1", 2)
	output_number(9, 6, $_input_alias_9)
	var $_input_alias_10 = input_number("battery_2", 2)
	output_number(9, 7, $_input_alias_10)
	var $_input_alias_11 = input_number("battery_3", 2)
	output_number(9, 8, $_input_alias_11)
	var $_input_alias_12 = input_number("battery_4", 2)
	output_number(9, 9, $_input_alias_12)
	output_number(6, 4, (-(($_rocket_counter1 % 2) - 1)))
	output_number(6, 5, ($_rocket_counter1 % 2))
	output_number(6, 6, $_input_number_6_1)
	output_number(6, 7, (-($_input_number_6_1 - 1)))
	output_number(6, 8, $_input_number_6_2)
	output_number(6, 9, (-($_input_number_6_2 - 1)))
	output_number(6, 10, ($_input_alias_8 > 0))
	output_number(6, 11, ($_input_alias_8 == 0))
	var $_input_number_9_26 = input_number(9, 26)
	output_number("interior_light_1", 0, $_input_number_9_26)
	output_number("interior_light_2", 0, $_input_number_9_26)
	output_number("interior_light_3", 0, $_input_number_9_26)
	var $_input_number_4_1 = input_number(4, 1)
	output_number("rcs_dorsal", 1, (-$_input_number_4_1))
	output_number("rcs_dorsal", 2, $_input_number_4_1)
	output_number("rcs_ventral", 1, (-$_input_number_4_1))
	output_number("rcs_ventral", 2, $_input_number_4_1)
	var $_input_number_4_8 = input_number(4, 8)
	output_number("rcs_port", 1, (-$_input_number_4_8))
	output_number("rcs_port", 2, $_input_number_4_8)
	output_number("rcs_starboard", 1, $_input_number_4_8)
	output_number("rcs_starboard", 2, (-$_input_number_4_8))
	output_number("main_thruster", 1, (-$_input_number_4_8))
	output_number("main_thruster", 2, (-$_input_number_4_1))
	var $_input_alias_13 = input_number("tilt_left_right", 0)
	var $_pid1 = @pid1($_input_alias_13, 0, 0, 0, 0)
	print($_pid1)