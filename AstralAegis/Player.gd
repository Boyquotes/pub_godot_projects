extends KinematicBody2D

export (int) var speed = 200
var bullet_scene = preload("res://Bullet.tscn")

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("shoot"):
		shoot()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func _ready() -> void:
	pass # Replace with function body.

func shoot():
	print("shooting")
	var bullet = bullet_scene.instance()
	bullet.position = self.position
	bullet.look_at(get_global_mouse_position())
	owner.add_child(bullet)
