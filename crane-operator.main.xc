
var $horizontal_state = 0 ; 0 is fully extended and 1 is fully retracted
var $horizontal_increment = 0.01

var $cab_rotational_state = 0
var $cab_rotational_increment = 0.01

var $vertical_state = 1 ; 0 is fully extended and 1 is fully retracted
var $vertical_increment = 0.01

var $head_rotational_state = 0
var $head_rotational_increment = 0.01

update

	; Horizontal movement
	var $pilot_w_s = input_number(11, 1)
	if $pilot_w_s == 1
		$horizontal_state = $horizontal_state - $horizontal_increment
	if $pilot_w_s == -1
		$horizontal_state = $horizontal_state + $horizontal_increment
	if $horizontal_state > 1
		$horizontal_state = 1
	if $horizontal_state < 0
		$horizontal_state = 0
	output_number("horizontal_movement", 0, $horizontal_state)

	; Cab rotation
	var $pilot_a_d = input_number(11, 2)
	if $pilot_a_d == 1
		$cab_rotational_state = $cab_rotational_state - $cab_rotational_increment
	if $pilot_a_d == -1
		$cab_rotational_state = $cab_rotational_state + $cab_rotational_increment
	if $cab_rotational_state > 0.1
		$cab_rotational_state = 0.1
	if $cab_rotational_state < -0.1
		$cab_rotational_state = -0.1
	output_number(10, 0, $cab_rotational_state)

	; Vertical movement
	var $pilot_u_d = input_number(11, 3) ; Up and down is space and left Ctrl
	if $pilot_u_d == -1
		$vertical_state = $vertical_state - $horizontal_increment
	if $pilot_u_d == 1
		$vertical_state = $vertical_state + $horizontal_increment
	if $vertical_state > 1
		$vertical_state = 1
	if $vertical_state < 0
		$vertical_state = 0
	output_number("vertical_movement", 0, $vertical_state)

	; Cab rotation
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
