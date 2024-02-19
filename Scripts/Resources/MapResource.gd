extends Resource
class_name MapResource

enum state{CLOSE, OPENED, WAIT}
enum MapState{INTERACTIVE,UNINTERACTIVE}
@export var types:Dictionary = {}
@export var states:Dictionary = {}
@export var map_state:MapState
