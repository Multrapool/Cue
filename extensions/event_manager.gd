extends Object

var CUE := load("res://mods-unpacked/Multrapool-Cue/cue.gd")

func run_effects_pocket(chain: ModLoaderHookChain, ball, ball_item: BallItem, pocket, level, effect_position, side, ball_id):
    CUE.call_event(CUE.Events.POCKET, {
        ball=ball,
        ball_item=ball_item,
        pocket=pocket,
        level=level,
        effect_position=effect_position,
        side=side,
        ball_id=ball_id
    })
    chain.execute_next([ball, ball_item, pocket, level, effect_position, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.POCKET, {
        ball=ball,
        ball_item=ball_item,
        pocket=pocket,
        level=level,
        effect_position=effect_position,
        side=side,
        ball_id=ball_id
    })
    
func run_effects_pocket_another(chain: ModLoaderHookChain, ball, ball_item, ball_pocketed: Ball, pocket, level = 1, side = 0, ball_id = ""):
    CUE.call_event(CUE.Events.POCKET_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        pocket=pocket,
        level=level,
        side=side,
        ball_id=ball_id
    })
    chain.execute_next([ball, ball_item, pocket, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.POCKET_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        pocket=pocket,
        level=level,
        side=side,
        ball_id=ball_id
    })
    
func run_effects_spawn(chain: ModLoaderHookChain, ball, ball_item, spawn_effect_source, level, side, ball_id):
    CUE.call_event(CUE.Events.SPAWN, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        spawn_effect_source=spawn_effect_source,
    })
    chain.execute_next([ball, ball_item, spawn_effect_source, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.SPAWN, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        spawn_effect_source=spawn_effect_source,
    })

func run_effects_start_round(chain: ModLoaderHookChain, ball, ball_item, level = 1, side = 0, ball_id = ""):
    CUE.call_event(CUE.Events.ROUND_START, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.ROUND_START, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    
func run_effects_hit(chain: ModLoaderHookChain, ball, ball_item, other_ball: Ball, level, side, ball_id):
    CUE.call_event(CUE.Events.HIT, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        other_ball=other_ball,
    })
    chain.execute_next([ball, ball_item, other_ball, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.HIT, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        other_ball=other_ball,
    })
    
func run_effects_hit_wall(chain: ModLoaderHookChain, ball, ball_item, level, side, ball_id):
    CUE.call_event(CUE.Events.HIT_WALL, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.HIT_WALL, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    
func run_effects_buff(chain: ModLoaderHookChain, ball, ball_item, amount, is_moss, level, side, ball_id):
    CUE.call_event(CUE.Events.BUFF, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        amount=amount,
        is_moss=is_moss,
    })
    chain.execute_next([ball, ball_item, amount, is_moss, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.BUFF, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        amount=amount,
        is_moss=is_moss,
    })
    
func run_effects_spawn_another(chain: ModLoaderHookChain, ball, ball_item, ball_spawned, level, side, ball_id):
    CUE.call_event(CUE.Events.SPAWN_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        ball_spawned=ball_spawned,
    })
    chain.execute_next([ball, ball_item, ball_spawned, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.SPAWN_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        ball_spawned=ball_spawned,
    })
    
func run_effects_score(chain: ModLoaderHookChain, ball, ball_item, amount, source_ball, level, side, ball_id):
    CUE.call_event(CUE.Events.SCORE, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        amount=amount,
        source_ball=source_ball,
    })
    chain.execute_next([ball, ball_item, amount, source_ball, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.SCORE, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        amount=amount,
        source_ball=source_ball,
    })
    
func run_effects_transform(chain: ModLoaderHookChain, ball, ball_item, level, side, ball_id):
    CUE.call_event(CUE.Events.TRANSFORM, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.TRANSFORM, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    
func run_effects_transform_another(chain: ModLoaderHookChain, ball, ball_item, transformed_ball, level, side, ball_id):
    CUE.call_event(CUE.Events.TRANSFORM_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        transformed_ball=transformed_ball,
    })
    chain.execute_next([ball, ball_item, transformed_ball, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.TRANSFORM_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        transformed_ball=transformed_ball,
    })
    
