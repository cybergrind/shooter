extends Polygon2D

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.

func generateShape():
	var vertices = []
	for i in range(rng.randi_range(4, 4)):
		vertices.append(rng.randi_range(100, 600))
		
	var candidate = PackedVector2Array()
	for i in range(4):
		candidate.append(
			Vector2(vertices[(i + 4) % 4], vertices[(i+5) % 4])
		)
	polygon = candidate
	print(polygon)
	var collision_shape = $Area2D/CollisionPolygon2D
	collision_shape.polygon = polygon
	var body = $Area2D/StaticBody2D
	$Area2D/CollisionPolygon2D.polygon = candidate
	$StaticBody2D/CollisionPolygon2D.polygon = candidate

	

func _ready():
	generateShape()
	print('added')
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_character_collid() -> void:
	generateShape()
