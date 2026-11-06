class_name leg 
extends Node2D

var s1: segment
var s2: segment

var current: segment
var foot: segment
var num_segments
var total_leg_length
var anchor
var input
var groin: segment



func _init(num,groin,leg_length,inp) -> void:
	num_segments = num
	anchor = groin
	total_leg_length = leg_length
	input = inp
	

func _ready() -> void:
	foot = segment.new(Vector2((num_segments - 1) * (total_leg_length/num_segments),0) + anchor,Vector2(num_segments * (total_leg_length/num_segments),0) + anchor,(total_leg_length/num_segments))
	foot.groin_anchor = anchor
	foot.max_length = total_leg_length
	current = foot
	add_child(current)
	for i in num_segments - 1:
		var next = segment.new(Vector2(current.point_a.x - (total_leg_length/num_segments),0) + anchor,Vector2(current.point_a.x,0) + anchor, (total_leg_length/num_segments))
		current.child = next
		next.parent = current
		current = next
		add_child(next)
		if i == num_segments - 2:
			next.groin_anchor = anchor
			groin = next
			
		
	
			
func _process(delta: float) -> void:
	
	pass
	#if Input.is_action_pressed(input):
		#var seg_2_foot = current
		#var seg_2_groin = foot
		#while seg_2_groin != null:
			#seg_2_groin.calc_points_foot_2_groin()
			#seg_2_groin = seg_2_groin.child
		#while seg_2_foot != null:
			#seg_2_foot.calc_points_groin_2_foot()
			#seg_2_foot = seg_2_foot.parent
	
	
func active(pos):
	
	var seg_2_foot = current
	var seg_2_groin = foot
	while seg_2_groin != null:
		seg_2_groin.calc_points_foot_2_groin(pos)
		seg_2_groin = seg_2_groin.child
	while seg_2_foot != null:
		seg_2_foot.calc_points_groin_2_foot()
		seg_2_foot = seg_2_foot.parent

func passive(pos):
	
	var seg_2_foot = current
	var seg_2_groin = foot
	while seg_2_foot != null:
		seg_2_foot.calc_points_groin_2_foot_passive(pos)
		seg_2_foot = seg_2_foot.parent
	while seg_2_groin != null:
		seg_2_groin.calc_points_foot_2_groin_passive(pos)
		seg_2_groin = seg_2_groin.child
