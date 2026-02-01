extends "res://main_menu.gd"

func spawn_ball():
    if not balls.any(func(ball): return ball.has_id("MULTRAPOOL_LOGO")):
        var pos = (top_left.global_position + bottom_right.global_position) / 2\
            + Vector2(0, 35)
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

func _ready() -> void :
    super()
    
    $CanvasLayer.visible = true
    $CanvasLayer/ExitButton.visible = false # remove this on mobile
    $CanvasLayer.add_child(preload("res://mods-unpacked/Multrapool-Cue/version_number.tscn")\
        .instantiate())
    $CanvasLayer/VersionNumber/LabelT.text = "Multraball Version " + \
        preload("res://mods-unpacked/Multrapool-Cue/static.gd").CUE_VERSION
