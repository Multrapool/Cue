extends "res://Global.gd"


func _ready() -> void:
    super()
    Multrapool_Cue_InitMainMenu(get_node("/root/MainMenu"))
    

func Multrapool_Cue_InitMainMenu(scene:Node):
    var canvas = scene.get_node("CanvasLayer")
    var version_number = load("res://mods-unpacked/Multrapool-Cue/version_number.tscn")\
        .instantiate()
    var CUE = load("res://mods-unpacked/Multrapool-Cue/cue.gd")
    version_number.get_node("LabelT").text = "Cue Version " + \
        CUE.CUE_VERSION+" "+CUE.CUE_ERA
    
    if not Global.is_mobile(): # this already happens on mobile
        canvas.visible = true
        canvas.get_node("ExitButton").visible = false
    
    canvas.add_child(version_number)
    
    var old = {
        ball_scene=scene.ball_scene,
        play_button=scene.play_button,
        top_left=scene.top_left,
        bottom_right=scene.bottom_right,
    }
    scene.set_script(load("res://mods-unpacked/Multrapool-Cue/extensions/main_menu.gd"))
    scene.Multrapool_Cue_InheritVariables(old)
    
func Multrapool_Cue_InitGallery(scene:Node):
    scene.set_script(load("res://mods-unpacked/Multrapool-Cue/extensions/gallery.gd"))
    
    
func go_to_main_menu():
    super()
    get_node("/root/").child_entered_tree.connect(
        Multrapool_Cue_InitMainMenu, CONNECT_ONE_SHOT)
    
func go_to_gallery():
    super()
    get_node("/root/").child_entered_tree.connect(
        Multrapool_Cue_InitGallery, CONNECT_ONE_SHOT)
