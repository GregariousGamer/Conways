extends ColorRect

var block_id: int

func _ready() -> void:
	block_id = get_instance_id()
	SignalManager.new_box_spawn.emit(block_id)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# catches event that happens inside Area2D which is left mouse click
	if (event is InputEventMouseButton 
	&& event.pressed):
		SignalManager.change_color.emit(block_id)
