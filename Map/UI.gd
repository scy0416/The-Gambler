extends Control

var mapNodeSize = Vector2.ZERO


func _process(delta):
	mapNodeSize = $ScrollContainer/VBoxContainer/MapLevel1.get_child(0).get_child(0).size
	queue_redraw()


func _draw():
	for level in $ScrollContainer/VBoxContainer.get_children():
		if level.level == 15:
			continue
		
		if level.level == 1:
			#1
			var next_level = level.nextLevel
			var now_level_node_list = level.mapNodeList
			var next_level_node_list = next_level.mapNodeList
			
			var from1 = now_level_node_list[0].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to1_1 = next_level_node_list[0].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to1_2 = next_level_node_list[1].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			
			draw_line(from1, to1_1, Color(255, 255, 255), 5)
			draw_line(from1, to1_2, Color(255, 255, 255), 5)
			
			#3
			var from3 = now_level_node_list[2].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to3_1 = next_level_node_list[1].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to3_2 = next_level_node_list[2].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to3_3 = next_level_node_list[3].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			
			draw_line(from3, to3_1, Color(255, 255, 255), 5)
			draw_line(from3, to3_2, Color(255, 255, 255), 5)
			draw_line(from3, to3_3, Color(255, 255, 255), 5)
			
			#5
			var from5 = now_level_node_list[4].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to5_1 = next_level_node_list[3].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to5_2 = next_level_node_list[4].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to5_3 = next_level_node_list[5].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			
			draw_line(from5, to5_1, Color(255, 255, 255), 5)
			draw_line(from5, to5_2, Color(255, 255, 255), 5)
			draw_line(from5, to5_3, Color(255, 255, 255), 5)
			
			#7
			var from7 = now_level_node_list[6].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to7_1 = next_level_node_list[5].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			var to7_2 = next_level_node_list[6].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
			
			draw_line(from7, to7_1, Color(255, 255, 255), 5)
			draw_line(from7, to7_2, Color(255, 255, 255), 5)
		
		var next_level = level.nextLevel
		var now_level_node_list = level.mapNodeList
		var next_level_node_list = next_level.mapNodeList
		
		#1
		var from1 = now_level_node_list[0].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to1_1 = next_level_node_list[0].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to1_2 = next_level_node_list[1].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		
		draw_line(from1, to1_1, Color(255, 255, 255), 5)
		draw_line(from1, to1_2, Color(255, 255, 255), 5)
		
		#2
		var from2 = now_level_node_list[1].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to2_1 = next_level_node_list[0].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to2_2 = next_level_node_list[1].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to2_3 = next_level_node_list[2].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		
		draw_line(from2, to2_1, Color(255, 255, 255), 5)
		draw_line(from2, to2_2, Color(255, 255, 255), 5)
		draw_line(from2, to2_3, Color(255, 255, 255), 5)
		
		#3
		var from3 = now_level_node_list[2].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to3_1 = next_level_node_list[1].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to3_2 = next_level_node_list[2].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to3_3 = next_level_node_list[3].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		
		draw_line(from3, to3_1, Color(255, 255, 255), 5)
		draw_line(from3, to3_2, Color(255, 255, 255), 5)
		draw_line(from3, to3_3, Color(255, 255, 255), 5)
		
		#4
		var from4 = now_level_node_list[3].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to4_1 = next_level_node_list[2].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to4_2 = next_level_node_list[3].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to4_3 = next_level_node_list[4].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		
		draw_line(from4, to4_1, Color(255, 255, 255), 5)
		draw_line(from4, to4_2, Color(255, 255, 255), 5)
		draw_line(from4, to4_3, Color(255, 255, 255), 5)
		
		#5
		var from5 = now_level_node_list[4].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to5_1 = next_level_node_list[3].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to5_2 = next_level_node_list[4].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to5_3 = next_level_node_list[5].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		
		draw_line(from5, to5_1, Color(255, 255, 255), 5)
		draw_line(from5, to5_2, Color(255, 255, 255), 5)
		draw_line(from5, to5_3, Color(255, 255, 255), 5)
		
		#6
		var from6 = now_level_node_list[5].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to6_1 = next_level_node_list[4].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to6_2 = next_level_node_list[5].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to6_3 = next_level_node_list[6].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		
		draw_line(from6, to6_1, Color(255, 255, 255), 5)
		draw_line(from6, to6_2, Color(255, 255, 255), 5)
		draw_line(from6, to6_3, Color(255, 255, 255), 5)
		
		#7
		var from7 = now_level_node_list[6].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to7_1 = next_level_node_list[5].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		var to7_2 = next_level_node_list[6].global_position + Vector2(mapNodeSize[0]/2,mapNodeSize[1]/2)
		
		draw_line(from7, to7_1, Color(255, 255, 255), 5)
		draw_line(from7, to7_2, Color(255, 255, 255), 5)
