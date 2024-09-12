extends Panel


@onready var superRect = $supermercado
@onready var verduleriaRect = $verduleria
@onready var panaderiaRect = $panaderia
@onready var dieteticaRect = $dietetica
@onready var otrosRect = $otros

@onready var PANEL = $"."

var getUrl = "https://api-godot.vercel.app/montos"
var listOfLabels = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../HTTPRequestGET".request(getUrl)
	for child in $".".get_children():
		if "cantidad" in child.name:
			listOfLabels.append(child)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volver_pressed() -> void:
	PANEL.visible = false
	$"../Panel".visible = true


func _on_http_request_get_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var res = JSON.parse_string(body.get_string_from_utf8())
	var montoTotal = 0
	#No encontré mejor forma de hacerlo
	for label in listOfLabels:
		for tipo in res:
			if tipo.get("supermercado") != null and "supermercado" in label.name:
				label.text = tipo.get("supermercado")
				montoTotal += int(tipo.get("supermercado"))
			if tipo.get("verduleria") != null and "verduleria" in label.name:
				label.text = tipo.get("verduleria")
				montoTotal += int(tipo.get("verduleria"))
			if tipo.get("panaderia") != null and "panaderia" in label.name:
				label.text = tipo.get("panaderia")
				montoTotal += int(tipo.get("panaderia"))
			if tipo.get("dietética") != null and "dietetica" in label.name:
				label.text = tipo.get("dietética")
				montoTotal += int(tipo.get("dietética"))
			if tipo.get("otros") != null and "otros" in label.name:
				label.text = tipo.get("otros")
				montoTotal += int(tipo.get("otros"))
	
	calculoRect(montoTotal)
	
	
func calculoRect(montoTotal):
	#Orden de resultados
	#Supermercado - verduleria - panaderia - dietética - otros
	var alturas = []
	for elemento in listOfLabels:
		var porcentajeTipo = (int(elemento.text)*100)/int(montoTotal)
		var porcentajeRect = (porcentajeTipo*200)/100
		alturas.append(porcentajeRect)

	for child in $".".get_children():
			if child is ColorRect:
				match child.name:
					"supermercado":
						child.set_size(Vector2(40,alturas[0]))
					"verduleria":
						child.set_size(Vector2(40,alturas[1]))
					"panaderia":
						child.set_size(Vector2(40,alturas[2]))
					"dietetica":
						child.set_size(Vector2(40,alturas[3]))
					"otros":
						child.set_size(Vector2(40,alturas[4]))
