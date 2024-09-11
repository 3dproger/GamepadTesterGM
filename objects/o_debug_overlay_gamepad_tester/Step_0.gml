if (!dbg_view_exists(view))
{
	return;
}

function get_button_text(_device, _button)
{
	var _check = gamepad_button_check(_device, _button);
	var _value = gamepad_button_value(_device, _button)
	var _result = _check ? "true" : "false";
	_result += " (" + string_format(_value, 0, 5) + ")";
	return _result;
}

v_gamepad_is_supported = gamepad_is_supported();
v_gamepad_get_device_count = gamepad_get_device_count();

v_actual_connected = 0;

var _need_recreate_dbg = false;

if (array_length(gamepads) != v_gamepad_get_device_count)
{
	_need_recreate_dbg = true;
	array_resize(gamepads, v_gamepad_get_device_count);
	
	for (var _i = 0; _i < v_gamepad_get_device_count; ++_i)
	{
		gamepads[_i] = {};
	}
}

for (var _i = 0; _i < v_gamepad_get_device_count; ++_i)
{
	var _gp = gamepads[_i];
	var _connected = gamepad_is_connected(_i);
	
	if (!variable_struct_exists(_gp, "connected"))
	{
		struct_set(_gp, "connected", false);
	}
	
	if (_connected != _gp.connected)
	{
		_need_recreate_dbg = true;
	}
	
	struct_set(_gp, "connected", _connected);
	
	if (_connected)
	{
		v_actual_connected++;
		
		struct_set(_gp, "description", gamepad_get_description(_i));
		
		struct_set(_gp, "gp_padu", get_button_text(_i, gp_padu));
		struct_set(_gp, "gp_padr", get_button_text(_i, gp_padr));
		struct_set(_gp, "gp_padd", get_button_text(_i, gp_padd));
		struct_set(_gp, "gp_padl", get_button_text(_i, gp_padl));
		
		struct_set(_gp, "gp_face1", get_button_text(_i, gp_face1));
		struct_set(_gp, "gp_face2", get_button_text(_i, gp_face2));
		struct_set(_gp, "gp_face3", get_button_text(_i, gp_face3));
		struct_set(_gp, "gp_face4", get_button_text(_i, gp_face4));
		
		struct_set(_gp, "gp_shoulderlb", get_button_text(_i, gp_shoulderlb));
		struct_set(_gp, "gp_shoulderrb", get_button_text(_i, gp_shoulderrb));
		struct_set(_gp, "gp_shoulderl", get_button_text(_i, gp_shoulderl));
		struct_set(_gp, "gp_shoulderr", get_button_text(_i, gp_shoulderr));
		
		struct_set(_gp, "gp_start", get_button_text(_i, gp_start));
		struct_set(_gp, "gp_select", get_button_text(_i, gp_select));
		struct_set(_gp, "gp_home", get_button_text(_i, gp_home));
		struct_set(_gp, "gp_touchpadbutton", get_button_text(_i, gp_touchpadbutton));
		
		struct_set(_gp, "gp_stickl", get_button_text(_i, gp_stickl));
		struct_set(_gp, "gp_stickr", get_button_text(_i, gp_stickr));
		
		struct_set(_gp, "gp_paddler", get_button_text(_i, gp_paddler));
		struct_set(_gp, "gp_paddlel", get_button_text(_i, gp_paddlel));
		struct_set(_gp, "gp_paddlerb", get_button_text(_i, gp_paddlerb));
		struct_set(_gp, "gp_paddlelb", get_button_text(_i, gp_paddlelb));
		
		struct_set(_gp, "gp_extra1", get_button_text(_i, gp_extra1));
		struct_set(_gp, "gp_extra2", get_button_text(_i, gp_extra2));
		struct_set(_gp, "gp_extra3", get_button_text(_i, gp_extra3));
		struct_set(_gp, "gp_extra4", get_button_text(_i, gp_extra4));
		struct_set(_gp, "gp_extra5", get_button_text(_i, gp_extra5));
		struct_set(_gp, "gp_extra6", get_button_text(_i, gp_extra6));
		
		struct_set(_gp, "gp_axislh", gamepad_axis_value(_i, gp_axislh));
		struct_set(_gp, "gp_axislv", gamepad_axis_value(_i, gp_axislv));
		struct_set(_gp, "gp_axisrh", gamepad_axis_value(_i, gp_axisrh));
		struct_set(_gp, "gp_axisrv", gamepad_axis_value(_i, gp_axisrv));
		
		struct_set(_gp, "hat_count", gamepad_hat_count(_i));
		struct_set(_gp, "axis_deadzone", gamepad_get_axis_deadzone(_i));
	}
}

if (_need_recreate_dbg)
{
	recreate_debug_view();
}
