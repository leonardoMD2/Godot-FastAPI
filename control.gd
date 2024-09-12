extends Control


@onready var listItem = "supermercado"
@onready var montoNode = $Panel/BoxContainer/Monto/Monto
var monto: int = 0
@onready var descripcion =$Panel/BoxContainer/Descripcion/Descripcion
@onready var POST = $HTTPRequest
@onready var options = $Panel/BoxContainer/Tipos/OptionButton
var url = "https://api-godot.vercel.app/data"
var url2 = "http://localhost:8000/data"
var getUrl = "https://api-godot.vercel.app/montos"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/BoxContainer/Descripcion.visible = true
	$OK.visible = false
	$Panel.visible = true
	$WRONG.visible = false
	options.add_item("Supermercado")
	options.add_item("Verduleria")
	options.add_item("Panaderia")
	options.add_item("Dietética")
	options.add_item("Otros")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ingresar_pressed() -> void:
			
	monto = int(montoNode.text)
	sendData(listItem, monto, str(descripcion.text))



func sendData(itemSelected, monto, descripcion):
	if itemSelected != "" and monto > 0 and descripcion != "":
		var jsonData = JSON.stringify({"rubro":itemSelected,"monto":monto,"descripcion":descripcion})
		var headers = ["Content-Type: application/json"]
		POST.request(url, headers, HTTPClient.METHOD_POST, jsonData)
		$OK.visible = true
		$Panel.visible = false
		$WRONG.visible = false
		resetTexts()
	else:
		$OK.visible = false
		$Panel.visible = false
		$WRONG.visible = true
		resetTexts()


func _on_volver_pressed() -> void:
	$OK.visible = false
	$Panel.visible = true
	$WRONG.visible = false


func _on_option_button_item_selected(index: int) -> void:
	listItem = options.get_item_text(index).to_lower()



func _on_monto_focus_entered() -> void:
	$Panel/BoxContainer/Descripcion.visible = false


func _on_monto_text_submitted(new_text: String) -> void:
	$Panel/BoxContainer/Descripcion.visible = true


func _on_monto_focus_exited() -> void:
	$Panel/BoxContainer/Descripcion.visible = true

func resetTexts():
	montoNode.clear()
	descripcion.clear()


func _on_grafico_pressed() -> void:
	$Panel.visible = false
	$Graficos.visible = true
	$HTTPRequestGET.request(getUrl)
