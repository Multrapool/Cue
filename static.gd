class_name Multrapool_Cue

static var virtual_files:Array = []

static var global_thingy_bc_godot_is_silly: Array = []
static func take_over(modName:String, path:String):
    var to_take_over = load("res://mods-unpacked/"+modName+"/overwrites/"+path)
    to_take_over.take_over_path("res://"+path)
    virtual_files.append("res://"+path)
    global_thingy_bc_godot_is_silly.append(to_take_over)
