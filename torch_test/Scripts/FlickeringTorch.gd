extends Sprite

var _frame_count = 1
var _keep_shrinking = true

#Flicker variables
export var enable_flicker: bool = true
export var flicker_min_scale: float = .9
export var flicker_max_scale: float = 1.1
export var flicker_delay: float = 45
export var flicker_scale_rate: float = .1
export var enable_rand_offset: bool = true #test
var _rand_offset: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enable_rand_offset and enable_flicker:
		rand_seed(self.get_instance_id())
		_rand_offset = floor(rand_range(0, flicker_delay))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(frame_count)
	if enable_flicker:
		do_flickering()

func do_flickering():
	if fmod(_frame_count, flicker_delay) == _rand_offset:
		if get_node("LightSource").texture_scale < flicker_min_scale:
			grow()
			_keep_shrinking = false
		elif get_node("LightSource").texture_scale > flicker_max_scale:
			shrink()
			_keep_shrinking = true
		elif get_node("LightSource").texture_scale < flicker_max_scale and _keep_shrinking:
			shrink()
		else:
			grow()
		_frame_count = 1.0	
	_frame_count += 1.0
	
func grow():
	get_node("LightSource").texture_scale += flicker_scale_rate

func shrink():
	get_node("LightSource").texture_scale -= flicker_scale_rate
