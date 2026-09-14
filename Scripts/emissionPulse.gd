extends MeshInstance3D


var emissionMaterial :StandardMaterial3D
var emissionMaterial2 :StandardMaterial3D
@onready var tween = Tween
@onready var tween2 = Tween
func _ready() -> void:
	emissionMaterial = get_active_material(0) 
	emissionMaterial.emission_enabled = true
	emissionMaterial.emission_energy_multiplier = 0.0
	emissionMaterial2 = get_active_material(1) 
	emissionMaterial2.emission_enabled = true
	emissionMaterial2.emission_energy_multiplier = 0.0
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.set_loops()
	tween.tween_property(emissionMaterial,"emission_energy_multiplier",14.0,0.4)
	tween.tween_property(emissionMaterial,"emission_energy_multiplier",0.0,0.4)
	
	tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_CUBIC)
	tween2.set_ease(Tween.EASE_IN)
	tween2.set_loops()
	tween2.tween_property(emissionMaterial2,"emission_energy_multiplier",14.0,0.4)
	tween2.tween_property(emissionMaterial2,"emission_energy_multiplier",0.0,0.4)
	
