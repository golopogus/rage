class_name segment
extends Node2D

var point_a = Vector2()
var point_b = Vector2()
var length = 0
var parent = null
var child = null
var col = Vector3()
var anchor = null
var max_length
var pp1 = Vector2()
var pp2 = Vector2()

func _init(a,b,l) -> void:
	point_a = a
	point_b = b
	length = l


func calc_points_foot_2_groin():
	
	var dir 
	if parent != null:
		point_b = parent.point_a
	else:
		var mouse_pos = get_global_mouse_position()
		if (mouse_pos - anchor).length() <= max_length:
			point_b = get_global_mouse_position()
		else:
			var mouse_dir = (mouse_pos - anchor).normalized()
			point_b = mouse_dir * max_length
	
	if child != null:
		dir = (child.point_b - point_b).normalized()
	else:
		dir = (anchor - point_b).normalized()
	
	point_a = point_b + dir * length
	if child != null:
		check_bend_angle()	
	
		
func calc_points_groin_2_foot():
	
	var dir
	if child != null:
		point_a = child.point_b
	else: 
		point_a = anchor
	
	if parent != null:
		dir = (parent.point_a - point_a).normalized()
	else:
		dir = (get_global_mouse_position() - point_a).normalized()

	point_b = point_a + length * dir
	
	if parent != null:
		check_bend_angle_start()

	
func check_bend_angle():
	
	var start = point_b
	var vertex = (point_a - start).normalized()
	var end = (child.point_a - start).normalized()
	var end_angle = atan2(end.y,-end.x) + PI
	var vertex_angle = atan2(vertex.y,-vertex.x) + PI
	var transformed_end_angle = end_angle - vertex_angle
	if transformed_end_angle < 0:
		transformed_end_angle += 2*PI
	#if sin(transformed_end_angle) < 0:
		#
	#
		#var new_vertex_angle = transformed_end_angle + end_angle
		#
		#var new_vertex_vector = Vector2(cos(new_vertex_angle),sin(new_vertex_angle))
		#
		#pp1 = point_a
		#point_a = start + new_vertex_vector * length
		#pp2 = point_a
		
	
#
func check_bend_angle_start():
	
	var start = point_a
	var vertex = (point_b - start).normalized()
	var end = (parent.point_b - start).normalized()
	var end_angle = atan2(end.y,-end.x) + PI
	var vertex_angle = atan2(vertex.y,-vertex.x) + PI
	var transformed_end_angle = end_angle - vertex_angle
	if transformed_end_angle < 0:
		transformed_end_angle += 2*PI
	if sin(transformed_end_angle) > 0:
		#print(sin(transformed_end_angle))
		var new_vertex_angle = transformed_end_angle + end_angle
		
	
		#
		var new_vertex_vector = Vector2(cos(new_vertex_angle),sin(new_vertex_angle))
		print(new_vertex_vector)
		#
		#point_b = start + new_vertex_vector * length
	
		
func _process(delta: float) -> void:
	
	queue_redraw()
	
func _draw() -> void:
	
	draw_line(point_a,point_b,Color(col.x,col.y,col.z),20.0)

	draw_line(pp1,pp2,Color(1,1,0),10)
	
	
	


		
		
