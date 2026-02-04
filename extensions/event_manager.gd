extends Object

var CUE = load("res://mods-unpacked/Multrapool-Cue/cue.gd")

var Multrapool_which_time:=0

func run_event(chain: ModLoaderHookChain, event_name, extra1 = null, extra2 = null, delay_per_ball = 0):
    if CUE._events_to_suppress.has(event_name):
        return
    
    chain.execute_next([event_name, extra1, extra2, delay_per_ball])
    
    CUE.call_event(event_name, {extra1=extra1, extra2=extra2})
    
func run_event_shop(chain: ModLoaderHookChain, event_name, extra1 = null):
    if CUE._events_to_suppress.has(event_name):
        return
        
    chain.execute_next([event_name, extra1])
    
    CUE.call_event(event_name, {extra1=extra1})

# sad that i have to rewrite this but
func run_event_on_ball(_chain: ModLoaderHookChain, event_name, ball, extra1 = null, extra2 = null, ball_item = null, do_override_level = false, override_level = 1):
    if CUE._events_to_suppress.has(event_name):
        return
        
    if Global.gameManager.game_broken():
        return

    var ball_item_effect_source = null
    if ball != null:
        ball_item_effect_source = ball_item if ball_item != null else ball.ball_item

    if ball_item_effect_source != null:
        if ball_item_effect_source.has_id("AI-BRAIN"):
            Global.eventManager.run_on_reserve(event_name, ball, extra1, extra2)

    var times = 1
    if ball.is_on_fire():
        times = 2
        
    # todo: some modifier?

    var level = ball_item_effect_source.get_effect_level() if !do_override_level else override_level
    var effect_position = ball.global_position

    for i in times:
        Multrapool_which_time=i
        
        if i > 0:
            await Global.eventManager.wait_step(0.1)

        if event_name == "POCKET":
            Global.eventManager.run_effects_pocket(ball, ball_item_effect_source, extra1, level, effect_position)
            
        elif event_name == "POCKET-ANOTHER":
            Global.eventManager.run_effects_pocket_another(ball, ball_item_effect_source, extra1, level)

        elif event_name == "SPAWN":
            Global.eventManager.run_effects_spawn(ball, ball_item_effect_source, extra1, level)

        elif event_name == "ROUND-START":
            Global.eventManager.run_effects_start_round(ball, ball_item_effect_source, level)

        elif event_name == "HIT":
            Global.eventManager.run_effects_hit(ball, ball_item_effect_source, extra1, level)

        elif event_name == "HIT-WALL":
            Global.eventManager.run_effects_hit_wall(ball, ball_item_effect_source, level)

        elif event_name == "BUFF":
            Global.eventManager.run_effects_buff(ball, ball_item_effect_source, extra1, extra2, level)

        elif event_name == "SPAWN-ANOTHER":
            Global.eventManager.run_effects_spawn_another(ball, ball_item_effect_source, extra1, level)

        elif event_name == "SCORE":
            Global.eventManager.run_effects_score(ball, ball_item_effect_source, extra1, extra2, level)

        elif event_name == "GAIN-MONEY":
            Global.eventManager.run_effects_gain_money(ball, ball_item_effect_source, extra1, level)

        elif event_name == "ENTER-SHOP":
            Global.eventManager.run_effects_enter_shop(ball, ball_item_effect_source, level)

        elif event_name == "TRANSFORM":
            Global.eventManager.run_effects_transform(ball, ball_item_effect_source, level)

        elif event_name == "TRANSFORM-ANOTHER":
            Global.eventManager.run_effects_transform_another(ball, ball_item_effect_source, extra1, level)

        elif event_name == "PICKUP-DROPLET":
            Global.eventManager.run_effects_pickup_droplet(ball, ball_item_effect_source, level)

        elif event_name == "SCORE-CHANGE":
            Global.eventManager.run_effects_score_change(ball, ball_item_effect_source, extra1, level)

        elif event_name == "SHOOT":
            Global.eventManager.run_effects_shoot(ball, ball_item_effect_source, extra1, level)

        elif event_name == "REACH-SCORE":
            Global.eventManager.run_effects_reach_score(ball, ball_item_effect_source, level)

        elif event_name == "ROUND-END":
            Global.eventManager.run_effects_round_end(ball, ball_item_effect_source, level)

        elif event_name == "SCORE-SELF":#unused in vanilla
            run_effects_self_scored(ball, ball_item_effect_source, level, extra1, extra2)
            
        else:
            CUE.call_ball_event(ball, event_name,
                {source=ball_item_effect_source, effect_level=level, position=effect_position,
                    extra1=extra1, extra2=extra2})
            
