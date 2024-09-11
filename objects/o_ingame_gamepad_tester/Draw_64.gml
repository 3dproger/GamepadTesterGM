if (font != noone)
{
	draw_set_font(font);
}

var _gamepad_is_supported = gamepad_is_supported();
var _gamepad_get_device_count = gamepad_get_device_count();
var _probably_connected_count = 0;

for (var _device = 0; _device < _gamepad_get_device_count; ++_device)
{
	if (gamepad_is_connected(_device))
	{
		_probably_connected_count++;
	}
}

var _x = 0;
var _y = 20;

function draw_button_text(_x, _y, _device, _name, _button)
{
	var _check = gamepad_button_check(_device, _button);
	var _value = gamepad_button_value(_device, _button)
	var _text = _check ? "true" : "false";
	_text += " (" + string_format(_value, 0, 5) + ")";
	
	_text = _name + ": " + _text;
	
	if (_check)
	{
		draw_set_color(c_lime);
	}
	else
	{
		if (_value == 0)
		{
			draw_set_color(c_gray);
		}
		else
		{
			draw_set_color(c_orange);
		}
	}
	
	draw_text(_x, _y, _text);
}

function draw_axis_text(_x, _y, _device, _name, _axis)
{
	var _value = gamepad_axis_value(_device, _axis);
	var _text = _name + ": " + string_format(_value, 0, 5);
	if (_value == 0)
	{
		draw_set_color(c_gray);
	}
	else
	{
		draw_set_color(c_lime);
	}
	draw_text(_x, _y, _text);
}

draw_set_color(c_white);

draw_text(_x, _y, "gamepad_is_supported: " + (_gamepad_is_supported ? "true" : "false")); _y += string_height("_");
draw_text(_x, _y, "gamepad_get_device_count: " + string(_gamepad_get_device_count)); _y += string_height("_");
draw_text(_x, _y, "Probably connected: " + string(_probably_connected_count)); _y += string_height("_");

for (var _device = 0; _device < _gamepad_get_device_count; ++_device)
{
	if (!gamepad_is_connected(_device))
	{
		continue;
	}
	
	draw_set_color(c_white);
	
	_x = 0;
	
	_y += string_height("_");
	var _caption = "Gamepad[" + string(_device) + "]: \"" + gamepad_get_description(_device) + "\"";
	
	if (os_type == os_windows && os_browser == browser_not_a_browser)
	{
		var _type = _device <= 3 ? "XInput" : "DInput";
		_caption += ", type: " + _type;
	}
	
	draw_text(_x, _y, _caption); _y += string_height("_");
	
	{
		_x = 0;
		var _category_y = _y;
		draw_axis_text(_x, _category_y, _device, "gp_axislh", gp_axislh); _category_y += string_height("_");
		draw_axis_text(_x, _category_y, _device, "gp_axislv", gp_axislv); _category_y += string_height("_");
		draw_axis_text(_x, _category_y, _device, "gp_axisrh", gp_axisrh); _category_y += string_height("_");
		draw_axis_text(_x, _category_y, _device, "gp_axisrv", gp_axisrv); _category_y += string_height("_");
	}

	{
		_x = 130;
		var _category_y = _y;
		draw_button_text(_x, _category_y, _device, "gp_padu", gp_padu); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_padr", gp_padr); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_padd", gp_padd); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_padl", gp_padl); _category_y += string_height("_");
	}
	
	{
		_x = 300;
		var _category_y = _y;
		draw_button_text(_x, _category_y, _device, "gp_face1", gp_face1); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_face2", gp_face2); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_face3", gp_face3); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_face4", gp_face4); _category_y += string_height("_");
	}
	
	{
		_x = 490;
		var _category_y = _y;
		draw_button_text(_x, _category_y, _device, "gp_shoulderlb", gp_shoulderlb); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_shoulderrb", gp_shoulderrb); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_shoulderl", gp_shoulderl); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_shoulderr", gp_shoulderr); _category_y += string_height("_");
	}
	
	{
		_x = 700;
		var _category_y = _y;
		draw_button_text(_x, _category_y, _device, "gp_start", gp_start); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_select", gp_select); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_home", gp_home); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_touchpadbutton", gp_touchpadbutton); _category_y += string_height("_");
	}
	
	{
		_x = 920;
		var _category_y = _y;
		draw_button_text(_x, _category_y, _device, "gp_stickl", gp_stickl); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_stickr", gp_stickr); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_extra1", gp_extra1); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_extra2", gp_extra2); _category_y += string_height("_");
	}
	
	{
		_x = 1100;
		var _category_y = _y;
		draw_button_text(_x, _category_y, _device, "gp_extra3", gp_extra3); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_extra4", gp_extra4); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_extra5", gp_extra5); _category_y += string_height("_");
		draw_button_text(_x, _category_y, _device, "gp_extra6", gp_extra6); _category_y += string_height("_");
	}
	
	_y += string_height("_") * 4;
}
