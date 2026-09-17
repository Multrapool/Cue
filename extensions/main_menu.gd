extends "res://main_menu.gd"

func Multrapool_Cue_InheritVariables(old_vars:Dictionary):
    ball_scene=old_vars.ball_scene
    play_button=old_vars.play_button
    top_left=old_vars.top_left
    bottom_right=old_vars.bottom_right

func spawn_ball():
    if not balls.any(func(ball): return ball.has_id("MULTRAPOOL_LOGO")):
        var pos = (top_left.global_position + bottom_right.global_position) / 2\
            + Vector2(-3.5, 33)
        var ball = ball_scene.instantiate()
        add_child(ball)

        var ball_data = BallDatabase.get_ball_by_id("MULTRAPOOL_LOGO")

        var ball_item = BallItem.new()
        ball_item.data = ball_data
        ball_item.base_score = 1

        ball.set_item(ball_item)

        ball.ball_init()
        ball.respawn(pos)
        ball.flash()

        ball.set_display_main_menu()
        
        balls.append(ball)
    else:
        super()
