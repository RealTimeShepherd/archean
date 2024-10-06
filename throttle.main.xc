var $screen1 = screen("screen", 5)
var $menuSelected = 0
var $text2 = "Speed"
var $alias:text
var $alias2:text
var $value = 0.00
var $menuHeight = 15
var $gaugeoriginx = 0
var $gaugeoriginy = 0

function @Menu()
	;First Menu
	$gaugeoriginx = 0
	$gaugeoriginy = 0
	var $width = 0
	repeat 21 ($i)
		if $menuSelected == $i
			if $screen1.button_rect($width,$gaugeoriginy,$width+$screen1.width/21,$screen1.height/2, red)
				$menuselected = $i
		else
			if $screen1.button_rect($width,$gaugeoriginy,$width+$screen1.width/21,$screen1.height/2, gray)
				$menuselected = $i
		$width += $screen1.width/21

function @MenuDisplay($a:number, $b:text, $c:text)
	$screen1.write(0,19,white, $text2))
	$screen1.write(35,19,white, $value:text))
	output_number($alias, 0, $value*-1)
	output_number($alias2, 0, $value)

update
	$screen1.blank()
	@Menu()
	$text2 = "Speed: "
	$alias = "PropLeft"
	$alias2 = "PropRight"
	repeat 21 ($i)
		if $menuSelected == $i
			$value = $i/20
			@MenuDisplay($value, $text2, $alias)
