extends Object

var CUE := load("res://mods-unpacked/Multrapool-Cue/cue.gd")

func _ready(chain:ModLoaderHookChain):
    chain.execute_next([])
    
    Global.eventManager.run_event(CUE.BallEvents.SPAWN_DROPLET, self) 
    CUE.call_event(CUE.Events.SPAWN_DROPLET, {droplet=self})