func run_event_on_shop_ball(chain: ModLoaderHookChain, event_name, shop_ball, extra1 = null):
    if CUE._events_to_suppress.has(event_name):
        return
        
    chain.execute_next([event_name, shop_ball, extra1])
    Multrapool_which_time=0
    
    if event_name in [
        "UPGRADE-SHOP-BALL",
        "SELL",
        "SELL-SELF",
        "BUY-OTHER",
        "TRANSFORM-ANOTHER",
        "BUFF",
    ]: return # these events are already handled in vanilla
    
    CUE.call_ball_event(shop_ball, event_name,
        {source=shop_ball.ball_item, extra=extra1})

func run_effects_shoot(chain: ModLoaderHookChain, ball: Ball, ball_item, shot, level = 1):
    chain.execute_next([ball, ball_item, shot, level])
    CUE.call_ball_event(ball, CUE.Events.SHOOT, 
        {source=ball_item, effect_level=level})

func run_effects_reach_score(chain: ModLoaderHookChain, ball, ball_item, level = 1):
    chain.execute_next([ball, ball_item, level])
    CUE.call_ball_event(ball, CUE.Events.REACH_SCORE, 
        {source=ball_item, effect_level=level})

func run_effects_round_end(chain: ModLoaderHookChain, ball, ball_item, level = 1):
    chain.execute_next([ball, ball_item, level])
    CUE.call_ball_event(ball, CUE.Events.ROUND_END, 
        {source=ball_item, effect_level=level})

func run_effects_transform(chain: ModLoaderHookChain, ball, ball_item, level):
    chain.execute_next([ball, ball_item, level])
    CUE.call_ball_event(ball, CUE.Events.TRANSFORM_SELF, 
        {source=ball_item, effect_level=level, ball=ball})

func run_effects_transform_another(chain: ModLoaderHookChain, ball, ball_item, transformed_ball, level):
    chain.execute_next([ball, ball_item, transformed_ball, level])
    CUE.call_ball_event(ball, CUE.Events.TRANSFORM_ANY, 
        {source=ball_item, effect_level=level, transformed=transformed_ball})
    
func run_effects_pickup_droplet(chain: ModLoaderHookChain, ball, ball_item, level):
    chain.execute_next([ball, ball_item, level])
    CUE.call_ball_event(ball, CUE.Events.PICKUP_DROPLET, 
        {source=ball_item, effect_level=level})

func run_effects_score_change(chain: ModLoaderHookChain, ball, ball_item, amount, level):
    chain.execute_next([ball, ball_item, amount, level])
    CUE.call_ball_event(ball, CUE.Events.SELF_UPGRADE, 
        {source=ball_item, effect_level=level, amount=amount})

func run_effects_enter_shop(chain: ModLoaderHookChain, ball, ball_item, level):
    chain.execute_next([ball, ball_item, level])
    CUE.call_ball_event(ball, CUE.Events.ENTER_SHOP, 
        {source=ball_item, effect_level=level})

func run_effects_gain_money(chain: ModLoaderHookChain, ball, ball_item, amount, level):
    chain.execute_next([ball, ball_item, amount, level])
    CUE.call_ball_event(ball, CUE.Events.GAIN_MONEY, 
        {source=ball_item, effect_level=level, amount=amount})

func run_effects_score(chain: ModLoaderHookChain, ball, ball_item, amount, source_ball, level):
    chain.execute_next([ball, ball_item, amount, source_ball, level])
    CUE.call_ball_event(ball, CUE.Events.SELF_SCORED, 
        {source=ball_item, effect_level=level, amount=amount, source_ball=source_ball})

func run_effects_spawn_another(chain: ModLoaderHookChain, ball, ball_item, ball_spawned, level):
    chain.execute_next([ball, ball_item, ball_spawned, level])
    CUE.call_ball_event(ball, CUE.Events.SPAWN_ANY, 
        {source=ball_item, effect_level=level, ball_spawned=ball_spawned})

