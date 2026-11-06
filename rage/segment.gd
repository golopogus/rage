class_name segment
extends Node2D

var point_a = Vector2()
var point_b = Vector2()
var length = 0
var parent = null
var child = null
var col = Vector3()
var foot_anchor = Vector2()
var groin_anchor = Vector2()
var max_length


func _init(a,b,l) -> void:
	point_a = a
	point_b = b
	length = l


func calc_points_foot_2_groin(xx):
	
	var dir 
	if parent != null:
		point_b = parent.point_a
	else:
		var mouse_pos = get_global_mouse_position()
		#if (mouse_pos - anchor).length() <= max_length:
			#if mouse_pos.x > anchor.x and mouse_pos.y > anchor.x:
				#point_b = mouse_pos
			
		#else:
			#var mouse_dir = (mouse_pos - anchor).normalized()
			#point_b = mouse_dir * max_length
		if ((mouse_pos - xx).length() <= max_length * 2 and 
		(groin_anchor - xx).length() <= max_length):
			
			point_b = mouse_pos
			foot_anchor = point_b
		
		elif (groin_anchor - xx).length() <= max_length:
			var mouse_dir = (mouse_pos - xx).normalized()
			point_b = mouse_dir * max_length
			foot_anchor = point_b
		else:
			foot_anchor = point_b
			
			
	
	if child != null:
		dir = (child.point_b - point_b).normalized()
	else:
		#dir = (anchor - point_b).normalized()
		dir = (point_a - point_b).normalized()
	
	point_a = point_b + dir * length
	if child != null:
		check_bend_angle()	
	
		
func calc_points_groin_2_foot():
	
	var dir
	if child != null:
		point_a = child.point_b
	else: 
		groin_anchor = point_a
		#anchor = point_a
		
		#point_a = anchor
	
	if parent != null:
		dir = (parent.point_a - point_a).normalized()
	else:
		dir = (get_global_mouse_position() - point_a).normalized()

	point_b = point_a + length * dir
	
	#if parent != null:
		#check_bend_angle_start()

func calc_points_groin_2_foot_passive(xx):
	
	var dir
	if child != null:
		point_a = child.point_b
	else: 
		point_a = xx
	
	if parent != null:
		dir = (parent.point_a - point_a).normalized()
	else:
		dir = (groin_anchor - point_a).normalized()

	point_b = point_a + length * dir
	
	#if parent != null:
		#check_bend_angle_start()

func calc_points_foot_2_groin_passive(xx):
	
	var dir 
	if parent != null:
		point_b = parent.point_a
	else:
		point_b = foot_anchor

	
	if child != null:
		dir = (child.point_b - point_b).normalized()
	else:
		#dir = (anchor - point_b).normalized()
		dir = (xx - point_b).normalized()
	
	point_a = point_b + dir * length
	
	if parent != null:
		check_bend_angle_start()
	
func check_bend_angle():
	var start = point_b
	var vertex = (point_a - start).normalized()
	var end = (child.point_a - start).normalized()
	var end_angle = atan2(end.y,end.x)
	var vertex_angle = atan2(vertex.y,vertex.x)
	
	var diff = end_angle - vertex_angle
	

	if sin(diff) > 0:
		
		var new_vertex_angle = diff + end_angle
##
		var new_vertex_vector = Vector2(cos(new_vertex_angle),sin(new_vertex_angle))
	
		##print('knee_angle = ' + str(vertex_angle) + ', foot_angle = ' + str(end_angle) + ', new_vertex_angle = ' + str(new_vertex_angle))
		##print('knee = ' + str(point_b) + ', foot = ' + str(parent.point_b) + ', start = ' + str(point_a) + ' new_knee = ' + str(point_a + new_vertex_vector * length))
		point_a = start + new_vertex_vector * length
		
		
	
#
func check_bend_angle_start():
	
	var start = point_a
	var vertex = (point_b - start).normalized()
	var end = (parent.point_b - start).normalized()
	var end_angle = atan2(end.y,end.x)
	var vertex_angle = atan2(vertex.y,vertex.x)
	
	var diff = end_angle - vertex_angle
	

	if sin(diff) < 0:
		#
		var new_vertex_angle = diff + end_angle
#
		var new_vertex_vector = Vector2(cos(new_vertex_angle),sin(new_vertex_angle))
		#
		#print('knee_angle = ' + str(vertex_angle) + ', foot_angle = ' + str(end_angle) + ', new_vertex_angle = ' + str(new_vertex_angle))
		#print('knee = ' + str(point_b) + ', foot = ' + str(parent.point_b) + ', start = ' + str(point_a) + ' new_knee = ' + str(point_a + new_vertex_vector * length))
		point_b = start + new_vertex_vector * length
	
		
func _process(delta: float) -> void:
	
	queue_redraw()
	
func _draw() -> void:
	
	draw_line(point_a,point_b,Color(col.x,col.y,col.z),2.0)

	
	
	
	


		
		
