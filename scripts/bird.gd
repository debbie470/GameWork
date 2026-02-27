extends Node2D  # instead of Node

var speed = 200  # pixels per second
var direction = Vector2(1, 0)  # moving right

func _process(delta):
	position += direction * speed * delta
	
	# Reset position when off-screen (optional)
	if position.x > 1200:  # adjust to your screen width
		position.x = -100
