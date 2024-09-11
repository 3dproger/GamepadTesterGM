if (keyboard_check_pressed(vk_enter))
{
	if (!instance_exists(o_debug_overlay_gamepad_tester))
	{
		instance_create_depth(0, 0, depth, o_debug_overlay_gamepad_tester);
	}
}