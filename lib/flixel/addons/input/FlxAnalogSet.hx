package flixel.addons.input;

import flixel.FlxG;
import flixel.addons.input.FlxControlInputType;
import flixel.addons.input.FlxControls;
import flixel.addons.input.FlxRepeatInput;
import flixel.addons.input.actions.AnalogActions;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInputAnalog;
import flixel.input.actions.FlxActionSet;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.util.FlxAxes;
import flixel.util.FlxDirection;
import flixel.util.FlxDirectionFlags;

@:forward
abstract FlxAnalogSet1D<TAction:EnumValue>(FlxAnalogSet1DBase<TAction>) to FlxAnalogSet1DBase<TAction>
{
	/** The value of this action */
	public var value(get, never):Float;
	inline function get_value():Float { @:privateAccess return this.control.x; }
}

@:allow(flixel.addons.input.FlxAnalogDirections2D)
@:access(flixel.addons.input.FlxAnalogSet)
@:forward
abstract FlxAnalogSet1DBase<TAction:EnumValue>(FlxAnalogSet<TAction>) to FlxAnalogSet<TAction>
{
	/**
	 * Helper for extracting digital directional states from an analog action.
	 * For instance, if the action's `value` is positive, `pressed.up` will be `true`
	 */
	public var pressed(get, never):FlxAnalogDirections1D<TAction>;
	inline function get_pressed() return this.pressed;

	/**
	 * Helper for extracting digital directional states from an analog action.
	 * For instance, if the action's `value` just became positive, `justPressed.up` will be `true`
	 */
	public var justPressed(get, never):FlxAnalogDirections1D<TAction>;
	inline function get_justPressed() return this.justPressed;

	/**
	 * Helper for extracting digital directional states from an analog action.
	 * For instance, if the action's `value` is `0` or negative, `released.up` will be `true`
	 */
	public var released(get, never):FlxAnalogDirections1D<TAction>;
	inline function get_released() return this.released;

	/**
	 * Helper for extracting digital directional states from an analog action.
	 * For instance, if the action's `value` just became `0` or negative, `justReleased.up` will be `true`
	 */
	public var justReleased(get, never):FlxAnalogDirections1D<TAction>;
	inline function get_justReleased() return this.justReleased;

	/**
	 * Helper for extracting digital directional states from an analog action.
	 * It is similar to `justPressed` but holding the input for 0.5s will make it fire every 0.1s
	 */
	@:deprecated("holdRepeat is deprecated, use waitAndRepeat(), instead")
	public var holdRepeat(get, never):FlxAnalogDirections1D<TAction>;
	inline function get_holdRepeat()
	{
		return waitAndRepeat();
	}

	/**
	 * An event that fires when just pressed, then repeats at the given interval
	 *
	 * @param   delay  How often to fire the event
	 */
	inline public function repeat(delay = 0.1):FlxAnalogDirections1D<TAction>
	{
		return this.getRepeater(0, delay);
	}

	/**
	 * An event that fires when just pressed, then repeats after the initial time
	 *
	 * @param   initialDelay  How long after the initial press to start repeating
	 * @param   repeatDelay   How often to fire the event
	 */
	inline public function waitAndRepeat(initialDelay = 0.5, repeatDelay = 0.1):FlxAnalogDirections1D<TAction>
	{
		return this.getRepeater(initialDelay, repeatDelay);
	}
}

@:forward
abstract FlxAnalogSet2D<TAction:EnumValue>(FlxAnalogSet2DBase<TAction>) to FlxAnalogSet2DBase<TAction>
{
	/** The horizontal component of this 2D action */
	public var x(get, never):Float;
	/** The vertical component of this 2D action */
	public var y(get, never):Float;
	inline function get_x():Float { @:privateAccess return this.control.x; }
	inline function get_y():Float { @:privateAccess return this.control.y; }
}

#if (flixel < version("6.0.0"))
typedef FlxReadOnlyPoint = FlxPoint;
#end

