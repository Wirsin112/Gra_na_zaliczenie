extends Node2D
var dir = Directory.new()
var save_path = "user://save_walka.dat"
var save_path_Gracz = "user://hp.dat"
var save_path_planet_curent = "user://Planet_curent.dat"
var save_path_Zbroja= "user://Zbroja.dat"
var save_path_is_saved = "user://is_saved.dat"
var Save = 5
var a
var Walka 
var Zbroja
var Curent
var Gracz
var start_set = [100,100,30,30,0]
var koniec = 0
var Mob_attack = 0
var Mob_stun = 0
var Boost = 0
var Atack_click = 0
var Stun_click = 0
var Heal_click = 0
var Boost_click = 0
var atak = RandomNumberGenerator.new()
var heal = RandomNumberGenerator.new()
var mouse_in = 0
const znacznik = preload("res://Znacznik.tscn")
var check_child = 0;
func _ready():
	save_unique(Save,save_path_is_saved)
	load_eq()
	load_hp()
	load_curent()
	check_save()
	Set_background()
	Set_Enemy(Walka[4])
	Set_Zbroja()
	$Gracz/Bar_Gracz_Hp.max_value = Gracz[1]
	$Gracz/Bar_Gracz_Hp.value = Gracz[0]
	$Gracz/Bar_Gracz_Hp/Gracz_Hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
	$Macka/Area2D/Bar_Enemy_Hp.max_value = Walka[3]
	$Macka/Area2D/Bar_Enemy_Hp.value = Walka[2]
	$Macka/Area2D/Bar_Enemy_Hp/Enemy_Hp.text = String(Walka[2]) + "/" + String(Walka[3])
func _process(delta):

	if Walka[2] < 1 and  koniec == 0:
		koniec = 1
		for n in get_node("Macka/Area2D").get_children():
			get_node("Macka/Area2D").remove_child(n)
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Walka[2] < 1:
		dir.remove(save_path)
		Gracz[3] = Gracz[3] + 100
		if Gracz[3] == Gracz[4]:
			Gracz[4] = Gracz[4] * 2
			Gracz[3] = 0
			Gracz[1] = Gracz[1] +10
			save_unique(Gracz,save_path_Gracz)
		get_tree().change_scene("res://Wyprawa.tscn")
	if Gracz[0] < 1:
		dir.remove(save_path)
		Save = 0
		save_unique(Save,save_path_is_saved)
		get_tree().change_scene("res://Main.tscn")
	if mouse_in == 1 and check_child == 0 and Atack_click + Stun_click + Heal_click + Boost_click == 1:
		spawn()
		check_child = 1
	if mouse_in == 0 and check_child == 1 or Atack_click + Stun_click + Heal_click + Boost_click == 0:
		unspawn()
		check_child = 0
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and mouse_in == 1:
		if Atack_click == 1:
			atak.randomize()
			if Boost == 1:
				Walka[2] -= atak.randi_range(15,30)
				Boost = 0
			else:
				Walka[2] -= atak.randi_range(8,15)
			Mob_attack = 1
			Atack_click = 0
			$Macka/Area2D/Bar_Enemy_Hp/Enemy_Hp.text = String(Walka[2]) + "/" + String(Walka[3])
			$Macka/Area2D/Bar_Enemy_Hp.value = Walka[2]
			save_unique(Gracz,save_path_Gracz)
			save_unique(Walka,save_path)
		if Stun_click == 1:
			Walka[2] -= 3
			Mob_stun = 1
			Mob_attack = 1
			Stun_click = 0
			$Macka/Area2D/Bar_Enemy_Hp/Enemy_Hp.text = String(Walka[2]) + "/" + String(Walka[3])
			$Macka/Area2D/Bar_Enemy_Hp.value = Walka[2]
			save_unique(Gracz,save_path_Gracz)
			save_unique(Walka,save_path)
		if Heal_click == 1:
			heal.randomize()
			Gracz[0] += heal.randi_range(10,25)
			if Gracz[0] > 100:
				Gracz[0] = 100	
			Mob_attack = 1
			Heal_click = 0
			$Gracz/Bar_Gracz_Hp/Gracz_Hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
			$Gracz/Bar_Gracz_Hp.value = Gracz[0]
			save_unique(Gracz,save_path_Gracz)
			save_unique(Walka,save_path)
		if Boost_click == 1:
			Boost = 1
			Mob_attack = 1
			Boost_click = 0
	if Mob_attack == 1 and Mob_stun == 0 and Walka[2] > 0:
		atak.randomize()
		heal.randomize()
		Mob_attack = 0
		if Walka[2] < 20:
			Walka[2] +=  heal.randi_range(6,10)
			$Macka/Area2D/Bar_Enemy_Hp/Enemy_Hp.text = String(Walka[2]) + "/" + String(Walka[3])
			$Macka/Area2D/Bar_Enemy_Hp.value = Walka[2]
			save_unique(Gracz,save_path_Gracz)
			save_unique(Walka,save_path)
		else:
			Gracz[0] -= atak.randi_range(5,15)
			$Gracz/Bar_Gracz_Hp/Gracz_Hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
			$Gracz/Bar_Gracz_Hp.value = Gracz[0]
			save_unique(Gracz,save_path_Gracz)
			save_unique(Walka,save_path)
	elif Mob_attack == 1 and Mob_stun == 1:
		Mob_stun = 0
		Mob_attack = 0
	
