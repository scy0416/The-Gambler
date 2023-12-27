extends Control

@onready var descriptionScene = preload("res://Description/DescriptionTest/DescriptionPanel.tscn")

@export var text:String

var description

func mouse_in():
	description = descriptionScene.instantiate()
	description.set_text(text)
	add_child(description)

func mouse_out():
	description.queue_free()
