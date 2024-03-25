extends Node2D

var baum_array = []
var max_baeume = 20
var initial_baeume = 2
var tile_groesse = 64
var spielfeld_groesse_breite = 30
var spielfeld_groesse_länge = 17
var baum_szene = preload("res://tree.tscn")
var versuche_pro_baum = 50

func _ready():
	randomize()
	initial_baeume_spawnen()
	set_process(true)

func initial_baeume_spawnen():
	for i in range(initial_baeume):
		baum_spawnen(false)

func baum_spawnen(close: bool):
	var baum_position = Vector2()
	var platzierungs_versuche = 0
	
	while platzierungs_versuche < versuche_pro_baum:
		if close and baum_array.size() >= 2:
			var start_baum = baum_array[randi() % baum_array.size()]
			var richtung = Vector2(randf_range(-4.0, 4.0), randf_range(-4.0, 4.0)).normalized()
			baum_position = start_baum.global_position + richtung * tile_groesse
		else:
			baum_position = Vector2(randi_range(0, spielfeld_groesse_breite - 1), randi_range(0, spielfeld_groesse_länge - 1)) * tile_groesse
		
		baum_position.x = clamp(baum_position.x, 0, spielfeld_groesse_breite * tile_groesse - tile_groesse)
		baum_position.y = clamp(baum_position.y, 0, spielfeld_groesse_länge * tile_groesse - tile_groesse)
		
		if not is_position_occupied(baum_position):
			var baum = baum_szene.instantiate()
			baum.global_position = baum_position
			add_child(baum)
			baum_array.append(baum)
			return
		platzierungs_versuche += 1

func _process(delta):
	if baum_array.size() < max_baeume and randf() > 0.99:
		baum_spawnen(baum_array.size() >= 2)
				
func is_position_occupied(position):
	for baum in baum_array:
		if baum.global_position.distance_to(position) < tile_groesse:
			return true
	return false
