package flixel.addons.input;

class FlxRepeatInput<T> extends flixel.input.FlxInput<T>
{
	var timer:Float = 0;
	var prevTimer:Float = 0;

	public function triggerRepeat(initial:Float, repeat:Float):Bool
	{
		inline function num(time:Float)
			return Math.floor((time - initial) / repeat);

		return justPressed || (timer > initial && num(timer) > num(prevTimer));
	}

	public function updateWithState(isPressed:Bool)
	{
		if (pressed)
		{
			prevTimer = timer;
			timer += FlxG.elapsed;
		}

		if (isPressed && released)
		{
			press();
		}

		if (!isPressed && pressed)
		{
			release();
			prevTimer = timer = 0;
		}

		update();
	}

	public function toString()
	{
		return '{ current:$current, timer: $timer }';
	}
}
