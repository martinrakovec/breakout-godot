extends Area2D

@export var speed = 400 # pixel/sec
var screen_size
var ball_count

signal fire

func start(pos):
	position = pos
	ball_count = 1
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	ball_count = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("fire"):
		if ball_count > 0:
			fire.emit()
			ball_count -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity*delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D) -> void:
	ball_count += 1
