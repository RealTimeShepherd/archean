const $mynumber1 = 0.000000

var $_rocket_pulse1_last_up = 0
var $_rocket_pulse2_last_up = 0
var $_rocket_counter1 : number
var $_rocket_counter1_init = 0

function @_rocket_pid1($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative
function @_rocket_pid2($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative
function @_rocket_pid3($_setpoint:number, $_processvalue:number, $_kp:number, $_ki:number, $_kd:number, $_integral:number, $_prev_error:number) : number
	var $_error = $_setpoint - $_processvalue
	var $_dt = delta_time
	var $_derivative = ($_error - $_prev_error) / $_dt
	$_integral += $_error * $_dt
	$_prev_error = $_error
	return $_kp * $_error + $_ki * $_integral + $_kd * $_derivative

update
	var $_input_alias_1 = input_number("hatch", 0)
	var $_rocket_pulse1 = 0
	if $_input_alias_1 and !$_rocket_pulse1_last_up
		$_rocket_pulse1!!
	$_rocket_pulse1_last_up = $_input_alias_1
	var $_input_number_6_0 = input_number(6, 0)
	var $_rocket_pulse2 = 0
	if $_input_number_6_0 and !$_rocket_pulse2_last_up
		$_rocket_pulse2!!
	$_rocket_pulse2_last_up = $_input_number_6_0
	$_rocket_counter1 += ($_rocket_pulse1 + $_rocket_pulse2)
	if 0
		$_rocket_counter1 = 0
	output_number("port_hatch_hinge", 0, ($_rocket_counter1 % 2))
	output_number("star_hatch_hinge", 0, ($_rocket_counter1 % 2))
	var $_input_number_6_2 = input_number(6, 2)
	output_number("ground_anchor", 0, (-($_input_number_6_2 - 1)))
	var $_input_number_6_1 = input_number(6, 1)
	output_number("legs", 0, (($_input_number_6_1 * 1.5) - 0.5))
	var $_input_number_6_3 = input_number(6, 3)
	output_number("main_thruster", 0, $_input_number_6_3)
	var $_input_alias_2 = input_number("numpad", 0)
	var $_input_number_11_3 = input_number(11, 3)
	var $_input_alias_3 = input_number("port_low_dash", 29)
	var $_pid1 = 0
	if $_input_alias_3
		$_pid1 = @_rocket_pid1($_input_alias_2, $_input_number_11_3, 3, 0.1, 5, 0, 0)
	else
		$_pid1 = @_rocket_pid1($_input_alias_2, $_input_number_11_3, 3, 0.1, 5)
	output_number("h2_turbo_pump", 0, ((($_pid1 > 0.01) / 100) / 8))
	output_number("o2_turbo_pump", 0, (($_pid1 > 0.01) / 100))
	var $_input_number_2_9 = input_number(2, 9)
	output_number(1, 0, (round(((-$_input_number_2_9) * 100)) / 100))
	var $_input_number_3_0 = input_number(3, 0)
	output_number(1, 2, round(($_input_number_3_0 - 6203000)))
	var $_input_alias_4 = input_number("speed_sensor", 0)
	output_number(1, 4, round($_input_alias_4))
	var $_input_alias_5 = input_number("h2_tank_2", 0)
	output_number(9, 0, (round(($_input_alias_5 * 140000)) / 100))
	var $_input_alias_6 = input_number("h2_tank_1", 0)
	output_number(9, 1, (round(($_input_alias_6 * 140000)) / 100))
	var $_input_alias_7 = input_number("o2_tank", 0)
	output_number(9, 2, (round(($_input_alias_7 * 2240000)) / 100))
	var $_input_alias_8 = input_number("h2_turbo_pump", 0)
	output_number(9, 3, (round(($_input_alias_8 * 100)) / 100))
	var $_input_alias_9 = input_number("o2_turbo_pump", 0)
	output_number(9, 4, (round(($_input_alias_9 * 100)) / 100))
	var $_input_alias_10 = input_number("main_thruster", 0)
	output_number(9, 5, (round(($_input_alias_10 / 10)) / 100))
	var $_input_alias_11 = input_number("battery_1", 2)
	output_number(9, 6, $_input_alias_11)
	var $_input_alias_12 = input_number("battery_2", 2)
	output_number(9, 7, $_input_alias_12)
	var $_input_alias_13 = input_number("battery_3", 2)
	output_number(9, 8, $_input_alias_13)
	var $_input_alias_14 = input_number("battery_4", 2)
	output_number(9, 9, $_input_alias_14)
	output_number(6, 4, (-(($_rocket_counter1 % 2) - 1)))
	output_number(6, 5, ($_rocket_counter1 % 2))
	output_number(6, 6, $_input_number_6_1)
	output_number(6, 7, (-($_input_number_6_1 - 1)))
	output_number(6, 8, $_input_number_6_2)
	output_number(6, 9, (-($_input_number_6_2 - 1)))
	output_number(6, 10, ($_input_alias_10 > 0))
	output_number(6, 11, ($_input_alias_10 == 0))
	var $_input_number_9_26 = input_number(9, 26)
	output_number("interior_light_1", 0, $_input_number_9_26)
	output_number("interior_light_2", 0, $_input_number_9_26)
	output_number("interior_light_3", 0, $_input_number_9_26)
	var $_input_alias_15 = input_number("tilt_pitch", 0)
	var $_pid2 = @_rocket_pid2(0, $_input_alias_15, 3, 0.1, 5)
	output_number("rcs_dorsal", 1, (-($_pid2 / 1)))
	output_number("rcs_dorsal", 2, ($_pid2 / 1))
	output_number("rcs_ventral", 1, (-($_pid2 / 1)))
	output_number("rcs_ventral", 2, ($_pid2 / 1))
	var $_input_alias_16 = input_number("tilt_yaw", 0)
	var $_pid3 = @_rocket_pid3(0, $_input_alias_16, 3, 0.1, 5)
	output_number("rcs_port", 1, (-((-$_pid3) / 1)))
	output_number("rcs_port", 2, ((-$_pid3) / 1))
	output_number("rcs_starboard", 1, ((-$_pid3) / 1))
	output_number("rcs_starboard", 2, (-((-$_pid3) / 1)))
	output_number("main_thruster", 1, (-((-$_pid3) / 1)))
	output_number("main_thruster", 2, (-($_pid2 / 1)))
	print($_pid1, $_input_number_11_3)
	print($_pid3, $_pid2)
