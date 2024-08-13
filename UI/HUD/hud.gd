extends Control


func _on_one_step_button_pressed() -> void:
	SignalManager.forward_one.emit()


func _on_five_step_button_pressed() -> void:
	SignalManager.forward_five.emit()


func _on_ten_step_button_pressed() -> void:
	SignalManager.forward_ten.emit()
