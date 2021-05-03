extends Node2D
var save_path_Zbroja= "user://Zbroja.dat"
var start_zborja = {
	0:[0,0,0,0],
	1:[0,0,0,0],
	2:[0,0,0,0],
	3:[0,0,0,0],
	4:[0,0,0,0]
}
var zbroja
func _ready():
	check_save()
	Set_Eq()
	Set_Armor()

func _on_Exit_pressed():
	get_tree().change_scene("res://Main_Statek.tscn")

func save_data():
	var file = File.new()
	var error = file.open(save_path_Zbroja, File.WRITE)
	if error == OK:
		file.store_var(zbroja)
		file.close()
func load_data():
	var file = File.new()
	if file.file_exists(save_path_Zbroja):
		var error = file.open(save_path_Zbroja, File.READ)
		if error == OK:
			zbroja = file.get_var()
			file.close()
func check_save():
	var file = File.new()
	if file.file_exists(save_path_Zbroja):
		var error = file.open(save_path_Zbroja, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_zborja)
			file.close()
	else:
		var error = file.open(save_path_Zbroja, File.WRITE)
		if error == OK:
			file.store_var(start_zborja)
			file.close()
	load_data()
func Set_Eq():
	$Background/Container/Helm/Helm_posiadany.texture_normal = load("res://Zbroja/Helm_"+String(zbroja[0][0])+".png")
	$Background/Container/Klata/Klata_posiadana.texture_normal = load("res://Zbroja/Klata_"+String(zbroja[0][1])+".png")
	$Background/Container/Spodnie/Spodnie_posiadne.texture_normal = load("res://Zbroja/Spodnie_"+String(zbroja[0][2])+".png")
	$Background/Container/Buty/Buty_posiadane.texture_normal = load("res://Zbroja/Buty_"+String(zbroja[0][3])+".png")
func Set_Armor():
	if zbroja[1][0] == 1:
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Helm/Helm_elektryczny.visible = 1
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Helm/Helm_elektryczny.disabled = 0
	if zbroja[1][1] == 1:
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Klata/Klata_elektryczna.visible = 1
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Klata/Klata_elektryczna.disabled = 0
	if zbroja[1][2] == 1:
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Spodnie/Spodnie_elektryczne.visible = 1
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Helm/Helm_elektryczny.disabled = 0
	if zbroja[1][3] == 1:
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Buty/Buty_elektryczne.visible = 1
		$Background/ScrollContainer/VBoxContainer/Elektryczny/Buty/Buty_elektryczne.disabled = 0
	if zbroja[2][0] == 1:
		$Background/ScrollContainer/VBoxContainer/Ogien/Helm/Helm_ogien.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ogien/Helm/Helm_ogien.disabled = 0
	if zbroja[2][1] == 1:
		$Background/ScrollContainer/VBoxContainer/Ogien/Klata/Klata_ogien.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ogien/Klata/Klata_ogien.disabled = 0
	if zbroja[2][2] == 1:
		$Background/ScrollContainer/VBoxContainer/Ogien/Spodnie/Spodnie_ogien.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ogien/Spodnie/Spodnie_ogien.disabled = 0
	if zbroja[2][3] == 1:
		$Background/ScrollContainer/VBoxContainer/Ogien/Buty/Buty_ogien.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ogien/Buty/Buty_ogien.disabled = 0
		
	if zbroja[3][0] == 1:
		$Background/ScrollContainer/VBoxContainer/Woda/Helm/Helm_woda.visible = 1
		$Background/ScrollContainer/VBoxContainer/Woda/Helm/Helm_woda.disabled = 0
	if zbroja[3][1] == 1:
		$Background/ScrollContainer/VBoxContainer/Woda/Klata/Klata_woda.visible = 1
		$Background/ScrollContainer/VBoxContainer/Woda/Klata/Klata_woda.disabled = 0
	if zbroja[3][2] == 1:
		$Background/ScrollContainer/VBoxContainer/Woda/Spodnie/Spodnie_woda.visible = 1
		$Background/ScrollContainer/VBoxContainer/Woda/Spodnie/Spodnie_woda.disabled = 0
	if zbroja[3][3] == 1:
		$Background/ScrollContainer/VBoxContainer/Woda/Buty/Buty_woda.visible = 1
		$Background/ScrollContainer/VBoxContainer/Woda/Buty/Buty_woda.disabled = 0
		
	if zbroja[4][0] == 1:
		$Background/ScrollContainer/VBoxContainer/Ziemia/Helm/Helm_ziemia.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ziemia/Helm/Helm_ziemia.disabled = 0
	if zbroja[4][1] == 1:
		$Background/ScrollContainer/VBoxContainer/Ziemia/Klata/Klata_ziemia.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ziemia/Klata/Klata_ziemia.disabled = 0
	if zbroja[4][2] == 1:
		$Background/ScrollContainer/VBoxContainer/Ziemia/Spodnie/Spodnie_ziemia.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ziemia/Spodnie/Spodnie_ziemia.disabled = 0
	if zbroja[4][3] == 1:
		$Background/ScrollContainer/VBoxContainer/Ziemia/Buty/Buty_ziemia.visible = 1
		$Background/ScrollContainer/VBoxContainer/Ziemia/Buty/Buty_ziemia.disabled = 0	
func _on_Helm_normalny_pressed():
	zbroja[0][0] = 0
	Set_Eq()
	save_data()

func _on_Klata_normanly_pressed():
	zbroja[0][1] = 0
	Set_Eq()
	save_data()

func _on_Spodnie_Normalny_pressed():
	zbroja[0][2] = 0
	Set_Eq()
	save_data()

func _on_Buty_normalny_pressed():
	zbroja[0][3] = 0
	Set_Eq()
	save_data()


func _on_Helm_elektryczny_pressed():
	zbroja[0][0] = 1
	Set_Eq()
	save_data()
func _on_Klata_elektryczna_pressed():
	zbroja[0][1] = 1
	Set_Eq()
	save_data()
	
func _on_Spodnie_elektryczne_pressed():
	zbroja[0][2] = 1
	Set_Eq()
	save_data()

func _on_Buty_elektryczne_pressed():
	zbroja[0][3] = 1
	Set_Eq()
	save_data()

func _on_Helm_ogien_pressed():
	zbroja[0][0] = 2
	Set_Eq()
	save_data()


func _on_Klata_ogien_pressed():
	zbroja[0][1] = 2
	Set_Eq()
	save_data()


func _on_Spodnie_ogien_pressed():
	zbroja[0][2] = 2
	Set_Eq()
	save_data()


func _on_Buty_ogien_pressed():
	zbroja[0][3] = 2
	Set_Eq()
	save_data()


func _on_Helm_woda_pressed():
	zbroja[0][0] = 3
	Set_Eq()
	save_data()


func _on_Klata_woda_pressed():
	zbroja[0][1] = 3
	Set_Eq()
	save_data()


func _on_Spodnie_woda_pressed():
	zbroja[0][2] = 3
	Set_Eq()
	save_data()


func _on_Buty_woda_pressed():
	zbroja[0][3] = 3
	Set_Eq()
	save_data()

func _on_Helm_ziemia_pressed():
	zbroja[0][0] = 4
	Set_Eq()
	save_data()

func _on_Klata_ziemia_pressed():
	zbroja[0][1] = 4
	Set_Eq()
	save_data()

func _on_Spodnie_ziemia_pressed():
	zbroja[0][2] = 4
	Set_Eq()
	save_data()

func _on_Buty_ziemia_pressed():
	zbroja[0][3] = 4
	Set_Eq()
	save_data()
