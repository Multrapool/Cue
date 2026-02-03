extends Object

var CUE := load("res://mods-unpacked/Multrapool-Cue/cue.gd")

func _ready(chain:ModLoaderHookChain):
    chain.execute_next([])
    
    Global.eventManager.run_event(CUE.BallEvents.SPAWN_DROPLET, self) 
    CUE.call_event(CUE.Events.SPAWN_DROPLET, {droplet=self})
    
func set_type(chain:ModLoaderHookChain, type):
    chain.execute_next([type])
    
    if CUE.droplet_data.has(type):
        CUE.droplet_data[type].init.call(self)

func _on_area_2d_body_entered(chain:ModLoaderHookChain, body:Node2D):
    if CUE.droplet_data.has(self.droplet_type) and body is Ball:
        CUE.droplet_data[self.droplet_type].on_ball.call(self, body)

    chain.execute_next([body])
    
func _process(chain:ModLoaderHookChain, delta:float):
    if CUE.droplet_data.has(self.droplet_type):
        CUE.droplet_data[self.droplet_type].process.call(self, delta)
    chain.execute_next([delta])
    
func remove(chain:ModLoaderHookChain):
    if CUE.droplet_data.has(self.droplet_type):
        CUE.droplet_data[self.droplet_type].remove.call(self)
    chain.execute_next([])
