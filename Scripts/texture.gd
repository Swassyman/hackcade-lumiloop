extends TextureRect

@export var cam_size: Vector2 = Vector2(256, 256)

var player: CharacterBody2D
var is_locked = false
var lock_pos: Vector2

func _ready() -> void:
	player = get_node("../Player")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("lock"):
		toggle_lock()
		
	var pivot_pos = player.global_position
	
	if not is_locked and player:
		global_position = pivot_pos - size / 2
	elif is_locked:
		global_position = lock_pos

func toggle_lock():
	is_locked = !is_locked
	
	if is_locked:
		lock_pos = global_position
		
func get_warp_bounds() -> Rect2:
	return Rect2(global_position, size)