@:allow(flixel.addons.input.FlxAnalogDirections2D)
@:forward
abstract FlxAnalogSet2DBase<TAction:EnumValue>(FlxAnalogSet<TAction>) to FlxAnalogSet<TAction>
{
	/**
	 * Handy `FlxPoint` with the 2d components of this analog action, for use in vector math
	 */

	public var value(get, never):FlxReadOnlyPoint;
	inline function get_value() return this.value;

	/**
	 * Helper for extracting digital directional states from a 2D analog action.
	 * For instance, if the action's `y` is positive, `pressed.up` will be `true`
	 */
	public var pressed(get, never):FlxAnalogDirections2D<TAction>;
	inline function get_pressed() return this.pressed;

	/**
	 * Helper for extracting digital directional states from a 2D analog action.
	 * For instance, if the action's `y` just became positive, `justPressed.up` will be `true`
	 */
	public var justPressed(get, never):FlxAnalogDirections2D<TAction>;
	inline function get_justPressed() return this.justPressed;

	/**
	 * Helper for extracting digital directional states from a 2D analog action.
	 * For instance, if the action's `y` is `0` or negative, `released.up` will be `true`
	 */
	public var released(get, never):FlxAnalogDirections2D<TAction>;
	inline function get_released() return this.released;

	/**
	 * Helper for extracting digital directional states from a 2D analog action.
	 * For instance, if the action's `y` just became `0` or negative, `justReleased.up` will be `true`
	 */
	public var justReleased(get, never):FlxAnalogDirections2D<TAction>;
	inline function get_justReleased() return this.justReleased;

	/**
	 * Helper for extracting digital directional states from a 2D analog action.
	 * It is similar to `justPressed` but holding the input for 0.5s will make it fire every 0.1s
	 */
	@:deprecated("holdRepeat is deprecated, use waitAndRepeat(), instead")
	public var holdRepeat(get, never):FlxAnalogDirections2D<TAction>;
	inline function get_holdRepeat()
	{
		return waitAndRepeat();
	}

	/**
	 * An event that fires when just pressed, then repeats at the given interval
	 *
	 * @param   delay  How often to fire the event
	 */
	inline public function repeat(delay = 0.1):FlxAnalogDirections2D<TAction>
	{
		return this.getRepeater(0, delay);
	}

	/**
	 * An event that fires when just pressed, then repeats after the initial time
	 *
	 * @param   initialDelay  How long after the initial press to start repeating
	 * @param   repeatDelay   How often to fire the event
	 */
	inline public function waitAndRepeat(initialDelay = 0.5, repeatDelay = 0.1):FlxAnalogDirections2D<TAction>
	{
		return this.getRepeater(initialDelay, repeatDelay);
	}
}

/**
 * Manages analog actions. There is usually only 1 of these per FlxControls instance, and it's only
 * accessed by FlxControls, which offers ways to use the actions in this set.
 */
@:allow(flixel.addons.input.FlxControls)
@:allow(flixel.addons.input.FlxAnalogSet1DBase)
@:allow(flixel.addons.input.FlxAnalogSet2DBase)
class FlxAnalogSet<TAction:EnumValue>
{
	#if (FLX_DEBUG && FlxControls.dev)
	public var enableDebugWatchers = false;
	#end

	final pressed:FlxAnalogDirections2D<TAction>;
	final justPressed:FlxAnalogDirections2D<TAction>;
	final released:FlxAnalogDirections2D<TAction>;
	final justReleased:FlxAnalogDirections2D<TAction>;
	final repeaters = new Map<DigitalEvent, FlxAnalogDirections2D<TAction>>();
	final value = FlxPoint.get();

	var upInput = new FlxRepeatInput<FlxDirection>(UP);
	var downInput = new FlxRepeatInput<FlxDirection>(DOWN);
	var leftInput = new FlxRepeatInput<FlxDirection>(LEFT);
	var rightInput = new FlxRepeatInput<FlxDirection>(RIGHT);

	var control:FlxControlAnalog;
	var parent:FlxControls<TAction>;
	var name:String;

