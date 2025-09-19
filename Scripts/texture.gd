extends TextureRect

@export var cam_size: Vector2 = Vector2(256, 256)

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func get_warp_bounds() -> Rect2:
	return Rect2(global_position, size)
