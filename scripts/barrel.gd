extends CharacterBody2D
@export var speed = 200
var direction = -1  # -1 = left, 1 = right

func _physics_process(delta):
	velocity.x = speed * direction
	move_and_slide()
