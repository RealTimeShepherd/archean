
var $cab_rotational_state = 0
var $cab_rotational_increment = 0.0005

var $vertical_state = 0.25 ; 
var $vertical_increment = 0.002

var $head_rotational_state = 0
var $head_rotational_increment = 0.002

update

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
	output_number("cab_rotate", 0, $cab_rotational_state)

	; Vertical movement
	var $pilot_u_d = input_number(11, 3) ; Up and down is space and left Ctrl
	if $pilot_u_d == -1
		$vertical_state = $vertical_state - $vertical_increment
	if $pilot_u_d == 1
		$vertical_state = $vertical_state + $vertical_increment
	if $vertical_state > 0.5
		$vertical_state = 0.5
	if $vertical_state < -0.5
		$vertical_state = -0.5
	output_number("arm_hinge", 0, $vertical_state)
	output_number("head_hinge", 0, $vertical_state)

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
