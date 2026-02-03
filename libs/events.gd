class_name Multrapool_LibMiscEvents extends Node

var ROUND_START_CALLBACKS:Array[Callable] = []
## [param callback] should be of form[br]
## [code]func() -> void[/code][br]
func round_start_callback(callback:Callable):
    ROUND_START_CALLBACKS.append(callback)
