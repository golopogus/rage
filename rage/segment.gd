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

func _init(a,b,l) -> void:
	point_a = a
	point_b = b
	length = l


func calc_points_foot_2_groin():
	
	var dir 
	if parent != null:
		point_b = parent.point_a
	else:
		point_b = get_global_mouse_position()
	
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
	#var transformed_end_vector = Vector2(cos(transformed_end_angle),sin(transformed_end_angle))
	if sin(transformed_end_angle) < 0:
		
		print(transformed_end_angle)
		var new_vertex_angle = transformed_end_angle + end_angle
		
		var new_vertex_vector = Vector2(cos(new_vertex_angle),sin(new_vertex_angle))
		
		point_a = start + new_vertex_vector * length
		#child.point_b = point_a
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
	#var transformed_end_vector = Vector2(cos(transformed_end_angle),sin(transformed_end_angle))
	if sin(transformed_end_angle) > 0:
		
		var new_vertex_angle = transformed_end_angle + end_angle
		
		var new_vertex_vector = Vector2(cos(new_vertex_angle),sin(new_vertex_angle))
		
		point_b = start + new_vertex_vector * length
		
		#parent.point_a = point_b
	
		
		
		

#func set_point_b():
	#
		#if parent != null:
			#point_b = parent.point_a
		#else:
			#point_b = get_global_mouse_position()
			
#func calculate_points():
	#
	#set_point_a()
	#var dir = (parent.point_a - point_a).normalized()
	#point_b = point_a + length * dir
#
#func set_point_a():
	#
	#if child != null:
		#point_a = child.point_b
	#else: 
		#point_a = anchor
#
#func reverse_points():
	#
	#set_point_b()
	#var dir = (child.point_b - point_b).normalized()
	#point_a = point_b + length * dir
#
#
#func set_point_b():
	#if parent != null:
		#point_b = parent.point_a
	#else:
		#var mouse_pos = get_global_mouse_position()
		#var distance = (anchor - mouse_pos).length()
		#if distance < max_length:
			#point_b = get_global_mouse_position()
	
		
func _process(delta: float) -> void:
	
	queue_redraw()
	
func _draw() -> void:
	
	#if child == null:
		#draw_line(anchor,point_b,Color(1,0,0),2.0)
	#elif parent == null:
		#draw_line(anchor,point_b,Color(0,2,0),2.0)
	draw_line(point_a,point_b,Color(col.x,col.y,col.z),2.0)


	
	
	


		
		
