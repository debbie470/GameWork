extends Area2D

@onready var spawn_point: Marker2D = get_parent().get_node("SpawnPoint")

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.global_position = spawn_point.global_position
		if body is CharacterBody2D:
			body.velocity = Vector2.ZERO