	function new(parent, action:TAction)
	{
		this.parent = parent;
		final namePrefix = '${parent.name}:${action.getName()}';
		name = '$namePrefix-analogSet';
		control = new FlxControlAnalog('$namePrefix-control', MOVED);

		pressed      = new FlxAnalogDirections2D(this, (i)->i.hasState(PRESSED      ));
		released     = new FlxAnalogDirections2D(this, (i)->i.hasState(RELEASED     ));
		justPressed  = new FlxAnalogDirections2D(this, (i)->i.hasState(JUST_PRESSED ));
		justReleased = new FlxAnalogDirections2D(this, (i)->i.hasState(JUST_RELEASED));
	}

	function destroy()
	{
		parent = null;

		pressed.destroy();
		justPressed.destroy();
		released.destroy();
		justReleased.destroy();
		repeaters.clear();

		value.put();
	}

	function update()
	{
		control.update();
		value.set(control.x, control.y);

		upInput.updateWithState(control.y > 0);
		downInput.updateWithState(control.y < 0);
		rightInput.updateWithState(control.x > 0);
		leftInput.updateWithState(control.x < 0);

		#if (FLX_DEBUG && FlxControls.dev)
		if (enableDebugWatchers)
		{
			final id = name.split("-")[0].split(":").pop();
			FlxG.watch.addQuick('$id-U',    upInput.toString());
			FlxG.watch.addQuick('$id-D',  downInput.toString());
			FlxG.watch.addQuick('$id-L',  leftInput.toString());
			FlxG.watch.addQuick('$id-R', rightInput.toString());
		}
		#end
	}

	function getRepeater(initial:Float, repeat:Float):FlxAnalogDirections2D<TAction>
	{
		final event = REPEAT_CUSTOM(initial, repeat);
		if (false == repeaters.exists(event))
			repeaters[event] = new FlxAnalogDirections2D(this, (i)->i.triggerRepeat(initial, repeat));

		return repeaters[event];
	}

	/**
	 * Registers the control associated with the target action
	 */
	function add(input:FlxControlInputType)
	{
		control.addInputType(parent, input);
	}

	/**
	 * Unregisters the control associated with the target action
	 */
	function remove(input:FlxControlInputType)
	{
		control.removeInputType(input);
	}

	function setGamepadID(id:FlxDeviceID)
	{
		control.setGamepadID(id);
	}
}

abstract FlxAnalogDirections1D<TAction:EnumValue>(FlxAnalogDirections2D<TAction>) from FlxAnalogDirections2D<TAction>
{
	/** The digital up component of this 2D action **/
	public var up(get, never):Bool;
	function get_up() return this.right;

	/** The digital down component of this 2D action **/
	public var down(get, never):Bool;
	function get_down() return this.left;

	public function toString()
	{
		return '( u: $up | d: $down )';
	}
}

@:allow(flixel.addons.input.FlxAnalogSet)
@:access(flixel.addons.input.FlxAnalogSet)
class FlxAnalogDirections2D<TAction:EnumValue>
{
	/** The digital up component of this 2D action **/
	public var up(get, never):Bool;
	inline function get_up() return func(set.upInput);

	/** The digital down component of this 2D action **/
	public var down(get, never):Bool;
	inline function get_down() return func(set.downInput);

	/** The digital left component of this 2D action **/
	public var left(get, never):Bool;
	inline function get_left() return func(set.leftInput);

	/** The digital right component of this 2D action **/
	public var right(get, never):Bool;
	inline function get_right() return func(set.rightInput);

	var set:FlxAnalogSet<TAction>;
	var func:(FlxRepeatInput<FlxDirection>)->Bool;

	function new(set, func)
	{
		this.set = set;
		this.func = func;
	}

	function destroy()
	{
		this.set = null;
		this.func = null;
	}

	public function toString()
	{
		return '( u: $up | d: $down | l: $left | r: $right)';
	}

	/**
	 * Checks the digital component of the given direction. For example: `UP` will check `up`
	 */
	public function check(dir:FlxDirection)
	{
		return switch dir
		{
			case UP: up;
			case DOWN: down;
			case LEFT: left;
			case RIGHT: right;
		}
	}

