extends Control

@export var dimension : Vector2:
	set(_dimension):
		dimension.x = clamp(_dimension.x, 40, 1000)
		dimension.y = clamp(_dimension.y, 40, 1000)
		await RenderingServer.frame_post_draw
		var screensize : Vector2 = get_viewport().get_visible_rect().size
		print(screensize)
		$Top.size.y = (screensize.y - dimension.y) / 2
		$Bottom.position.y = screensize.y - $Top.size.y
		$Bottom.size.y = $Top.size.y
		$Left.size.x = (screensize.x - dimension.x) / 2
		$Right.position.x = screensize.x - $Left.size.x
		$Right.size.x = $Left.size.x
		


func _ready():
	get_tree().root.connect("size_changed", func(): dimension = dimension)
