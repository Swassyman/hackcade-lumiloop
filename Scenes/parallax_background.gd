extends ParallaxBackground

@onready var speed: int = 50

func _physics_process(delta):
	scroll_offset.x = round(scroll_offset.x - speed * delta)