	/**
	 * Checks the digital components of the given direction flags.
	 * For example: `(UP | DOWN)` will check `up || down`
	 */
	public function any(dir:FlxDirectionFlags)
	{
		return (dir.has(UP   ) && up   )
			|| (dir.has(DOWN ) && down )
			|| (dir.has(LEFT ) && left )
			|| (dir.has(RIGHT) && right);
	}
}

/**
 * An analog control containing all the inputs associated with a single action
 */
class FlxControlAnalog extends FlxActionAnalog
{
	final trigger:FlxAnalogState;

	public function new (name, trigger, ?callback)
	{
		this.trigger = trigger;
		super(name, callback);
	}

	/**
	 * Adds the input to this control's list
	 */
	public function addInputType<TAction:EnumValue>(parent:FlxControls<TAction>, input:FlxControlInputType)
	{
		switch input
		{
			// Gamepad
			case Gamepad(Lone(id)) if (id == LEFT_TRIGGER || id == RIGHT_TRIGGER):
				addGamepadAction(id, X, parent.gamepadID);
			case Gamepad(Lone(id)) if (id == LEFT_ANALOG_STICK || id == RIGHT_ANALOG_STICK):
				addGamepadAction(id, EITHER, parent.gamepadID);
			case Gamepad(Lone(found)):
				throw 'Internal Error - Unexpected Gamepad(Digital($found))';
			case Gamepad(Multi(up, down, null, null)):
				addGamepad1D(up, down, parent.gamepadID);
			case Gamepad(Multi(up, down, right, left)):
				addGamepad2D(up, down, right, left, parent.gamepadID);
			case Gamepad(DPad)
				| Gamepad(Face)
				| Gamepad(LeftStickDigital)
				| Gamepad(RightStickDigital):
				addInputType(parent, input.simplify());

			// Mouse
			case Mouse(Drag(id, axis, scale, deadzone, invert)):
				add(new AnalogMouseDragAction(id ?? LEFT, this.trigger, axis ?? EITHER, scale ?? 0.1, deadzone ?? 0.1, invert ?? FlxAxes.NONE));
			case Mouse(Position(axis)):
				add(new AnalogMousePositionAction(this.trigger, axis));
			case Mouse(Motion(axis, scale, deadzone, invert)):
				add(new AnalogMouseMoveAction(this.trigger, axis ?? EITHER, scale ?? 0.1, deadzone ?? 0.1, invert ?? FlxAxes.NONE));
			case Mouse(Wheel(scale)):
				add(new AnalogMouseWheelAction(this.trigger, scale ?? 0.1));
			case Mouse(Button(found)):
				throw 'Internal error - Unexpected Mouse(Button($found))';

			// Keys
			case Keyboard(Multi(up, down, null, null)):
				addKeys1D(up, down);
			case Keyboard(Multi(up, down, right, left)):
				addKeys2D(up, down, right, left);
			case Keyboard(Arrows)
				| Keyboard(WASD):
				addInputType(parent, input.simplify());
			case Keyboard(Lone(found)):
				throw 'Internal error - Unexpected Keyboard($found)';

			// VPad
			case VirtualPad(Multi(up, down, null, null)):
				@:privateAccess addVPad1D(parent.vPadProxies, up, down);
			case VirtualPad(Multi(up, down, right, left)):
				@:privateAccess addVPad2D(parent.vPadProxies, up, down, right, left);
			case VirtualPad(Arrows):
				addInputType(parent, input.simplify());
			#if (flixel >= version("6.0.0"))
			case VirtualPad(Lone(STICK)):
				@:privateAccess addVPadStick(parent.vPadStickProxy);
			#end
			case VirtualPad(Lone(found)):
				throw 'Internal error - Unexpected VirtualPad($found)';
		}
	}

