extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

@onready var sprite = $Sprite
var inner_cam: TextureRect

func _ready():
	inner_cam = get_node("../InnerCamera")
	
func _physics_process(delta: float) -> void:
	handle_input()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite.play("fall")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		sprite.play("jump")
		velocity.y = JUMP_VELOCITY

	move_and_slide()
	handle_warping()
	
	if Input.is_action_just_pressed("pause"):
		$PauseMenu.toggle_pause()
	
func handle_input():
	var horizontal_input = 0.0
	if Input.is_action_pressed("move_left"):
		horizontal_input = -1.0
	elif Input.is_action_pressed("move_right"):
		horizontal_input = 1.0
		
	velocity.x = horizontal_input * SPEED
	
	if sprite:
		if horizontal_input != 0:
			sprite.play("run")
			sprite.flip_h = horizontal_input < 0
		else:
			sprite.play("idle")

func handle_warping():
	if not inner_cam:
		return
	
	var warp_bounds = inner_cam.get_warp_bounds()
	
	if global_position.x < warp_bounds.position.x:
		global_position.x = warp_bounds.position.x + warp_bounds.size.x
	elif global_position.x > warp_bounds.position.x + warp_bounds.size.x:
		global_position.x = warp_bounds.position.x
		
	if global_position.y < warp_bounds.position.y:
		global_position.y = warp_bounds.position.y + warp_bounds.size.y
	elif global_position.y > warp_bounds.position.y + warp_bounds.size.y:
		global_position.y = warp_bounds.position.y
		
func death() -> void:
	call_deferred("_reload_scene")

func _reload_scene() -> void:
	get_tree().reload_current_scene()



func _on_death_zone_body_entered(body: Node2D) -> void:
	if body == self:
		death()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Scenes/titlescreen.tscn")
		


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if not inner_cam:
		return
	
	if body is CharacterBody2D:
		inner_cam.queue_free()
