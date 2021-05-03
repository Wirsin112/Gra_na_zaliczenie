extends Node2D
onready var timer = get_node("Panel3/Timer")
var koniec = 0
var Samouczek = 0
var Macka_Hp = 40
var Gracz_Hp = 100
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
	timer.set_wait_time(0.1)
	get_node("Panel3/Mow").text = "Wtiaj w samouczku walki nauczysz sie tu jak przeprowadzac pojedynki. Pierwszym przeciwnikiem z jakim masz okzje sie zmierzyc jest Ognista mcka potwor lubujacy sie w cieplym srodowisu. \n<Klikj praway przycisk myszy by isc dalej>"
	get_node("Gracz/Gracz_Hp").text = String(Gracz_Hp) + "/100"
	get_node("Macka/Area2D/Enemy_Hp").text = String(Macka_Hp) + "/40"
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 0:
		get_node("Panel3/Mow").text = "Dobrze Teraz opowiem Ci co znajduje na twoim ekranie. Zaczynajac od lewej strony widzimy twoj pancerz jak widzisz jest on bialy co znaczy ze nie ma oddatkowych wartosci obronnych. \n<Klikj praway przycisk myszy by isc dalej>"
		timer.start()
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 1:
		get_node("Panel3/Mow").text = "Kolejny w kolejnosci jest krysztal pokazuje on jaki typ posiada towja bron jak widzisz jest on niebieskiego koloru co ozancza, ze krysztal jest wony i bedzie zadawal przeciwnikom o 30% wiecej obrazen. \n<Klikj praway przycisk myszy by isc dalej>"
		timer.start()
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 2:
		get_node("Panel3/Mow").text = "Dalej Widzimy umiejętności jest ich poki co 4 ale pozniej bedziesz w stanie zdobyc kolejne zaczynajac od lewej gory jest zwykly atak, stun, boost ataku, leczenie. \n<Klikj praway przycisk myszy by isc dalej>"
		timer.start()
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 3:
		get_node("Panel3/Mow").text = "Jezeli najedziesz na jedna z tych umiejetnosci w lewym gorym rogu pojawi Ci sie opis tej umiejetnosci.\n<Klikj praway przycisk myszy by isc dalej>"
		timer.start()		
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 4:
		get_node("Panel3/Mow").text = "Dalej znajduje sie ekwipunek nie bedzimy sie tu bardziej nad tym rozdrabniac by nie zrodzac od razu wszystkich smaczkow, ale w skrocie beze mozna w trakcie walki uzyc niektorych przedmiot by ulatic sobie walke.\n<Klikj praway przycisk myszy by isc dalej>"
		timer.start()
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 5:
		get_node("Panel3/Mow").text = "Nad ekwipunkiem moze znajdowac sie od 1 do 3 przeciwnikow. Dla trenigu bedzio to jeden przeciwnik. Jak najedziesz na jednego z przeciwnikow w prawym gorym rogu pojawi sie jego opis.\n<Klikj praway przycisk myszy by isc dalej>"
		timer.start()		
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 6:
		get_node("Panel3/Mow").text = "Walka jest dwufazowa najpierw wybieramy umijetnosc ktora chemy uzyc poprzez klikniecia na nia, a potem klikamy na przeciwnika na ktorym dana umiejetnosc chemy uzyc.\n<Wybierz umiejtnos>"
		timer.start()	
	if Atack_click + Stun_click + Heal_click + Boost_click == 1 and Samouczek == 7:
		get_node("Panel3/Mow").text = "Dobrze gdy wybrales umiejetonsc teraz gdy najedziesz na przeciwnika ktorego chesz zatakowac pojawi sie nad nim strzalka dzieki ktorej wiesz ze spell jest wybrany a takze czy napewno atakujesz dobrego przeciwnika.\n<Pokonaj przeciwnika>"
		timer.start()		
	if Macka_Hp < 1 and Samouczek == 8 and koniec == 0:
		koniec = 1
		get_node("Panel3/Mow").text = "Gratulacje ukonczyles szkolnie teraz na pewno poradzisz sobie w kosmosie.\n<Klikj praway przycisk myszy by wrocic do menu>"
		timer.start()
		for n in get_node("Macka/Area2D").get_children():
			get_node("Macka/Area2D").remove_child(n)
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and Samouczek == 9:
		get_tree().change_scene("res://Main.tscn")
	if Gracz_Hp < 1:
		get_tree().change_scene("res://Poknij.tscn")
	if mouse_in == 1 and check_child == 0 and Atack_click + Stun_click + Heal_click + Boost_click == 1 and Samouczek > 6:
		spawn()
		check_child = 1
	if mouse_in == 0 and check_child == 1 or Atack_click + Stun_click + Heal_click + Boost_click == 0 and Samouczek > 6:
		unspawn()
		check_child = 0
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and mouse_in == 1:
		if Atack_click == 1:
			atak.randomize()
			if Boost == 1:
				Macka_Hp -= atak.randi_range(15,30)
				Boost = 0
			else:
				Macka_Hp -= atak.randi_range(8,15)
			Mob_attack = 1
			Atack_click = 0
			get_node("Macka/Area2D/Enemy_Hp").text = String(Macka_Hp) + "/40"
		if Stun_click == 1:
			Macka_Hp -= 3
			Mob_stun = 1
			Mob_attack = 1
			Stun_click = 0
			get_node("Macka/Area2D/Enemy_Hp").text = String(Macka_Hp) + "/40"
		if Heal_click == 1:
			heal.randomize()
			Gracz_Hp += heal.randi_range(10,25)
			if Gracz_Hp > 100:
				Gracz_Hp = 100	
			Mob_attack = 1
			Heal_click = 0
			get_node("Gracz/Gracz_Hp").text = String(Gracz_Hp) + "/100"
		if Boost_click == 1:
			Boost = 1
			Mob_attack = 1
			Boost_click = 0
	if Mob_attack == 1 and Mob_stun == 0 and Macka_Hp > 0:
		atak.randomize()
		heal.randomize()
		Mob_attack = 0
		if Macka_Hp < 20:
			Macka_Hp +=  heal.randi_range(6,10)
			get_node("Macka/Area2D/Enemy_Hp").text = String(Macka_Hp) + "/40"
		else:
			Gracz_Hp -= atak.randi_range(5,15)
			get_node("Gracz/Gracz_Hp").text = String(Gracz_Hp) + "/100"	
	elif Mob_attack == 1 and Mob_stun == 1:
		Mob_stun = 0
		Mob_attack = 0
	
