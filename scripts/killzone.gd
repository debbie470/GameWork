extends Area2D

@onready var spawn_point: Marker2D = get_parent().get_node("SpawnPoint")
@onready var game_manager: Node = %GameManager

signal died

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.global_position = spawn_point.global_position
		body.velocity = Vector2.ZERO
		
		# Reset Points
		game_manager.reset()
		died.emit()
		
