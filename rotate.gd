extends Node2D

@onready var hand = $CentralLine
@onready var shape = $Shape
@onready var circle = $Circle
var shapes = [$Shape, $Circle]
var num_shapes = 16
var radius = 200
var timer: Timer

# Define 7 colors to choose from
var colors = [
	Color.RED,
	Color.BLUE,
	Color.GREEN,
	Color.YELLOW,
	Color.ORANGE,
	Color.PURPLE,
	Color.CYAN
]


func _physics_process(delta):
	
	
	pass

func spawn_shapes():
	var center = Vector2(0, 0)  # The game center; adjust if needed
	var radius = 200            # Distance from the center
	var num_clones = 16
	
	for i in range(num_clones):
		var angle = (TAU / num_clones) * i + 0.18   # TAU = 2 * PI
		var clone
		if(randi()%2 == 0):
			clone = shape.duplicate()
		else:
			clone = circle.duplicate()
		clone.get_node("Polygon2D").color = colors.pick_random()
		clone.visible = true
		add_child(clone)
		
		# Position clone around the circle
		clone.position = center + Vector2(cos(angle), sin(angle)) * radius
		
		# Optional: rotate the clone itself to face outward
		clone.rotation = angle

func _ready():
	spawn_shapes()
	
	# Create and start a timer
	timer = Timer.new()
	timer.wait_time = 2.0   # seconds between rotations
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	

	

func _on_timer_timeout():
	# Pick a random index
	var idx = randi_range(0, num_shapes - 1)
	# Compute the angle
	var angle = (TAU / num_shapes) * idx
	print(angle)
	# Rotate hand to point there
	# hand.rotation = angle

	var tween = create_tween()
	tween.tween_property(hand, "rotation", angle, 0.5) # rotate over 0.5 sec
