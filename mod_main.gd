extends Node

const CUE = preload("res://mods-unpacked/Multrapool-Cue/static.gd")

var mod_dir_path := ""
var extensions_dir_path := ""

func _init() -> void:
    mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(CUE.MOD_NAME)
    extensions_dir_path = mod_dir_path.path_join("extensions")

    # Add extensions
    install_script_extensions()
    install_script_hook_files()
    
    CUE.take_over(CUE.MOD_NAME, "data/balls_data/multrapool_logo.tres")
    CUE.take_over(CUE.MOD_NAME, "icon.png")

    ModLoaderMod.add_translation(mod_dir_path.path_join("Multrapool.en.translation"))
    
    ModLoaderLog.info("Init", CUE.MOD_NAME)

func install_script_extensions() -> void:
    ModLoaderMod.install_script_extension(extensions_dir_path + "/main_menu.gd")

func install_script_hook_files() -> void:
    ModLoaderMod.add_hook(get_all_files_hook, "res://utils/utils.gd", "get_all_files_with_extension")

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
