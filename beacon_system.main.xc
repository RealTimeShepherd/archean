;BeaconNav.main.xc
;Port 11 connected to Dashboard
;Port 10 connected to receive beacon
const $beacon = "beacon" ; Alias for beacon
var $screen = screen("screen", 1) ; Alias for dashboard/screen (channel 0)
var $receive_digit_1 = 1 
var $receive_digit_2 = 0 
var $receive_digit_3 = 0 
var $receive_digit_4 = 1

update
	$screen.blank() ; Clear screen
	$screen.write(10, 10, white, text("Receiving:{}", $receive_digit_1*1000 + $receive_digit_2*100 + $receive_digit_3*10 + $receive_digit_4) ; Write current frequency received

	; Buttons to adjust digits
	$screen.write(70, 0, gray, "^^^^")
	$screen.write(70, 20, gray, "vvvv")
	if $screen.button_rect(70, 2, 75, 9, gray) and $receive_digit_1 < 9 
		$receive_digit_1 = $receive_digit_1 + 1
	if $screen.button_rect(70, 18, 75, 25, gray) and $receive_digit_1 > 1 
		$receive_digit_1 = $receive_digit_1 - 1
	if $screen.button_rect(76, 2, 81, 9, gray) and $receive_digit_2 < 9 
		$receive_digit_2 = $receive_digit_2 + 1
	if $screen.button_rect(76, 18, 81, 25, gray) and $receive_digit_2 > 0 
		$receive_digit_2 = $receive_digit_2 - 1
	if $screen.button_rect(82, 2, 87, 9, gray) and $receive_digit_3 < 9 
		$receive_digit_3 = $receive_digit_3 + 1
	if $screen.button_rect(82, 18, 87, 25, gray) and $receive_digit_3 > 0 
		$receive_digit_3 = $receive_digit_3 - 1
	if $screen.button_rect(88, 2, 93, 9, gray) and $receive_digit_4 < 9 
		$receive_digit_4 = $receive_digit_4 + 1
	if $screen.button_rect(88, 18, 93, 25, gray) and $receive_digit_4 > 0 
		$receive_digit_4 = $receive_digit_4 - 1

	; Set beacon to receive signal
	output_number($beacon, 2, $receive_digit_1*1000 + $receive_digit_2*100 + $receive_digit_3*10 + $receive_digit_4)

	; If beacon is receiving data
	if input_number($beacon, 5) == 1
		; Read values
		var $distance = input_number($beacon, 1)
		var $adjustedDistance = $distance
		var $x = input_number($beacon, 2)
		var $y = input_number($beacon, 3)
		var $z = input_number($beacon, 4)

		; Create adjusted distance to ensure indicators stay within the UI
		var $longitude = sqrt(($x * $distance)*($x * $distance) + ($z * $distance)*($z * $distance))
		if $longitude > $screen.height/4
			$adjustedDistance = $distance * (($screen.height/4)/$longitude)

		; Draw direction indicator xz (horizontal)
		;$screen.draw_line($screen.width/2, $screen.height/2, $screen.width/2 + clamp($x * $distance, -$screen.height/4, $screen.height/4), $screen.height/2 + clamp($z * $distance, -$screen.height/4, $screen.height/4), yellow)
		$screen.draw_line($screen.width/2, $screen.height/2, $screen.width/2 + $x * $adjustedDistance, $screen.height/2 + $z * $adjustedDistance, yellow)
		$screen.draw_circle($screen.width/2, $screen.height/2, 4, blue)
		$screen.draw_circle($screen.width/2 + $x * $adjustedDistance, $screen.height/2 + $z * $adjustedDistance, 4, red)

		; Draw direction indicator y (vertical)
		$screen.draw_line(15, $screen.height/2, 15, $screen.height/2 - clamp($y * $distance, -$screen.height/4, $screen.height/4), yellow)
		$screen.draw_circle(15, $screen.height/2, 4, blue)
		$screen.draw_circle(15, $screen.height/2 - clamp($y * $distance, -$screen.height/4, $screen.height/4), 4, red)

		; Draw circle and rect to show indicator ranges
		$screen.draw_circle($screen.width/2, $screen.height/2, $screen.height/4, white)
		$screen.draw_rect(10, $screen.height/4, 21, $screen.height - $screen.height/4, white)

		; Output text
		$screen.write(10, $screen.height - 20, gray, text("Distance:{}", $distance)
		$screen.write(10, $screen.height - 10, gray, text("Message:{}", input_text($beacon, 0))
