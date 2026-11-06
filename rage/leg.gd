class_name leg 
extends Node2D

var s1: segment
var s2: segment

var current: segment
var foot: segment
var num_segments
var total_leg_length = 100
var anchor



func _init(num,groin,leg_length) -> void:
	num_segments = num
	anchor = groin
	total_leg_length = leg_length
	

func _ready() -> void:
	foot = segment.new(Vector2((num_segments - 1) * (total_leg_length/num_segments),0) + anchor,Vector2(num_segments * (total_leg_length/num_segments),0) + anchor,(total_leg_length/num_segments))
	foot.anchor = anchor
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
			next.anchor = anchor
		
	
			
func _process(delta: float) -> void:
	
	var knee_vector = (get_child(1).point_b - anchor).normalized()
	var foot_vector = (get_child(0).point_b - anchor).normalized()
	var foot_angle = atan2(foot_vector.y,-foot_vector.x) + PI
	var knee_angle = atan2(knee_vector.y,-knee_vector.x) + PI
	var transformed_foot_angle = foot_angle - knee_angle
	if transformed_foot_angle < 0:
		transformed_foot_angle += 2*PI
	var transformed_foot_vector = Vector2(cos(transformed_foot_angle),sin(transformed_foot_angle))
	
	
	
	
	
	
	var seg_2_foot = current
	var seg_2_groin = foot
	while seg_2_groin != null:
		seg_2_groin.calc_points_foot_2_groin()
		seg_2_groin = seg_2_groin.child
	while seg_2_foot != null:
		seg_2_foot.calc_points_groin_2_foot()
		seg_2_foot = seg_2_foot.parent
		
	
	if Input.is_action_pressed("left_click"):
		print(sin(transformed_foot_angle))
	
