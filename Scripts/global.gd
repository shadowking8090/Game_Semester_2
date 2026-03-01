extends Node

signal bullet_parried(hitbox)
signal player_hit(hitbox)


var player_immortality := false
var player_position
var bullet_speed = 400
var player_entered = false

func frame_freeze(duration):
	Engine.time_scale = 0
	await(get_tree().create_timer(duration, true, false, true).timeout)
	Engine.time_scale = 1
	
