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
	$Area2D/CollisionPolygon2D.polygon = candidate
	$StaticBody2D/CollisionPolygon2D.polygon = candidate



func _ready():
	connect("redraw", on_redraw)
	generateShape()
	print('added')
	var pp = material.get("shader_parameter/flash")
	print("shader_param: %s" % pp)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

signal redraw

func on_redraw():
	print("actual redraw")
	generateShape()

var collide_is_active:bool = false

func _on_character_collid() -> void:
	print(collide_is_active)
	var color = Vector4(
		rng.randf_range(0, 1),
		rng.randf_range(0, 1),
		rng.randf_range(0, 1),
		1.0
	)
	material.set_deferred("shader_parameter/flash", color)
	if collide_is_active:
		return
	collide_is_active = true
	var pp = material.get("shader_parameter/flash")
	print("shader_param: %s" % pp)
	# material.set("shader_parameter/flash", rng.randf_range(0.0, 1.0))

	#material.changed.emit()
	print(material.get_property_list())
	await get_tree().create_timer(2).timeout
	generateShape()
	collide_is_active = false
