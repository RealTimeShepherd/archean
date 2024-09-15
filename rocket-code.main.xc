const $mynumber1 = 0.000000

var $hatch_state = 0
var $external_hatch_recent = 0
var $internal_hatch_recent = 0

function @pid1($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative

update

	# Hatch controls
	var $external_hatch_button = input_number("hatch", 0)
	var $internal_hatch_button = input_number(6, 0)
	if ($external_hatch_button and !$external_hatch_recent) or ($internal_hatch_button and !$internal_hatch_recent)
		$hatch_state!!
	$external_hatch_recent = $external_hatch_button
	$internal_hatch_recent = $internal_hatch_button
	output_number("port_hatch_hinge", 0, $hatch_state)
	output_number("star_hatch_hinge", 0, $hatch_state)
	output_number(6, 4, !$hatch_state)
	output_number(6, 5, $hatch_state)

	# Legs control
	var $legs_toggle = input_number(6, 1)
	output_number("legs", 0, (($legs_toggle * 1.5) - 0.5))
	output_number(6, 6, $legs_toggle)
	output_number(6, 7, !$legs_toggle)

	# Ground anchor control
	var $ground_anchor_toggle = input_number(6, 2)
	output_number("ground_anchor", 0, !$ground_anchor_toggle)
	output_number(6, 8, $ground_anchor_toggle)
	output_number(6, 9, !$ground_anchor_toggle)

	# Ignition control
	var $ignition_button = input_number(6, 3)
	output_number("main_thruster", 0, $ignition_button)

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