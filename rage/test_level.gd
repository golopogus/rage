extends Node2D

var s1: segment
var right_leg: leg
var left_leg: leg
var current: segment
var first: segment
var num_segments = 3
var start = false

func _ready() -> void:
	
	left_leg = leg.new(2,Vector2(),100,'left_click')
	$legs.add_child(left_leg)
	
	right_leg = leg.new(2,Vector2(),100,'right_click')
	$legs.add_child(right_leg)
	
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("left_click"):
		left_leg.active(right_leg.foot.point_b)
		right_leg.passive(left_leg.groin.point_a)
		pass
	
	if Input.is_action_pressed("right_click"):
		right_leg.active(left_leg.foot.point_b)
		left_leg.passive(right_leg.groin.point_a)
		pass
		
	
	
	

	
