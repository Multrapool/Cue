class_name Multrapool_LibGallery extends Node

var GALLERY_LOAD_CALLBACKS:Array[Callable] = []
## [param callback] should be of form[br]
## [code]func(galleryNode:Node2D) -> void[/code][br]
## The Node2D will the the root node in [url]res://gallery.tscn[/url]
func gallery_load_callback(callback:Callable):
    GALLERY_LOAD_CALLBACKS.append(callback)

func add_container_to_gallery(to_add:PanelContainer):
    gallery_load_callback(func(galleryNode:Node2D):
        galleryNode.get_node("TabManager/ShopBalls/ScrollContainer/MarginContainer/VBoxContainer/")\
            .add_child(to_add))
        
