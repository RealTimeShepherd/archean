
var $horizontal_state = 0 ; 0 is fully extended and 1 is fully retracted
var $horizontal_increment = 0.01

update

	; Horizontal movement
	var $pilot_w_s = input_number(11, 1)

	if $pilot_w_s == 1
		$horizontal_state = $horizontal_state - $horizontal_increment
	if $pilot_w_s == -1
		$horizontal_state = $horizontal_state 1 $horizontal_increment
	if $horizontal_state > 1
		$horizontal_state = 1
	if $horizontal_state < 0
		$horizontal_state = 0

	output_number("horizontal_movement", 0, $horizontal_state)
