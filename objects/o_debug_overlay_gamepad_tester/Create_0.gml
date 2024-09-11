if (os_browser != browser_not_a_browser)
{
	show_debug_message("This is not supported in browsers");
	instance_destroy(id);
	exit;
}

v_gamepad_is_supported = false;
v_gamepad_get_device_count = 0;
v_actual_connected = 0;

gamepads = [];

view = pointer_null;

function recreate_debug_view()
{
	show_debug_message("recreate_debug_view")
	
	if (dbg_view_exists(view))
	{
		dbg_view_delete(view);
	}
	
	view = dbg_view("Gamepad tester", true);

	dbg_section("Global info", true);
	dbg_watch(ref_create(self, "v_gamepad_is_supported"), "gamepad_is_supported");
	dbg_watch(ref_create(self, "v_gamepad_get_device_count"), "gamepad_get_device_count");
	dbg_watch(ref_create(self, "v_actual_connected"), "Actual connected devices");
	
	for (var _gamepad_index = 0; _gamepad_index < array_length(gamepads); ++_gamepad_index)
	{
		var _gp = gamepads[_gamepad_index];
		if (struct_get(_gp, "connected"))
		{
			var _is_xinput = _gamepad_index <= 3;
			
			var _caption = "Gamepad[" + string(_gamepad_index);
			
			if (os_type == os_windows && os_browser == browser_not_a_browser)
			{
				if (_is_xinput)
				{
					_caption += ", XInput";
				}
				else
				{
					_caption += ", DInput";
				}
			}

			_caption += "]: " + _gp.description;
			
			dbg_section(_caption, _gp.connected);
			
			var _names = variable_struct_get_names(_gp);
			var _names_count = variable_struct_names_count(_gp);
			for (var _name_index = 0; _name_index < _names_count; ++_name_index)
			{
				var _name = _names[_name_index];
				if (_name == "connected" || _name == "description")
				{
					continue;
				}
				
				dbg_watch(ref_create(_gp, _name), _name);
			}
		}
	}
}

recreate_debug_view()
