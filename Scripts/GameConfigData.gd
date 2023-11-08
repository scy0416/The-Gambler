#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.10.10
# 최종 변경일: 2023.11.08
# 목적: 게임의 환경을 설정하는 리소스
# 개정 이력: 송찬영, 2023.10.11, 환경 설정에 필요한 정보들 설정
# 송찬영, 2023.11.08, 기본값 적용
#========================================
extends Resource
class_name GameConfigData

enum Speed{SLOW, NORMAL, FAST}
enum Effect{LESS, NORMAL, MANY}

@export var masterVolume:int = 50

@export var backgroundVolume:int = 50

@export var animationSpeed:Speed = Speed.NORMAL

@export var visualEffect:Effect = Effect.NORMAL

@export var soundEffect:int = 50
