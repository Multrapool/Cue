extends Object

var CUE := preload("res://mods-unpacked/Multrapool-Cue/cue.gd")


func _process(chain:ModLoaderHookChain, delta:float):
    var current_balls = Global.gameManager.balls.duplicate()
    for ball in current_balls:
        CUE.call_ball_event(ball, CUE.Events.BEFORE_PROCESS, {delta=delta})
    chain.execute_next([delta])
    current_balls = Global.gameManager.balls.duplicate()
    for ball in current_balls:
        CUE.call_ball_event(ball, CUE.Events.AFTER_PROCESS, {delta=delta})

func update_initial_weight(chain:ModLoaderHookChain):
    chain.execute_next([])
    
    if CUE.modded_balls.has(chain.reference_object.ball_item.data.id) or\
        (chain.reference_object.ball_item.mixed_data != null and\
            CUE.modded_balls.has(chain.reference_object.ball_item.mixed_data.id)):
     
        var weight1:Ball.WEIGHT_LEVEL = chain.reference_object.weight_state
        var weight2:= Ball.WEIGHT_LEVEL.NORMAL
        if CUE.initial_weights.has(chain.reference_object.ball_item.data.id):
            weight1 = CUE.initial_weights[chain.reference_object.ball_item.data.id]
        if chain.reference_object.ball_item.mixed_data != null and CUE.initial_weights.has(chain.reference_object.ball_item.mixed_data.id):
            weight2 = CUE.initial_weights[chain.reference_object.ball_item.mixed_data.id]
            
        if weight1 == weight2:
            chain.reference_object.weight_state = weight1
        elif weight1 == Ball.WEIGHT_LEVEL.NORMAL:
            chain.reference_object.weight_state = weight2
        elif weight2 == Ball.WEIGHT_LEVEL.NORMAL:
            chain.reference_object.weight_state = weight1
            
func update_weight(chain:ModLoaderHookChain):
    chain.execute_next([])
    
    if CUE.modded_balls.has(chain.reference_object.ball_item.data.id) or\
        (chain.reference_object.ball_item.mixed_data != null and\
            CUE.modded_balls.has(chain.reference_object.ball_item.mixed_data.id)):
        var to_set:={}
        if CUE.initial_masses_and_scales.has(chain.reference_object.ball_item.data.id):
            to_set = CUE.initial_masses_and_scales[chain.reference_object.ball_item.data.id].call(chain.reference_object)
        elif chain.reference_object.ball_item.mixed_data != null and CUE.initial_masses_and_scales.has(chain.reference_object.ball_item.mixed_data.id):
            to_set = CUE.initial_masses_and_scales[chain.reference_object.ball_item.mixed_data.id].call(chain.reference_object)
            
        if to_set.has("weight_state"):
            chain.reference_object.weight_state = to_set.weight_state
        if to_set.has("mass"):
            chain.reference_object.mass = to_set.mass
        if to_set.has("scale_modifier"):
            chain.reference_object.scale_modifier = to_set.scale_modifier
