extends Node

var mod_dir_path := ""

var CUE := load("res://mods-unpacked/Multrapool-Cue/cue.gd")

func _init() -> void:
    CUE.CUE_VERSION = ModLoaderMod.get_mod_data(CUE.MOD_NAME).manifest.version_number
    mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(CUE.MOD_NAME)
    
    # Add extensions
    install_script_extensions()
    install_script_hook_files()
    
    CUE.take_over(CUE.MOD_NAME, "data/balls_data/multrapool_logo.tres")
    
    ModLoaderMod.add_translation(mod_dir_path.path_join("Multrapool.en.translation"))
    
    CUE._create_singletons(self)

    ModLoaderLog.info("Initialized :3", CUE.MOD_NAME)

func install_script_extensions() -> void:
    var extensions_dir_path = mod_dir_path.path_join("extensions")
    ModLoaderMod.install_script_extension(extensions_dir_path + "/Global.gd")

func install_script_hook_files() -> void:
    ModLoaderMod.add_hook(get_all_files_hook, "res://utils/utils.gd", "get_all_files_with_extension")
    ModLoaderMod.add_hook(on_reroll_hook, "res://ui/shop.gd", "_on_reroll_button_pressed")
    ModLoaderMod.add_hook(play_new_round_hook, "res://Game.gd", "play_new_round")
    ModLoaderMod.install_script_hooks("res://event_manager.gd", "res://mods-unpacked/Multrapool-Cue/extensions/event_manager.gd")
    ModLoaderMod.install_script_hooks("res://droplet.gd", "res://mods-unpacked/Multrapool-Cue/extensions/droplet.gd")
    ModLoaderMod.install_script_hooks("res://ball.gd", "res://mods-unpacked/Multrapool-Cue/extensions/ball.gd")

func _ready() -> void:
    ModLoaderLog.info("Ready", CUE.MOD_NAME)
    #ModLoaderLog.info("Translation Demo: " + tr("MODNAME_READY_TEXT"), LOG_NAME)

###

func get_all_files_hook(chain: ModLoaderHookChain, path: String, extension: String) -> Array[String]:
    var orig = chain.execute_next([path, extension])
    
    for file_path in CUE.virtual_files:
        if file_path.begins_with(path):
            orig.append(file_path)
    
    return orig
    
func on_reroll_hook(chain: ModLoaderHookChain) -> void:
    var old_rerolled = Global.shopManager.times_rerolled
    chain.execute_next([])
    if old_rerolled+1 == Global.shopManager.times_rerolled:
        Global.eventManager.run_event_shop(CUE.BallEvents.REROLL) 
        CUE.call_event(CUE.Events.REROLL, {})

func play_new_round_hook(chain: ModLoaderHookChain):
    await chain.execute_next_async([])
    CUE.call_event(CUE.Events.ROUND_START, {})
    
