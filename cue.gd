class_name Multrapool_Cue

static var MOD_NAME := "Multrapool-Cue" 
static var CUE_VERSION := ""
static var CUE_ERA := "Chalk"

### libs

static var GALLERY
static func _create_singletons(holder:Node):
    var sub_holder:Node = load("res://mods-unpacked/Multrapool-Cue/libs/lib_holder.tscn")\
        .instantiate()
    holder.add_child(sub_holder)
    
    GALLERY=sub_holder.get_node("Multrapool_LibGallery")
    
### take over

static var _virtual_files:= []
static var modded_balls:=[]

static var _global_thingy_bc_godot_is_silly:= []
## Registers this file into the vanilla game files so it can be found where its supposed to be[br][br]
##
## [param modName]: The name of this mod[br]
## [param path]: The path of this file after res://mods-unpacked/modName/overwrites
static func take_over(modName:String, path:String):
    var to_take_over = load("res://mods-unpacked/"+modName+"/overwrites/"+path)
    to_take_over.take_over_path("res://"+path)
    _virtual_files.append("res://"+path)
    _global_thingy_bc_godot_is_silly.append(to_take_over)
    
    if path.begins_with("data/balls_data/"):
        var resource = load("res://"+path)
        if resource is BallResource:
            modded_balls.append(resource.id)
    
### events

class _eventHolder:
    const POCKET = 'POCKET'
    const POCKET_ANOTHER = &"POCKET-ANOTHER" 
    const SPAWN = 'SPAWN'
    const SPAWN_ANOTHER = &"SPAWN-ANOTHER" 
    const ROUND_START = &"ROUND-START" 
    const HIT = &"HIT" 
    const HIT_WALL = &"HIT-WALL" 
    const SCORE = &"SCORE" 
    const REACH_SCORE = &"REACH-SCORE" 
    const SCORE_CHANGE = &"SCORE-CHANGE" 
    const ROUND_END = &"ROUND-END" 
    const MAX_ROLL = &"MAX-ROLL" 
    const TRANSFORM = &"TRANSFORM" 
    const TRANSFORM_ANOTHER = &"TRANSFORM-ANOTHER" 
    const PICKUP_DROPLET = &"PICKUP-DROPLET" 
    const SHOOT = &"SHOOT" 
    const ENTER_SHOP = &"ENTER-SHOP" 
    const UPGRADE_BALL = &"UPGRADE-BALL" 
    const SELL_SELF = &"SELL-SELF" 
    const SELL_ANOTHER = &"SELL-ANOTHER" 
    const REROLL_SHOP = &"REROLL-SHOP" 
    const BUY = &"BUY" 
    const BUY_ANOTHER = &"BUY-ANOTHER" 
    const BUFF = &"BUFF"
    
    const SPAWN_DROPLET  = "Multrapool-SPAWN_DROPLET"
static var Events = _eventHolder.new()

static var _registeredBallEvents = {}
## Registers a callback to be run on some ball event[br][br]
##
## [param ball_id]: The id of the type of ball that should run this action[br]
## [param event]: A member of [ballEventHolder] (or a string, if you're using a custom event)[br]
## [param action]: A function that takes a [Ball], a dictionary of assorted values, and if it is the mixed side, and performs the event action[br]
## [param action] = func(ball:Ball, assorted:Dictionary, isMixedSide:bool)
static func register_ball_event(ball_id:String, event:String, action:Callable):
    if !_registeredBallEvents.has(event):
        _registeredBallEvents[event] = {}
    _registeredBallEvents[event][ball_id] = action
    
    if event != "SPAWN" and event != "POCKET":
        Global.eventManager.HARDCODED_EVENT_LISTENERS[event].append(ball_id)
    elif event == "SPAWN":
        Global.eventManager.SPAWN_EFFECTS.set(ball_id,"")
    else:
        Global.eventManager.POCKET_EFFECTS.set(ball_id,"")
    
## Gets the event for a ball[br][br]
##
## [param ball_id]: The id of the type of ball[br]
## [param event]: A member of [ballEventHolder] (or a string, if you're using a custom event)
## Returns the action that this ball will run, or null
static func get_ball_event(ball_id:String, event:String) -> Callable:
    if _registeredBallEvents.has(event) and _registeredBallEvents[event].has(ball_id):
        return _registeredBallEvents[event][ball_id]
    return func(_a,_b,_c):return
    
    
## Checks if there is an event for a ball[br][br]
##
## [param ball_id]: The id of the type of ball[br]
## [param event]: A member of [ballEventHolder] (or a string, if you're using a custom event)
static func has_ball_event(ball_id:String, event:String) -> bool:
    if _registeredBallEvents[event] == null:
        return false
    return _registeredBallEvents[event][ball_id] != null
    
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


static var _registeredEvents = {}
### Registers a callback to be run on some event[br][br]
###
### [param event]: A member of [eventHolder] (or a string, if you're using a custom event)[br]
### [param action]: A function that takes a dictionary of assorted values and performs the event action[br]
### [param action] = func(assorted:Dictionary)
static func register_event(event:String, action:Callable):
    if !_registeredEvents.has(event):
        _registeredEvents[event] = []
    _registeredEvents[event].append(action)
    
static func call_event(event:String, additional:Dictionary):
    if _registeredEvents.has(event):
        for callback in _registeredEvents[event]:
            callback.call(additional)
            
### custom droplets

static var _last_used_droplet = load("res://droplet.gd").DROPLET_TYPE.size()-1
static var _droplet_data := {}
static func register_droplet(init:Callable, 
        on_ball:Callable, 
        process:Callable, 
        remove:Callable) -> int:
    _last_used_droplet+=1
    
    _droplet_data[_last_used_droplet] = {
        init=init,
        on_ball=on_ball,
        process=process,
        remove=remove
    }
    
    return _last_used_droplet

### misc
    
static var initial_masses_and_scales:={}
### [param callback]: func(otherball_if_mixed:[BallResource]) -> [br]
### { weight_state:[enum Ball.WEIGHT_STATE], mass:[float], scale:[float] }[br][br]
###
### If any of the values of the dictionary are null,
### they will be set to their default values (NORMAL, 1, 1)
static func initial_mass_scale_callback(ball_id:String, callback:Callable):
    initial_masses_and_scales[ball_id] = callback
