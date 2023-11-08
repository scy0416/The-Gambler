#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.11.08
# 최종 변경일: 2023.11.08
# 목적: 옵션창에 대한 처리를 담당하는 스크립트
# 개정 이력: 송찬영, 2023.11.08, 데이터 동기화, 변경 적용, 저장 기능, 초기화 구현
#========================================
extends Control

var gameConfigData = GameManager.gameConfigData
@onready var videoEffect = $"MarginContainer/VBoxContainer/OptionContainer/비디오/VBoxContainer/Video/VBoxContainer/VideoEffect/VideoEffectOption"
@onready var animationSpeed = $"MarginContainer/VBoxContainer/OptionContainer/비디오/VBoxContainer/Video/VBoxContainer/AnimationSpeed/AnimationSpeedOption"
@onready var masterVolumeSlider = $"MarginContainer/VBoxContainer/OptionContainer/사운드/VBoxContainer/Sound/VBoxContainer/MasterVolume/HSlider"
@onready var masterVolumeSpinBox = $"MarginContainer/VBoxContainer/OptionContainer/사운드/VBoxContainer/Sound/VBoxContainer/MasterVolume/SpinBox"
@onready var backgroundVolumeSlider = $"MarginContainer/VBoxContainer/OptionContainer/사운드/VBoxContainer/Sound/VBoxContainer/BackgroundVolume/HSlider"
@onready var backgroundVolumeSpinBox = $"MarginContainer/VBoxContainer/OptionContainer/사운드/VBoxContainer/Sound/VBoxContainer/BackgroundVolume/SpinBox"
@onready var soundEffectSlider = $"MarginContainer/VBoxContainer/OptionContainer/사운드/VBoxContainer/Sound/VBoxContainer/SoundEffect/HSlider"
@onready var soundEffectSpinBox = $"MarginContainer/VBoxContainer/OptionContainer/사운드/VBoxContainer/Sound/VBoxContainer/SoundEffect/SpinBox"


#========================================
# 목적: 게임이 시작됨과 동시에 로드되어있는 환경 설정 파일과 동기화 하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func _ready():
	SyncData()


#========================================
# 목적: 옵션창을 비활성화 하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func CloseOption():
	visible = false


#========================================
# 목적: 환경 설정 정보와 화면을 동기화 시키는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func SyncData():
	videoEffect.selected = gameConfigData.visualEffect
	
	animationSpeed.selected = gameConfigData.animationSpeed
	
	masterVolumeSlider.value = gameConfigData.masterVolume
	masterVolumeSpinBox.value = gameConfigData.masterVolume
	
	backgroundVolumeSlider.value = gameConfigData.backgroundVolume
	backgroundVolumeSpinBox.value = gameConfigData.backgroundVolume
	
	soundEffectSlider.value = gameConfigData.soundEffect
	soundEffectSpinBox.value = gameConfigData.soundEffect


#========================================
# 목적: 슬라이더가 변경되면 스핀박스를 슬라이더와 동기화 시키는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func sliderValueChange(value):
	masterVolumeSpinBox.value = masterVolumeSlider.value
	backgroundVolumeSpinBox.value = backgroundVolumeSlider.value
	soundEffectSpinBox.value = soundEffectSlider.value


#========================================
# 목적: 스핀박스가 변경되면 슬라이더를 동기화 시키는 메소드
# 매개변수: value: 그냥 시그널 연결을 해야해서 넣은 매개변수
# 반환값: 없음
#========================================
func spinBoxValueChange(value):
	masterVolumeSlider.value = masterVolumeSpinBox.value
	backgroundVolumeSlider.value = backgroundVolumeSpinBox.value
	soundEffectSlider.value = soundEffectSpinBox.value


#========================================
# 목적: 설정한 환경설정값을 저장시키는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func SaveConfigData():
	gameConfigData.visualEffect = videoEffect.selected
	gameConfigData.animationSpeed = animationSpeed.selected
	gameConfigData.masterVolume = masterVolumeSlider.value
	gameConfigData.backgroundVolume = backgroundVolumeSlider.value
	gameConfigData.soundEffect = soundEffectSlider.value
	
	GameManager.saveConfigData()


#========================================
# 목적: 환경 설정 값을 기본값으로 초기화시키는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func resetConfigData():
	GameManager.gameConfigData = GameConfigData.new()
	gameConfigData = GameManager.gameConfigData
	GameManager.saveConfigData()
	SyncData()
