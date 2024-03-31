@tool
extends EditorPlugin

var gameData = GameData.new()
var a = preload("res://addons/mydock/my_dock.tscn")
var b
var dock_ui = a.instantiate()

var textEdits : Array
var labelArr
var textArr
var aa
var tData = tempData.new()

func _enter_tree():
	# Load the dock UI scene
	# Add the dock to the editor interface
	ResourceSaver.save(tData, "res://tempResource.tres")
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock_ui)

func _handles(object):
	for i in dock_ui.get_children():
		dock_ui.remove_child(i)
		i.queue_free()

	if(object is Node):
		if(object.get_groups() == [&"Player"]):
			var labels : Array
			labelArr = ["TYPE", "NAME", "HP", "ATK", "RNG", "HAND", "TARBEL", "DESCRIPTION"]
			var tData = ResourceLoader.load("res://tempResource.tres")
			textArr = tData.pArray
			for i in 8 : 
				var label = Label.new()
				label.set_text(labelArr[i])
				label.set_position(Vector2(0, i * 100))
				labels.push_back(label)
				
				var text = TextEdit.new()
				text.set_text(textArr[i])
				text.set_position(Vector2(0, 30))
				text.set_size(Vector2(100, 30))
				if(i == 7):
					text.set_size(Vector2(150, 100))
				text.connect("text_changed", textChanged.bind(text, i, object.get_groups()))
				textEdits.push_back(text)	
				labels[i].add_child(text)
				
				dock_ui.add_child(labels[i])
			
		if(object.get_groups() == [&"Enemy"]):
			var labels : Array
			labelArr = ["TYPE", "NAME", "HP", "ATK", "DEF", "RNG", "TARBEL", "SIGHT", "LONG/SHORT", "DESCRIPTION"]
			var tData = ResourceLoader.load("res://tempResource.tres")
			textArr = tData.eArray
			for i in 10: 
				var label = Label.new()
				label.set_text(labelArr[i])
				label.set_position(Vector2(0, i * 100))
				labels.push_back(label)
				
				var text = TextEdit.new()
				text.set_text(textArr[i])
				text.set_position(Vector2(0, 30))
				text.set_size(Vector2(100, 30))
				if(i == 9):
					text.set_size(Vector2(150, 100))
				text.connect("text_changed", textChanged.bind(text, i, object.get_groups()))
				textEdits.push_back(text)	
				labels[i].add_child(text)
				
				dock_ui.add_child(labels[i])

func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the dock.
	remove_control_from_docks(dock_ui)
	# Erase the control from the memory.
	dock_ui.free()

func textChanged(text, i, group):
	if(group == [&"Enemy"]):
		tData.eArray[i] = text.get_text()
		ResourceSaver.save(tData, "res://tempResource.tres")
	if(group == [&"Player"]):
		tData.pArray[i] = text.get_text()
		ResourceSaver.save(tData, "res://tempResource.tres")
