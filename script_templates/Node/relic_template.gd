# meta-name: Relic
# meta-description: Create a Rekuc which can be acquired by the player.
extends Relic

var member_var := 0


func initialize_relic(_owner: RelicUI) -> void:
	print("this happens onece when we gain a new relic")
	
	
func activate_relic(_owner: RelicUI) -> void:
	print("this happens at specific times based on the Relic. Type property")
	
	
func deactivate_relic(_owner:RelicUI) -> void:
	print("de")
	print("deee")