func run_effects_pickup_droplet(chain: ModLoaderHookChain, ball, ball_item, level, side, ball_id):
    CUE.call_event(CUE.Events.PICKUP_DROPLET, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.PICKUP_DROPLET, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    
func run_effects_score_change(chain: ModLoaderHookChain, ball, ball_item, amount, level, side, ball_id):
    CUE.call_event(CUE.Events.SCORE_CHANGE, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        amount=amount,
    })
    chain.execute_next([ball, ball_item, amount, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.SCORE_CHANGE, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        amount=amount,
    })
    
func run_effects_shoot(chain: ModLoaderHookChain, ball, ball_item, shot, level, side, ball_id):
    CUE.call_event(CUE.Events.SHOOT, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        shot=shot,
    })
    chain.execute_next([ball, ball_item, shot, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.SHOOT, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        shot=shot,
    })
    
func run_effects_reach_score(chain: ModLoaderHookChain, ball, ball_item, level, side, ball_id):
    CUE.call_event(CUE.Events.REACH_SCORE, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.REACH_SCORE, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })

func run_effects_round_end(chain: ModLoaderHookChain, ball, ball_item, level, side, ball_id):
    CUE.call_event(CUE.Events.ROUND_END, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.ROUND_END, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    
func run_effects_max_roll(chain: ModLoaderHookChain, ball, ball_item, rolled_ball, level, side, ball_id):
    CUE.call_event(CUE.Events.MAX_ROLL, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        rolled_ball=rolled_ball,
    })
    chain.execute_next([ball, ball_item, rolled_ball, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.MAX_ROLL, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        rolled_ball=rolled_ball,
    })
    
func run_effects_shop_upgrade(chain: ModLoaderHookChain, ball, ball_item, which_ball, level, side, ball_id):
    CUE.call_event(CUE.Events.UPGRADE_BALL, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        which_ball=which_ball
    })
    chain.execute_next([ball, ball_item, which_ball, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.UPGRADE_BALL, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        which_ball=which_ball
    })
    
func run_effects_enter_shop(chain: ModLoaderHookChain, ball, ball_item, level, side, ball_id):
    CUE.call_event(CUE.Events.ENTER_SHOP, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.ENTER_SHOP, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    
func run_effects_shop_sell(chain: ModLoaderHookChain, ball, ball_item, ball_sold, level, side, ball_id):
    CUE.call_event(CUE.Events.SELL_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        ball_sold=ball_sold
    })
    chain.execute_next([ball, ball_item, ball_sold, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.SELL_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        ball_sold=ball_sold
    })
    
func run_effects_shop_reroll(chain: ModLoaderHookChain, ball, ball_item, ball_sold, level, side, ball_id):
    CUE.call_event(CUE.Events.REROLL_SHOP, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        #unused=ball_sold
    })
    chain.execute_next([ball, ball_item, ball_sold, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.REROLL_SHOP, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        #unused=ball_sold
    })
    
func run_effects_shop_sell_self(chain: ModLoaderHookChain, ball, ball_item, level, side, ball_id):
    CUE.call_event(CUE.Events.SELL_SELF, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })
    chain.execute_next([ball, ball_item, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.SELL_SELF, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
    })

func run_effects_shop_buy(chain: ModLoaderHookChain, ball, ball_item, mixed_into, level, side, ball_id):
    CUE.call_event(CUE.Events.BUY, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        mixed_into=mixed_into
    })
    chain.execute_next([ball, ball_item, mixed_into, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.BUY, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        mixed_into=mixed_into
    })
    
func run_effects_shop_buy_another(chain: ModLoaderHookChain, ball, ball_item, ball_bought, mixed_into, level, side, ball_id):
    CUE.call_event(CUE.Events.BUY_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        mixed_into=mixed_into,
        ball_bought=ball_bought
    })
    chain.execute_next([ball, ball_item, ball_bought, mixed_into, level, side, ball_id])
    CUE.call_ball_event(ball, CUE.Events.BUY_ANOTHER, {
        ball=ball,
        ball_item=ball_item,
        level=level,
        side=side,
        ball_id=ball_id,
        mixed_into=mixed_into,
        ball_bought=ball_bought
    })
