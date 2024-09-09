extends CanvasLayer

class_name UI

@onready var label = %Label
@onready var label2 = %LevelLabel
#@onready var button = %Button
@onready var game_lost_container = %GameLostContainer
@onready var level_won_container = %LevelWonContainer

var game_paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		game_paused = !game_paused
	if game_paused:
		get_tree().paused = true
		$MarginContainer/PauseMenu.show()
	else:
		get_tree().paused = false
		$MarginContainer/PauseMenu.hide()

func set_lifes(lifes: int):
	label.text = "Lifes: %d" % lifes

func set_level(level: int):
	print_debug('level:', level)
	print_debug('До:', label2.text)
	label2.text = "Level: %d" % level
	print_debug('После', label2.text)

func game_over():
	game_lost_container.show()
	
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_exit_button_lose_pressed() -> void:
	game_paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

func on_level_won():
	level_won_container.show()


func _on_next_level_button_pressed() -> void:
	match LevelDefinitions.current_level:
		1:
			LevelDefinitions.current_level = 2
			set_level(2)
			get_tree().reload_current_scene()
		2:
			LevelDefinitions.current_level = 3
			set_level(3)
			get_tree().reload_current_scene()
		3: 
			get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
	

func _on_exit_button_win_pressed() -> void:
	game_paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

	
func _on_continue_button_pressed() -> void:
	game_paused = false


func _on_exit_button_pressed() -> void:
	game_paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
