extends StateMachine

signal change_target
signal enemy_turn
signal move_cursor
signal new_menu
signal option_selected
signal use_skill
signal unselect_all

func _on_CommitAction_use_skill(node_name: String) -> void:
	emit_signal("use_skill", node_name)

func _on_EnemyTurn_enemy_turn():
	emit_signal("enemy_turn")

func _on_Menu_State_move_cursor(direction: Vector2) -> void:
	emit_signal("move_cursor", direction)

func _on_Menu_State_new_menu(menu_name: String) -> void:
	emit_signal("new_menu", menu_name)

func _on_Menu_State_option_selected() -> void:
	emit_signal("option_selected")

func _on_SelectTarget_change_target(increment: int = 0) -> void:
	emit_signal("change_target", increment)

func _on_SelectTarget_unselect_all() -> void:
	emit_signal("unselect_all")
