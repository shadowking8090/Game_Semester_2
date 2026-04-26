extends Control

@onready var end_screen: Control = $"."
@onready var container: Node2D = $"../Container"

func _on_replay_button_pressed() -> void:
	end_screen.visible = false
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_menu_button_pressed() -> void:
	end_screen.visible = false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
