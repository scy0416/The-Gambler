extends Control


@export_enum("일반 적", "엘리트 적", "보스 전투", "이벤트", "휴식", "상점") var type:String:
	set(value):
		type = value
		$ContentLabel.text = value


func flip():
	$AnimationPlayer.play("flip_card")
