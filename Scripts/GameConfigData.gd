extends Resource
class_name GameConfigData

enum Speed{SLOW, NORMAL, FAST}
enum Effect{LESS, NORMAL, MANY}

@export var masterVolume:int

@export var backgroundVolume:int

@export var animationSpeed:Speed

@export var visualEffect:Effect

@export var soundEffect:int
