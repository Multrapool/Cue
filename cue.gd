class_name Multrapool_Cue

static var MOD_NAME := "Multrapool-Cue" 
static var CUE_VERSION := "0.2.0 Triangle"

static var virtual_files:Array = []

static var global_thingy_bc_godot_is_silly: Array = []
## Registers this file into the vanilla game files so it can be found where its supposed to be[br][br]
##
## [param modName]: The name of this mod[br]
## [param path]: The path of this file after res://mods-unpacked/modName/overwrites
static func take_over(modName:String, path:String):
    var to_take_over = load("res://mods-unpacked/"+modName+"/overwrites/"+path)
    to_take_over.take_over_path("res://"+path)
    virtual_files.append("res://"+path)
    global_thingy_bc_godot_is_silly.append(to_take_over)

class eventHolder:    
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
    const SCORE_ANY = "SCORE"
    const SCORE_CHANGE = "SCORE-CHANGE"
    const SCORE_SELF = "SCORE-SELF"
    const SELL_ANY = "SELL"
    const SELL_SELF = "SELL-SELF"
    const SHOOT = "SHOOT"
    const SPAWN_ANY = "SPAWN-ANOTHER"
    const SPAWN_SELF = "SPAWN"
    const TRANSFORM_ANY = "TRANSFORM-ANOTHER"
    const TRANSFORM_SELF = "TRANSFORM"
    const UPGRADE_BALL_IN_SHOP = "UPGRADE-SHOP-BALL"
    
    const REROLL = "MULTRAPOOL_CUE_REROLL"
static var Events = eventHolder.new()

static var registeredEvents = {}
## Registers a callback to be run on some event[br][br]
##
## [param ball_id]: The id of the type of ball that should run this action[br]
## [param event]: A member of [eventHolder] (or a string, if you're using a custom event)[br]
## [param action]: A function that takes a [Ball], a dictionary of assorted values, and if it is the mixed side, and performs the event action[br]
## [param action] = func(ball:Ball, assorted:Dictionary, isMixedSide:bool)
static func register_ball_event(ball_id:String, event:String, action:Callable):
    if !registeredEvents.has(event):
        registeredEvents[event] = {}
    registeredEvents[event][ball_id] = action
    
## Gets the event for a ball[br][br]
##
## [param ball_id]: The id of the type of ball[br]
## [param event]: A member of [eventHolder] (or a string, if you're using a custom event)
## Returns the action that this ball will run, or null
static func get_ball_event(ball_id:String, event:String) -> Callable:
    if registeredEvents.has(event) and registeredEvents[event].has(ball_id):
        return registeredEvents[event][ball_id]
    return func(_a,_b,_c):return
    
    
## Checks if there is an event for a ball[br][br]
##
## [param ball_id]: The id of the type of ball[br]
## [param event]: A member of [eventHolder] (or a string, if you're using a custom event)
static func has_ball_event(ball_id:String, event:String) -> bool:
    if registeredEvents[event] == null:
        return false
    return registeredEvents[event][ball_id] != null
    
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
