extends MeshInstance3D

func change_color(is_pressed:bool)-> void:
	var material = get_active_material(0)
	var color : Color
	
	if not is_pressed:
		color = Color.CORAL
	else:
		color = Color.CHARTREUSE
	
	material.albedo_color =  color
