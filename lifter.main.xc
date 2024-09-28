
var $vertical_state = 0 ; 1 is fully lifted and 0 is fully lowered
var $vertical_increment = 0.01

var $head_rotational_state = 0
var $head_rotational_increment = 0.01

update

	; Buggy control
	var $pilot_w_s = input_number(11, 1)
	output_number(10, 0, ($pilot_w_s / 20)) ; front left forward
	output_number(9, 0, ($pilot_w_s / 20)) ; rear left forward
	output_number(5, 0, (-($pilot_w_s / 20))) ; rear right forward
	output_number(4, 0, (-($pilot_w_s / 20))) ; front right forward
	var $pilot_a_d = input_number(11, 2)
	output_number(10, 1, $pilot_a_d) ; front left steering
	output_number(4, 1, $pilot_a_d) ; front right steering

	; Vertical movement
	var $pilot_u_d = input_number(11, 3) ; Up and down is space and left Ctrl
	if $pilot_u_d == -1
		$vertical_state = $vertical_state - $vertical_increment
	if $pilot_u_d == 1
		$vertical_state = $vertical_state + $vertical_increment
	if $vertical_state > 1
		$vertical_state = 1
	if $vertical_state < 0
		$vertical_state = 0
	output_number("lifting_arm", 0, $vertical_state)

	; Head rotation
	var $pilot_e_q = input_number(11, 5)
	if $pilot_e_q == 1
		$head_rotational_state = $head_rotational_state - $head_rotational_increment
	if $pilot_e_q == -1
		$head_rotational_state = $head_rotational_state + $head_rotational_increment
	if $head_rotational_state > 0.5
		$head_rotational_state = 0.5
	if $head_rotational_state < -0.5
		$head_rotational_state = -0.5
	output_number("head_rotate", 0, $head_rotational_state)

	; Head attach/detach
	var $pilot_attach = input_number(11, 8)
	if $pilot_attach == 1
		output_number("head_attach", 0, 1)
	var $pilot_detach = input_number(11, 9)
	if $pilot_detach == 1
		output_number("head_attach", 0, 0)
