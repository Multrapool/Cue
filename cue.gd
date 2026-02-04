class_name Multrapool_Cue

static var MOD_NAME := "Multrapool-Cue" 
static var CUE_VERSION := ""
static var CUE_ERA := "Triangle"

### libs


static var GALLERY
static func _create_singletons(holder:Node):
    var sub_holder:Node = load("res://mods-unpacked/Multrapool-Cue/libs/lib_holder.tscn")\
        .instantiate()
    holder.add_child(sub_holder)
    
    GALLERY=sub_holder.get_node("Multrapool_LibGallery")
    
### take over


static var virtual_files:= []
static var modded_balls:=[]

static var global_thingy_bc_godot_is_silly:= []
## Registers this file into the vanilla game files so it can be found where its supposed to be[br][br]
##
## [param modName]: The name of this mod[br]
## [param path]: The path of this file after res://mods-unpacked/modName/overwrites
static func take_over(modName:String, path:String):
    var to_take_over = load("res://mods-unpacked/"+modName+"/overwrites/"+path)
    to_take_over.take_over_path("res://"+path)
    virtual_files.append("res://"+path)
    global_thingy_bc_godot_is_silly.append(to_take_over)
    
    if path.begins_with("data/balls_data/"):
        var resource = load("res://"+path)
        if resource is BallResource:
            modded_balls.append(resource.id)
    
### events


class ballEventHolder:  
    const BUFF = "BUFF"
    const BUY_ANY = "BUY-OTHER"
    const ENTER_SHOP = "ENTER-SHOP"
    const GAIN_MONEY = "GAIN-MONEY"
    const HIT_BALL = "HIT"
    const HIT_WALL = "HIT-WALL"
    const PICKUP_DROPLET = "PICKUP-DROPLET"
    const POCKET_ANY = "POCKET-ANOTHER"
    const POCKET_SELF = "POCKET"
    const REACH_SCORE = "REACH-SCORE"
    const ROUND_END = "ROUND-END"
    const ROUND_START = "ROUND-START"
    const GAIN_SCORE = "SCORE"
    const SELF_UPGRADE = "SCORE-CHANGE"
    const SELF_SCORED = "SCORE-SELF"
    const SELL_ANY = "SELL"
    const SELL_SELF = "SELL-SELF"
    const SHOOT = "SHOOT"
    const SPAWN_ANY = "SPAWN-ANOTHER"
    const SPAWN_SELF = "SPAWN"
    const TRANSFORM_ANY = "TRANSFORM-ANOTHER"
    const TRANSFORM_SELF = "TRANSFORM"
    const UPGRADE_BALL_IN_SHOP = "UPGRADE-SHOP-BALL"
    
    const REROLL = "MULTRAPOOL_CUE_REROLL"
    const SPAWN_DROPLET = "MULTRAPOOL_SPAWN_DROPLET"
class eventHolder:
    const BUFF = "BUFF"
    const BUY_BALL = "BUY_OTHER"
    const ENTER_SHOP = "ENTER_SHOP"
    const GAIN_MONEY = "GAIN_MONEY"
    const HIT_BALL = "HIT_BAll"
    const HIT_WALL = "HIT_WALL"
    const PICKUP_DROPLET = "PICKUP_DROPLET"
    const POCKET_BALL="POCKET_BALL"
    const REACH_SCORE = "REACH_SCORE"
    const ROUND_END = "ROUND_END"
    const ROUND_START = "ROUND_START"
    const GAIN_SCORE = "GAIN_SCORE"
    const BALL_UPGRADE = "BALL_UPGRADE"
    const SELL_BALL = "SELL"
    const SHOOT = "SHOOT"
    const SPAWN_BALL = "SPAWN_BALL"
    const TRANSFORM_BALL = "TRANSFORM-ANOTHER"
    const UPGRADE_BALL_IN_SHOP = "UPGRADE-SHOP-BALL"
    
    const REROLL = "REROLL"
    const SPAWN_DROPLET = "SPAWN_DROPLET"
static var BallEvents = ballEventHolder.new()
static var Events = eventHolder.new()

