extends "res://Global.gd"

func Multrapool_Cue_InitMainMenu(scene:Node):
    var canvas = scene.get_node("CanvasLayer")
    var version_number = preload("res://mods-unpacked/Multrapool-Cue/version_number.tscn")\
        .instantiate()
    var CUE = preload("res://mods-unpacked/Multrapool-Cue/cue.gd")
    version_number.get_node("LabelT").text = "Cue Version " + \
        CUE.CUE_VERSION+" "+CUE.CUE_ERA
    
    if not Global.is_mobile(): # this already happens on mobile
        canvas.visible = true
        canvas.get_node("ExitButton").visible = false
    
    canvas.add_child(version_number)
    
    var old_vars := {
        ball_scene=scene.ball_scene,
        play_button=scene.play_button,
        top_left=scene.top_left,
        bottom_right=scene.bottom_right,
    }
    scene.set_script(preload("res://mods-unpacked/Multrapool-Cue/extensions/main_menu.gd"))
    scene.Multrapool_Cue_InheritVariables(old_vars)
    
func _ready() -> void:
    super()
    Multrapool_Cue_InitMainMenu(get_node("/root/MainMenu"))
    
func go_to_main_menu():
    super() # get_tree().change_scene_to_packed(SCENE_GAME)
    get_node("/root/").child_entered_tree.connect(
        Multrapool_Cue_InitMainMenu, CONNECT_ONE_SHOT)
        
    super()