func run_effects_buff(chain: ModLoaderHookChain, ball, ball_item, amount, permanent, level):
    chain.execute_next([ball, ball_item, amount, permanent, level])
    CUE.call_ball_event(ball, CUE.Events.BUFF_SELF, 
        {source=ball_item, effect_level=level, amount=amount, permanent=permanent})
        
    Global.eventManager.run_event(CUE.Events.BUFF_ANY, ball)

func run_effects_hit_wall(chain: ModLoaderHookChain, ball, ball_item, level):
    chain.execute_next([ball, ball_item, level])
    CUE.call_ball_event(ball, CUE.Events.HIT_WALL, 
        {source=ball_item, effect_level=level})

func run_effects_hit(chain: ModLoaderHookChain, ball, ball_item, other_ball: Ball, level):
    chain.execute_next([ball, ball_item, other_ball, level])
    CUE.call_ball_event(ball, CUE.Events.HIT_BALL, 
        {source=ball_item, effect_level=level, other_ball=other_ball})

func run_effects_pocket(chain: ModLoaderHookChain, ball, ball_item: BallItem, pocket, level, effect_position):
    if CUE._events_to_suppress.has("POCKET-ANOTHER") and\
        CUE._events_to_suppress["POCKET-ANOTHER"] == "add_pocket_to_pocketed_any":
        CUE._events_to_suppress.erase("POCKET-ANOTHER")
        Global.eventManager.run_event("POCKET-ANOTHER", ball, pocket)
    
    chain.execute_next([ball, ball_item, pocket, level, effect_position])
    CUE.call_ball_event(ball, CUE.Events.POCKET_SELF, 
        {source=ball_item, effect_level=level, pocket=pocket, effect_position=effect_position})

func run_effects_spawn(chain: ModLoaderHookChain, ball, ball_item, mirror = false, level = 1):
    chain.execute_next([ball, ball_item, mirror, level])
    CUE.call_ball_event(ball, CUE.Events.SPAWN_SELF, 
        {source=ball_item, effect_level=level, is_mirror=mirror})

func run_effects_start_round(chain: ModLoaderHookChain, ball, ball_item, level = 1):
    chain.execute_next([ball, ball_item, level])
    CUE.call_event(CUE.Events.ROUND_START, {})
    CUE.call_ball_event(ball, CUE.Events.ROUND_START, 
        {source=ball_item, effect_level=level})

func run_effects_pocket_another(chain: ModLoaderHookChain, ball, ball_item, ball_pocketed, level = 1):
    chain.execute_next([ball, ball_item, ball_pocketed, level])
    CUE.call_ball_event(ball, CUE.Events.POCKET_ANY, 
        {source=ball_item, effect_level=level, ball_pocketed=ball_pocketed})

func run_effects_shop_upgrade(chain: ModLoaderHookChain, shop_ball, ball_item, which_ball):
    chain.execute_next([shop_ball, ball_item, which_ball])
    CUE.call_ball_event(shop_ball, CUE.Events.UPGRADE_BALL_IN_SHOP, 
        {source=ball_item, which_ball=which_ball})

func run_effects_shop_sell(chain: ModLoaderHookChain, shop_ball, ball_item, ball_sold):
    chain.execute_next([shop_ball, ball_item, ball_sold])
    CUE.call_ball_event(shop_ball, CUE.Events.SELL_ANY, 
        {source=ball_item, ball_sold=ball_sold})

func run_effects_shop_sell_self(chain: ModLoaderHookChain, shop_ball, ball_item):
    chain.execute_next([shop_ball, ball_item])
    CUE.call_ball_event(shop_ball, CUE.Events.SELL_SELF, 
        {source=ball_item})

func run_effects_shop_buy_other(chain: ModLoaderHookChain, shop_ball, ball_item, ball_bought):
    chain.execute_next([shop_ball, ball_item, ball_bought])
    CUE.call_ball_event(shop_ball, CUE.Events.BUY_ANY, 
        {source=ball_item, ball_bought=ball_bought})


func run_effects_self_scored(ball:Ball, ball_item, level, amount, isFinal):
    CUE.call_ball_event(ball, CUE.Events.SELF_SCORED, 
        {source=ball_item, effect_level=level, amount=amount, isFinal=isFinal})
