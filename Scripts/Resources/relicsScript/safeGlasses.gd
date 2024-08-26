extends Relic

var member_var = 0


func initialize_relic(_owner: RelicUI):
	print("this happens onece when we gain a new relic")
	
	
func activate_relic(_owner: RelicUI):
	print("this happens at specific times based on the Relic. Type property")
	
	
func deactivate_relic(_owner:RelicUI):
	print("de")
	print("deee")