static var registeredBallEvents = {}
## Registers a callback to be run on some ball event[br][br]
##
## [param ball_id]: The id of the type of ball that should run this action[br]
## [param event]: A member of [ballEventHolder] (or a string, if you're using a custom event)[br]
## [param action]: A function that takes a [Ball], a dictionary of assorted values, and if it is the mixed side, and performs the event action[br]
## [param action] = func(ball:Ball, assorted:Dictionary, isMixedSide:bool)
static func register_ball_event(ball_id:String, event:String, action:Callable):
    if !registeredBallEvents.has(event):
        registeredBallEvents[event] = {}
    registeredBallEvents[event][ball_id] = action
    
## Gets the event for a ball[br][br]
##
## [param ball_id]: The id of the type of ball[br]
## [param event]: A member of [ballEventHolder] (or a string, if you're using a custom event)
## Returns the action that this ball will run, or null
static func get_ball_event(ball_id:String, event:String) -> Callable:
    if registeredBallEvents.has(event) and registeredBallEvents[event].has(ball_id):
        return registeredBallEvents[event][ball_id]
    return func(_a,_b,_c):return
    
    
## Checks if there is an event for a ball[br][br]
##
## [param ball_id]: The id of the type of ball[br]
## [param event]: A member of [ballEventHolder] (or a string, if you're using a custom event)
static func has_ball_event(ball_id:String, event:String) -> bool:
    if registeredBallEvents[event] == null:
        return false
    return registeredBallEvents[event][ball_id] != null
    
static func call_ball_event(ball, event:String, additional:Dictionary):
    var real_ball_item
    if ball is Ball:
        real_ball_item=ball.ball_item_og
    if ball is ShopBall:
        real_ball_item=ball.ball_item
        
    assert(real_ball_item != null)
    
    get_ball_event(real_ball_item.data.id, event).call(ball, additional, false)
    if real_ball_item.is_mixed():
        get_ball_event(real_ball_item.mixed_data.id, event).call(ball, additional, true)


static var registeredEvents = {}
## Registers a callback to be run on some event[br][br]
##
## [param event]: A member of [eventHolder] (or a string, if you're using a custom event)[br]
## [param action]: A function that takes a dictionary of assorted values and performs the event action[br]
## [param action] = func(assorted:Dictionary)
static func register_event(event:String, action:Callable):
    if !registeredEvents.has(event):
        registeredEvents[event] = []
    registeredEvents[event].append(action)
    
static func call_event(event:String, additional:Dictionary):
    if registeredEvents.has(event):
        for callback in registeredEvents[event]:
            callback.call(additional)
            
### custom droplets


static var last_used_droplet = load("res://droplet.gd").DROPLET_TYPE.size()-1
static var droplet_data := {}
static func register_droplet(init:Callable, 
        on_ball:Callable, 
        process:Callable, 
        remove:Callable) -> int:
    last_used_droplet+=1
    
    droplet_data[last_used_droplet] = {
        init=init,
        on_ball=on_ball,
        process=process,
        remove=remove
    }
    
    return last_used_droplet

### misc


static var initial_weights := {
    SEAL=Ball.WEIGHT_LEVEL.HEAVY,
    FISH=Ball.WEIGHT_LEVEL.LIGHT,
    JUPITER=Ball.WEIGHT_LEVEL.HEAVY,
    PLUTO=Ball.WEIGHT_LEVEL.LIGHT,
}
static func set_initial_weight(ball_id:String, weight:Ball.WEIGHT_LEVEL):
    initial_weights[ball_id]=weight
    
static var initial_masses_and_scales:={}
## [param callback]: func(otherball_if_mixed:[BallResource]) -> [br]
## { weight_state:[enum Ball.WEIGHT_STATE], mass:[float], scale:[float] }[br][br]
##
## If any of the values of the dictionary are null,
## they will be set to their default values (NORMAL, 1, 1)
static func initial_mass_scale_callback(ball_id:String, callback:Callable):
    initial_masses_and_scales[ball_id] = callback
