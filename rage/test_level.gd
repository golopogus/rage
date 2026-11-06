extends Node2D

var s1: segment
var s2: segment
var s3: segment
var current: segment
var first: segment
var num_segments = 3
var start = false

func _ready() -> void:
	
	var left_leg = leg.new(2,Vector2(),500)
	$legs.add_child(left_leg)
	#first = segment.new(Vector2((num_segments - 1) * 50,0),Vector2(num_segments * 50,0),50)
	#first.anchor = Vector2()
	#var max_length = 50
	#current = first
	#$points.add_child(current)
	#for i in num_segments:
		#var next = segment.new(Vector2(current.point_a.x - 50,0),Vector2(current.point_a.x,0), 50)
		#max_length += 50
		#current.child = next
		#next.parent = current
		#
		#current = next
		#
		#$points.add_child(next)
		#if i == num_segments - 1:
			#next.anchor = next.point_a
		#first.max_length = max_length
		


#func _process(delta: float) -> void:
	#
	#
	#var seg_2_parent = current
	#var seg_2_child = first
	#while seg_2_child != null:
		##print(str(seg_2_child.name) + '  point A = ' + str(seg_2_child.point_a) + ', point B = ' + str(seg_2_child.point_b) )
		#seg_2_child.calc_points_end_2_start()
		#seg_2_child = seg_2_child.child
	#while seg_2_parent != null:
		#seg_2_parent.calc_points_start_2_end()
		#seg_2_parent = seg_2_parent.parent
	

	
