extends Object

var CUE := preload("res://mods-unpacked/Multrapool-Cue/cue.gd")

func _ready(chain:ModLoaderHookChain):
    chain.execute_next([])
    
    Global.eventManager.run_event(CUE.BallEvents.SPAWN_DROPLET, chain.reference_object) 
    CUE.call_event(CUE.Events.SPAWN_DROPLET, {droplet=chain.reference_object})
    
func set_type(chain:ModLoaderHookChain, type):
    chain.execute_next([type])
    
    if CUE.droplet_data.has(type):
        CUE.droplet_data[type].init.call(chain.reference_object)

func _on_area_2d_body_entered(chain:ModLoaderHookChain, body:Node2D):
    if CUE.droplet_data.has(chain.reference_object.droplet_type) and body is Ball:
        CUE.droplet_data[chain.reference_object.droplet_type].on_ball.call(chain.reference_object, body)

    chain.execute_next([body])
    
func _process(chain:ModLoaderHookChain, delta:float):
    if CUE.droplet_data.has(chain.reference_object.droplet_type):
        CUE.droplet_data[chain.reference_object.droplet_type].process.call(chain.reference_object, delta)
    chain.execute_next([delta])
    
func remove(chain:ModLoaderHookChain):
    if CUE.droplet_data.has(chain.reference_object.droplet_type):
        CUE.droplet_data[chain.reference_object.droplet_type].remove.call(chain.reference_object)
    chain.execute_next([])
