extends TextureButton

var save : Array = []


func _on_FuncButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Global.curFunc = self
		if Global.curFunc == self:
			disabled = true
		print(Global.curFunc)
	else:
		disabled = false