func _on_Attack_pressed():
	if Samouczek > 6:
		Atack_click = 1
		Heal_click = 0
		Boost_click = 0
		Stun_click = 0

func _on_Stun_pressed():
	if Samouczek > 6:
		Atack_click = 0
		Heal_click = 0
		Boost_click = 0
		Stun_click = 1
func _on_Boost_pressed():
	if Samouczek > 6:
		Atack_click = 0
		Heal_click = 0
		Boost_click = 1
		Stun_click = 0
func _on_Heal_pressed():
	if Samouczek > 6:
		Atack_click = 0
		Heal_click = 1
		Boost_click = 0
		Stun_click = 0

func _on_Area2D_mouse_entered():
	if Samouczek > 5:
		get_node("Panel2/Opis_moba").text = "Macka typu ognistego słabos woda"
		get_node("Panel2").rect_position = Vector2(1060,20)
		mouse_in = 1
func _on_Area2D_mouse_exited():
	if Samouczek > 5:
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
	if Samouczek > 3:
		if(Boost == 0):
			get_node("Panel/Opis_spella").text = "Atak moze zabrac od 8 od 15 punktow zycia"
		else:
			get_node("Panel/Opis_spella").text = "Atak moze zabrac od 15 od 30 punktow zycia"
		get_node("Panel").rect_position = Vector2(20,20)
func _on_Attack_mouse_exited():
	if Samouczek > 3:
		get_node("Panel").rect_position = Vector2(-200,20)
			
		
func _on_Boost_mouse_entered():
	if Samouczek > 3:
		get_node("Panel/Opis_spella").text = "Podwaja obrazenia tojego nastepnego ataku"
		get_node("Panel").rect_position = Vector2(20,20)
func _on_Boost_mouse_exited():
	if Samouczek > 3:
		get_node("Panel").rect_position = Vector2(-200,20)
		
func _on_Stun_mouse_entered():
	if Samouczek > 3:
		get_node("Panel/Opis_spella").text = "Zadje 3 obrazenmia i stunuje przeciwnika na nasatepna ture"
		get_node("Panel").rect_position = Vector2(20,20)
func _on_Stun_mouse_exited():
	if Samouczek > 3:
		get_node("Panel").rect_position = Vector2(-200,0)
		
func _on_Heal_mouse_entered():
	if Samouczek > 3:
		get_node("Panel/Opis_spella").text = "Regeneruje od 10 do 25 punktow zycia"
		get_node("Panel").rect_position = Vector2(20,20)
func _on_Heal_mouse_exited():
	if Samouczek > 3:
		get_node("Panel").rect_position = Vector2(-200,0)
			
func _on_Timer_timeout():
	Samouczek += 1
	timer.stop()
