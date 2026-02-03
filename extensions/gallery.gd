extends "res://gallery.gd"

var CUE := preload("res://mods-unpacked/Multrapool-Cue/cue.gd")

func _ready() -> void :
    super()
    for callback in CUE.GALLERY.GALLERY_LOAD_CALLBACKS:
        callback.call(self)
    
