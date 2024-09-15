
var $hatch_state = 1
var $external_hatch_recent = 0
var $internal_hatch_recent = 0

update

	; Dash 9 - lower port
	; Fuel levels
	var $h2_tank_2_level = input_number("h2_tank_2", 0)
	output_text(9, 0, text("{0.00}", $h2_tank_2_level * 1400))
	var $h2_tank_1_level = input_number("h2_tank_1", 0)
	output_text(9, 1, text("{0.00}", $h2_tank_1_level * 1400))
	var $o2_tank_level = input_number("o2_tank", 0)
	output_text(9, 2, text("{0.00}", $o2_tank_level * 22400))

	; Fuel flow
	var $main_engine_throttle = input_number(10, 0)
	output_number("h2_turbo_pump", 0, (($main_engine_throttle + 1) / 16))
	output_number("o2_turbo_pump", 0, (($main_engine_throttle + 1) / 2))
	var $h2_turbo_pump = input_number("h2_turbo_pump", 0)
	output_text(9, 3, text("{0.0}", $h2_turbo_pump))
	var $o2_turbo_pump = input_number("o2_turbo_pump", 0)
	output_text(9, 4, text("{0.0}", $o2_turbo_pump))

	; Thrust
	var $main_thruster = input_number("main_thruster", 0)
	output_text(9, 5, text("{0.0}", $main_thruster / 1000))

	; Battery levels
	var $battery_1 = input_number("battery_1", 2)
	output_text(9, 6, text("{0.00}", $battery_1 * 100))
	var $battery_2 = input_number("battery_2", 2)
	output_text(9, 7, text("{0.00}", $battery_2 * 100))
	var $battery_3 = input_number("battery_3", 2)
	output_text(9, 8, text("{0.00}", $battery_3 * 100))
	var $battery_4 = input_number("battery_4", 2)
	output_text(9, 9, text("{0.00}", $battery_4 * 100))

	; Interior light control
	var $interior_light_toggle = input_number(9, 26)
	output_number("interior_light_1", 0, $interior_light_toggle)
	output_number("interior_light_2", 0, $interior_light_toggle)
	output_number("interior_light_3", 0, $interior_light_toggle)

	; Dash 6 - upper port
	; Hatch controls
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

	; Legs control
	var $legs_toggle = input_number(6, 1)
	output_number("legs", 0, (($legs_toggle * 1.5) - 0.5))
	output_number(6, 6, $legs_toggle)
	output_number(6, 7, !$legs_toggle)

	; Ground anchor control
	var $ground_anchor_toggle = input_number(6, 2)
	output_number("ground_anchor", 0, !$ground_anchor_toggle)
	output_number(6, 8, $ground_anchor_toggle)
	output_number(6, 9, !$ground_anchor_toggle)

	; Ignition control
	var $ignition_button = input_number(6, 3)
	output_number("main_thruster", 0, $ignition_button)
	output_number(6, 10, ($main_thruster > 0))
	output_number(6, 11, ($main_thruster == 0))

	; Central dash display
	; G-force {0.00}
	var $g_force_x = input_number(2, 8)
	var $g_force_y = input_number(2, 9)
	var $g_force_z = input_number(2, 10)
	var $g_force_mag = sqrt(($g_force_x * $g_force_x) + ($g_force_y * $g_force_y) + ($g_force_z * $g_force_z))
	output_text(1, 0, text("{0.00}", $g_force_mag))

	; Prograde pitch deg {0.0}
	var $pro_pitch = input_number(11, 19)
	output_text(1, 1, text("{0.0}", $pro_pitch))

	; Heading deg {0.00}
	var $heading = input_number(11, 6)
	output_text(1, 2, text("{0.00}", $heading))

	; Vertical speed m/s {0.00}
	var $v_spd = input_number(11, 1)
	output_text(1, 3, text("{0.00}", $v_spd))

	; Orbital speed m/s {0.0}
	var $o_spd = input_number(11, 16)
	output_text(1, 4, text("{0.0}", $o_spd))

	; Altitude km {0.00}
	var $alt_sea = input_number(11, 2)
	output_text(1, 5, text("{0.00}", $alt_sea / 1000))

	; Apogee km {0.00}
	var $apogee = input_number(11, 18)
	output_text(1, 6, text("{0.00}", $apogee / 1000))

	; Perigee km {0.00}
	var $perigee = input_number(11, 17)
	output_text(1, 7, text("{0.00}", $perigee / 1000))

	; Pilot control
	; Pitch
	var $star_pilot_w_s = input_number(4, 1)
	var $port_pilot_w_s = input_number(8, 1)
	output_number("rcs_dorsal", 1, -$star_pilot_w_s - $port_pilot_w_s)
	output_number("rcs_dorsal", 2, $star_pilot_w_s + $port_pilot_w_s)
	output_number("rcs_ventral", 1, -$star_pilot_w_s - $port_pilot_w_s)
	output_number("rcs_ventral", 2, $star_pilot_w_s + $port_pilot_w_s)
	output_number("main_thruster", 2, -$star_pilot_w_s-$port_pilot_w_s)
	; Yaw
	var $star_pilot_a_d = input_number(4, 2)
	var $port_pilot_a_d = input_number(8, 2)
	output_number("rcs_port", 1, -$star_pilot_a_d - $port_pilot_a_d)
	output_number("rcs_port", 2, $star_pilot_a_d + $port_pilot_a_d)
	output_number("rcs_starboard", 1, $star_pilot_a_d + $port_pilot_a_d)
	output_number("rcs_starboard", 2, -$star_pilot_a_d - $port_pilot_a_d)
	output_number("main_thruster", 1, -$star_pilot_a_d - $port_pilot_a_d)
	; Roll
	var $star_pilot_q_e = input_number(4, 5)
	var $port_pilot_q_e = input_number(8, 5)
	output_number("rcs_dorsal", 3, -$star_pilot_q_e - $port_pilot_q_e)
	output_number("rcs_port", 3, -$star_pilot_q_e - $port_pilot_q_e)
	output_number("rcs_ventral", 3, -$star_pilot_q_e - $port_pilot_q_e)
	output_number("rcs_starboard", 3, -$star_pilot_q_e - $port_pilot_q_e)
	output_number("rcs_dorsal", 4, $star_pilot_q_e + $port_pilot_q_e)
	output_number("rcs_port", 4, $star_pilot_q_e + $port_pilot_q_e)
	output_number("rcs_ventral", 4, $star_pilot_q_e + $port_pilot_q_e)
	output_number("rcs_starboard", 4, $star_pilot_q_e + $port_pilot_q_e)
