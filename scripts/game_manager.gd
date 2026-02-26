extends Node
@onready var points_label: Label = %PointsLabel
var points = 0

func  add_point():
	points += 1
	print(points)
	points_label.text = "Points:     " + str(points)

func reset():
	points = 0
	points_label.text = "Points:     " + str(points)
