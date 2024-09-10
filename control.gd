extends Control

@onready var listItem = ""
@onready var montoNode = $Panel/BoxContainer/VBoxContainer/Monto
var monto: int = 0
@onready var descripcion =$Panel/BoxContainer/VBoxContainer3/Descripcion
var itemSelected = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
		print("ALL OK")
	else:
		print("falta data")