	/**
	 * Removes the input from this control's list
	 */
	public function removeInputType(input:FlxControlInputType)
	{
		switch input
		{
			// Gamepad
			case Gamepad(Lone(id)) if (id == LEFT_TRIGGER || id == RIGHT_TRIGGER):
				removeGamepadAction(id, X);
			case Gamepad(Lone(id)) if (id == LEFT_ANALOG_STICK || id == RIGHT_ANALOG_STICK):
				removeGamepadAction(id, EITHER);
			case Gamepad(Multi(up, down, null, null)):
				removeGamepad1D(up, down);
			case Gamepad(Multi(up, down, right, left)):
				removeGamepad2D(up, down, right, left);
			case Gamepad(DPad):
				removeGamepad2D(DPAD_UP, DPAD_DOWN, DPAD_RIGHT, DPAD_LEFT);
			case Gamepad(found):
				throw 'Internal Error - Unexpected Gamepad($found)';

			// Mouse
			case Mouse(Drag(id, axis, _, _, _)):
				removeMouseDrag(id, axis);
			case Mouse(Position(axis)):
				removeMousePosition(axis);
			case Mouse(Motion(axis, _, _, _)):
				removeMouseMotion(axis);
			case Mouse(Wheel(_)):
				removeMouseWheel();
			case Mouse(Button(found)):
				throw 'Internal error - Unexpected Mouse(Button($found))';

			// Keys
			case Keyboard(Multi(up, down, null, null)):
				removeKeys1D(up, down);
			case Keyboard(Multi(up, down, right, left)):
				removeKeys2D(up, down, right, left);
			case Keyboard(Arrows):
				removeKeys2D(UP, DOWN, RIGHT, LEFT);
			case Keyboard(WASD):
				removeKeys2D(W, S, D, A);
			case Keyboard(Lone(found)):
				throw 'Internal error - Unexpected Keyboard(Lone($found))';

			// VPad
			case VirtualPad(Multi(up, down, null, null)):
				removeVPad1D(up, down);
			case VirtualPad(Multi(up, down, right, left)):
				removeVPad2D(up, down, right, left);
			case VirtualPad(Arrows):
				removeVPad2D(UP, DOWN, RIGHT, LEFT);
			#if (flixel >= version("6.0.0"))
			case VirtualPad(Lone(STICK)):
				removeVPadStick();
			#end
			case VirtualPad(Lone(found)):
				throw 'Internal error - Unexpected VirtualPad(Lone($found))';
		}
	}

	inline function addGamepadAction(inputID:FlxGamepadInputID, axis, gamepadID:FlxDeviceID)
	{
		add(new AnalogGamepadAction(inputID, this.trigger, axis, gamepadID));
	}

	function removeGamepadAction(inputID:FlxGamepadInputID, axis)
	{
		for (input in this.inputs)
		{
			if (input is AnalogGamepadAction)
			{
				final input:AnalogGamepadAction = cast input;
				if (input.inputID == inputID && input.axis == axis)
				{
					this.remove(input);
					break;
				}
			}
		}
	}

	function removeMouseMotion(axis)
	{
		final inputs:Array<AnalogAction> = cast this.inputs;
		for (input in inputs)
		{
			if (input is AnalogMouseMoveAction && axis == input.axis)
			{
				this.remove(input);
				break;
			}
		}
	}

	function removeMousePosition(axis)
	{
		final inputs:Array<AnalogAction> = cast this.inputs;
		for (input in inputs)
		{
			if (input is AnalogMousePositionAction && axis == input.axis)
			{
				this.remove(input);
				break;
			}
		}
	}

	function removeMouseDrag(buttonID, axis)
	{
		final inputs:Array<AnalogAction> = cast this.inputs;
		for (input in inputs)
		{
			@:privateAccess
			if (input is AnalogMouseDragAction
			&& axis == input.axis
			&& (cast input:AnalogMouseDragAction).buttonID == buttonID)
			{
				this.remove(input);
				break;
			}
		}
	}

	function removeMouseWheel()
	{
		final inputs:Array<AnalogAction> = cast this.inputs;
		for (input in inputs)
		{
			if (input is AnalogMouseWheelAction)
			{
				this.remove(input);
				break;
			}
		}
	}

	function addKeys1D(up:FlxKey, down:FlxKey)
	{
		add(new Analog1DKeysAction(this.trigger, up, down));
	}

	function addKeys2D(up:FlxKey, down:FlxKey, right:FlxKey, left:FlxKey)
	{
		add(new Analog2DKeysAction(this.trigger, up, down, right, left));
	}

