extends Control

@onready var listItem = ""
@onready var montoNode = $Panel/BoxContainer/VBoxContainer/Monto
var monto: int = 0
@onready var descripcion =$Panel/BoxContainer/VBoxContainer3/Descripcion
@onready var POST = $HTTPRequest
var itemSelected = 0
var url = "https://api-godot.vercel.app/data"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OK.visible = false
	$Panel.visible = true
	$WRONG.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ingresar_pressed() -> void:
	match itemSelected:
		0:
			listItem = "supermercado"
		1:
			listItem = "verduleria"
		2:
			listItem = "panaderia"
		3:
			listItem = "dietetica"
		4:
			listItem = "otros"
			
	monto = int(montoNode.text)
	
	
	sendData(listItem, monto, str(descripcion.text))

func _on_list_items_item_selected(index: int) -> void:
	itemSelected = index


func sendData(itemSelected, monto, descripcion):
	if itemSelected != "" and monto > 0 and descripcion != "":
		var jsonData = JSON.stringify({"rubro":itemSelected,"monto":monto,"descripcion":descripcion})
		var headers = ["Content-Type: application/json"]
		POST.request(url, headers, HTTPClient.METHOD_POST, jsonData)
		$OK.visible = true
		$Panel.visible = false
		$WRONG.visible = false
	else:
		$OK.visible = false
		$Panel.visible = false
		$WRONG.visible = true


func _on_volver_pressed() -> void:
	$OK.visible = false
	$Panel.visible = true
	$WRONG.visible = false
