extends Control


var switching_target = UIEnum.BRIEFING

var pending_weapon_type: WorkshopSystem.WEAPON
var pending_weapon_price: int

var pending_upgrade_type: WorkshopSystem.UP
var pending_upgrade_price: int

var confirm_template: String = "Are you sure you want to buy:\n%s - %s ?"
var spec_template: String = (
	"Tank speed: %s mph\n"
	+ "Defensive armor: %s %%\n"
	+ "Weapon damage power: %s\n"
	+ "Reload time: %s sec"
)

@onready var weapon_panel: WeaponPanel = $blue_box_titled/hbox/right_panel/weapon_panel
@onready var upgrade_panel: UpgradePanel = $blue_box_titled/hbox/left_panel/upgrade_panel


func update_spec():
	var weapon_idx = UserState.selected_weapon_idx
	var damage_up = UserState.upgrades[WorkshopSystem.UP.DAMAGE]
	var reload_up = UserState.upgrades[WorkshopSystem.UP.RELOAD]
	
	var speed = WorkshopSystem.raw_speed[UserState.upgrades[WorkshopSystem.UP.MOVE]]
	var armor = WorkshopSystem.raw_armor[UserState.upgrades[WorkshopSystem.UP.ARMOR]]
	var damage = WorkshopSystem.bullet_damage[weapon_idx][damage_up]
	var reload = WorkshopSystem.bullet_reload[weapon_idx][reload_up]
	
	$blue_box_titled/hbox/vbox/spec_panel/spec_label.text = spec_template % [
		speed, armor, damage, reload
	]


func update_ui():
	update_spec()
	
	# update money
	$blue_box_titled/hbox/vbox/money_label.text = "Money %s" % UserState.money
	
	# update preview
	$blue_box_titled/hbox/vbox/white_box/subview_container/subview/workshop_view.reload_loadout()


func _ready():
	update_ui()


func _on_ok_button_button_clicked():
	UISignals.request_ui.emit(switching_target)
	MapSignals.update_player_loadout.emit()
	UserState.save_json()


func _on_upgrade_panel_purchase_requested(type_enum, price, upgrade_name):
	pending_upgrade_type = type_enum
	pending_upgrade_price = price
	
	$confirm_upgrade.show()
	$confirm_upgrade/yellow_box_titled/text.text = confirm_template % ["upgrade", upgrade_name]


func _on_weapon_panel_purchase_requested(type_enum, price, weapon_name):
	pending_weapon_type = type_enum
	pending_weapon_price = price
	
	$confirm_weapon.show()
	$confirm_weapon/yellow_box_titled/text.text = confirm_template % ["weapon", weapon_name]


func _on_weapon_panel_select_requested(type_enum):
	UserState.selected_weapon_idx = type_enum
	
	weapon_panel.trigger_update()
	update_ui()


func _on_weapon_ok_button_button_clicked():
	UserState.weapons[pending_weapon_type] = 1
	UserState.selected_weapon_idx = pending_weapon_type
	UserState.money -= pending_weapon_price
	
	weapon_panel.trigger_update()
	upgrade_panel.trigger_update()
	update_ui()
	
	$confirm_weapon.hide()


func _on_weapon_no_button_button_clicked():
	$confirm_weapon.hide()


func _on_upgrade_ok_button_button_clicked():
	UserState.upgrades[pending_upgrade_type] += 1
	UserState.money -= pending_upgrade_price
	
	upgrade_panel.trigger_update()
	weapon_panel.trigger_update()
	update_ui()
	
	$confirm_upgrade.hide()


func _on_upgrade_no_button_button_clicked():
	$confirm_upgrade.hide()
