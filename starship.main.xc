var $doors_state = 1
var $doors_point = 1
var $doors_press = 0
var $doors_slice = 0.005

var $legs_state = 1
var $legs_point = 1
var $legs_press = 0
var $legs_slice = 0.005
var $legs_adj_state = 0

update

	; Dash 6 - upper port
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
	output_number("legs", 0, $legs_state)
	if $legs_state == 0
		output_number("dash_port", 4, 1)
	else
		output_number("dash_port", 4, 0)
	if $legs_state == 1
		output_number("dash_port", 5, 1)
	else
		output_number("dash_port", 5, 0)

	; Legs controls
	; var $legs_button = input_number("dash_port", 3)
	; if ($legs_button and !$legs_press)
	; 	$legs_point!!
	; $legs_press = $legs_button
	; if $legs_point > $legs_state
	; 	$legs_state = $legs_state + $legs_slice
	; elseif $legs_point < $legs_state
	; 	$legs_state = $legs_state - $legs_slice
	; if $legs_state <= 0.5
	; 	$legs_adj_state = ($legs_state * 2)
	; 	$legs_adj_state ^= 3
	; 	output_number("legs", 0, ($legs_adj_state * 0.5) * 1)
	; else
	; 	$legs_adj_state = ((1 - $legs_state) * 2)
	; 	$legs_adj_state ^= 3
	; 	output_number("legs", 0, (1 - ($legs_adj_state * 0.5)) * 1)
	; if $legs_state == 1
	; 	output_number("dash_port", 4, 1)
	; else
	; 	output_number("dash_port", 4, 0)
	; if $legs_state == 0
	; 	output_number("dash_port", 5, 1)
	; else
	; 	output_number("dash_port", 5, 0)
	output_number("dash_port", 9, $legs_state)
	output_number("dash_port", 10, $legs_point)

	; Anchors control
	var $anchors_button = input_number("dash_port", 6)
	output_number("anchors", 0, $anchors_button)
	output_number("dash_port", 7, !$anchors_button)
	output_number("dash_port", 8, $anchors_button)