	function removeKeys1D(up:FlxKey, down:FlxKey)
	{
		for (input in this.inputs)
		{
			if (input is Analog1DKeysAction)
			{
				final input:Analog1DKeysAction = cast input;
				if (input.up == up && input.down == down)
				{
					this.remove(input);
					break;
				}
			}
		}
	}

	function removeKeys2D(up:FlxKey, down:FlxKey, right:FlxKey, left:FlxKey)
	{
		for (input in this.inputs)
		{
			if (input is Analog2DKeysAction)
			{
				final input:Analog2DKeysAction = cast input;
				if (input.up == up
				&& input.down == down
				&& input.right == right
				&& input.left == left)
				{
					this.remove(input);
					break;
				}
			}
		}
	}

	public function addGamepad1D(up, down, gamepadID)
	{
		this.add(new Analog1DGamepadAction(gamepadID, this.trigger, up, down));
	}

	public function addGamepad2D(up, down, right, left, gamepadID)
	{
		this.add(new Analog2DGamepadAction(gamepadID, this.trigger, up, down, right, left));
	}

	public function removeGamepad1D(up, down)
	{
		for (input in this.inputs)
		{
			if (input is Analog1DGamepadAction)
			{
				final input:Analog1DGamepadAction = cast input;
				if (input.up == up && input.down == down)
				{
					this.remove(input);
					break;
				}
			}
		}
	}

	public function removeGamepad2D(up, down, right, left)
	{
		for (input in this.inputs)
		{
			if (input is Analog2DGamepadAction)
			{
				final input:Analog2DGamepadAction = cast input;
				if (input.up == up
				&& input.down == down
				&& input.right == right
				&& input.left == left)
				{
					this.remove(input);
					break;
				}
			}
		}
	}

	function addVPad1D(proxies:VPadMap, up, down)
	{
		add(new Analog1DVPadAction(proxies, this.trigger, up, down));
	}

	function addVPad2D(proxies:VPadMap, up, down, right, left)
	{
		add(new Analog2DVPadAction(proxies, this.trigger, up, down, right, left));
	}

	#if (flixel >= version("6.0.0"))
	function addVPadStick(proxy:VirtualPadStickProxy)
	{
		add(new VPadStickAction(proxy, this.trigger));
	}
	#end

	function removeVPad1D(up, down)
	{
		for (input in this.inputs)
		{
			if (input is Analog1DVPadAction)
			{
				final input:Analog1DVPadAction = cast input;
				if (input.up == up && input.down == down)
				{
					this.remove(input);
					break;
				}
			}
		}
	}

	function removeVPad2D(up, down, right, left)
	{
		for (input in this.inputs)
		{
			if (input is Analog2DVPadAction)
			{
				final input:Analog2DVPadAction = cast input;
				if (input.up == up
				&& input.down == down
				&& input.right == right
				&& input.left == left)
				{
					this.remove(input);
					break;
				}
			}
		}
	}

	#if (flixel >= version("6.0.0"))
	function removeVPadStick()
	{
		for (input in this.inputs)
		{
			if (input is VPadStickAction)
				this.remove(cast input);
		}
	}
	#end

	public function setGamepadID(id:FlxDeviceID)
	{
		for (input in this.inputs)
		{
			if (input.device == GAMEPAD)
				input.deviceID = id.toLegacy();
		}
	}

	#if (flixel < version("5.9.0"))
	/**
	 * See if this action has been triggered
	 */
	override function check()
	{
		final result = checkSuper();
		if (result && callback != null)
			callback(this);

		return result;
	}

	/**
	 * avoids a bug that was fixed in 5.9.0
	 */
	function checkSuper():Bool
	{
		if (_timestamp == FlxG.game.ticks)
			return triggered; // run no more than once per frame

		_x = null;
		_y = null;

		_timestamp = FlxG.game.ticks;
		triggered = false;

		var i = inputs != null ? inputs.length : 0;
		while (i-- > 0) // Iterate backwards, since we may remove items
		{
			final input = inputs[i];

			if (input.destroyed)
			{
				inputs.remove(input);
				continue;
			}

			input.update();

			if (input.check(this))
				triggered = true;
		}

		return triggered;
	}
	#end
}