func _on_Attack_pressed():
		Atack_click = 1
		Heal_click = 0
		Boost_click = 0
		Stun_click = 0

func _on_Stun_pressed():
		Atack_click = 0
		Heal_click = 0
		Boost_click = 0
		Stun_click = 1
func _on_Boost_pressed():
		Atack_click = 0
		Heal_click = 0
		Boost_click = 1
		Stun_click = 0
func _on_Heal_pressed():
		Atack_click = 0
		Heal_click = 1
		Boost_click = 0
		Stun_click = 0

func _on_Area2D_mouse_entered():
		get_node("Panel2/Opis_moba").text = "Macka typu ognistego słabos woda"
		get_node("Panel2").rect_position = Vector2(1060,20)
		mouse_in = 1
func _on_Area2D_mouse_exited():
		get_node("Panel2").rect_position = Vector2(1280,20)
		mouse_in = 0

func spawn():
	var Znak = znacznik.instance()
	get_node("Container").add_child(Znak)
func unspawn():
	for n in get_node("Container").get_children():
		get_node("Container").remove_child(n)
		n.queue_free()


func _on_Attack_mouse_entered():
	if(Boost == 0):
		get_node("Panel/Opis_spella").text = "Atak moze zabrac od 8 od 15 punktow zycia"
	else:
		get_node("Panel/Opis_spella").text = "Atak moze zabrac od 15 od 30 punktow zycia"
	get_node("Panel").rect_position = Vector2(20,20)
func _on_Attack_mouse_exited():
	get_node("Panel").rect_position = Vector2(-200,20)
			
		
func _on_Boost_mouse_entered():
	get_node("Panel/Opis_spella").text = "Podwaja obrazenia tojego nastepnego ataku"
	get_node("Panel").rect_position = Vector2(20,20)
func _on_Boost_mouse_exited():
	get_node("Panel").rect_position = Vector2(-200,20)
		
func _on_Stun_mouse_entered():
	get_node("Panel/Opis_spella").text = "Zadje 3 obrazenmia i stunuje przeciwnika na nasatepna ture"
	get_node("Panel").rect_position = Vector2(20,20)
func _on_Stun_mouse_exited():
	get_node("Panel").rect_position = Vector2(-200,0)
		
func _on_Heal_mouse_entered():
	get_node("Panel/Opis_spella").text = "Regeneruje od 10 do 25 punktow zycia"
	get_node("Panel").rect_position = Vector2(20,20)
func _on_Heal_mouse_exited():
	get_node("Panel").rect_position = Vector2(-200,0)

func save_unique(save,save_path):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_eq():
	var file = File.new()
	if file.file_exists(save_path_Zbroja):
		var error = file.open(save_path_Zbroja, File.READ)
		if error == OK:
			Zbroja = file.get_var()
			file.close()
func load_hp():
	var file = File.new()
	if file.file_exists(save_path_Gracz):
		var error = file.open(save_path_Gracz, File.READ)
		if error == OK:
			Gracz = file.get_var()
			file.close()
func load_curent():
	var file = File.new()
	if file.file_exists(save_path_planet_curent):
		var error = file.open(save_path_planet_curent, File.READ)
		if error == OK:
			Curent = file.get_var()
			file.close()			

func load_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			Walka = file.get_var()
			file.close()
func check_save():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				Randomizuj_Walke()
				file.store_var(start_set)
			file.close()
	else:
		var error = file.open(save_path, File.WRITE)
		if error == OK:
			Randomizuj_Walke()
			file.store_var(start_set)
			file.close()
	load_data()
func Set_background():
	$Kosmos.texture = load("res://Hud/Background_"+String(Curent[0])+".png")
func Set_Enemy(a):
	if a == 0:
		$Macka/Area2D/Sprite.texture = load("res://Przeciwnik/Slime_"+String(Curent[0])+".png")
	elif a == 1:
		$Macka/Area2D/Sprite.texture = load("res://Przeciwnik/Enemy_"+String(Curent[0])+".png")	
	elif a == 2:
		$Macka/Area2D/Sprite.texture = load("res://Przeciwnik/Boss.png")	
func Set_Zbroja():
	$H.texture_normal= load("res://Zbroja/Hud/H_"+String(Zbroja[0][0])+".png")
	$K.texture_normal= load("res://Zbroja/Hud/K_"+String(Zbroja[0][1])+".png")
	$S.texture_normal= load("res://Zbroja/Hud/S_"+String(Zbroja[0][2])+".png")
	$B.texture_normal= load("res://Zbroja/Hud/B_"+String(Zbroja[0][3])+".png")
func Randomizuj_Walke():
	a = randi()%2
	start_set[4] = a;
	if(start_set[4] == 0):
		start_set[2] = 30 + int(30 * Curent[1]/10)
		start_set[3] = 30 + int(30 * Curent[1]/10)
	if(start_set[4] == 1):
		start_set[2] = 50 + int(50 * Curent[1]/10)
		start_set[3] = 50 + int(50 * Curent[1]/10)
func Set_Enemy_hp():
	pass
func Set_Gracz_hp():
	pass
