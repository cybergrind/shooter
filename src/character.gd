extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

var movements = ['ui_up', 'ui_down', 'ui_right', 'ui_left']
var currentRotation = 0

func setRotation(speed: float =0):
	var inputDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#print("Direction: %s" % inputDirection)
	velocity = inputDirection * speed

func _process(_delta):
	var moving = movements.any(Input.is_action_pressed)
	if moving:
		_animated_sprite.play("default")
		setRotation(500)
	else:
		setRotation(0)
		_animated_sprite.stop()
	# rotation = get_global_mouse_position().angle_to_point(position)
	# _animated_sprite.look_at(get_global_mouse_position())
	look_at(get_global_mouse_position())
	move_and_slide()


signal wall_collide

func _on_area_2d_area_entered(area: Area2D) -> void:
	print('collided')
	wall_collide.emit()
	
