package flixel.addons.input;

import flixel.addons.input.FlxControlInputType;
import flixel.addons.input.FlxControls;
import flixel.addons.input.FlxRepeatInput;
import flixel.input.FlxInput;
import flixel.input.IFlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInput;
import flixel.input.actions.FlxActionInputDigital;
import flixel.input.actions.FlxActionSet;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.input.mouse.FlxMouseButton;
import flixel.util.FlxDestroyUtil;

/**
 * Manages the digital actions for a specific input state, allowing you to see whether any action
 * is currently in that particular state. Primarily accessed via the `FlxControls` fields:
 * `pressed`, `justPressed`, `released`, and `justReleased`
 *
 * Access the states of actions via `controls.pressed.check(ACCEPT)` or `controls.pressed.any(LEFT,RIGHT)`.
 * `FlxControls` also uses macros to build handy getters for each action, i.e.: `controls.pressed.ACCEPT`
 */
@:allow(flixel.addons.input.FlxControls)
class FlxDigitalSet<TAction:EnumValue>
{
	final event:DigitalEvent;
	final mappings:Map<TAction, FlxControlDigital> = [];

	var parent:FlxControls<TAction>;
	var name:String;


	#if (FLX_DEBUG && FlxControls.dev)
	public var enableDebugWatchers:Bool = false;
	#end

	public function new(parent, event)
	{
		this.event = event;
		this.parent = parent;

		name = '${parent.name}:digital-list-$event';
	}

	function destroy()
	{
		parent = null;
		clear();
	}

	function clear()
	{
		for (control in mappings)
			control.destroy();

		mappings.clear();
	}

	function get(action:TAction)
	{
		if (mappings.exists(action) == false)
			mappings[action] = new FlxControlDigital('${parent.name}:${action.getName()}-$event', event);

		return mappings[action];
	}

	function update()
	{
		for (control in mappings)
		{
			control.update();
			#if (FLX_DEBUG && FlxControls.dev)
			if (enableDebugWatchers)
				FlxG.watch.addQuick(control.name, control.toString());
			#end
		}
	}

	public function check(action:TAction)
	{
		return get(action).check();
	}

	public function any(actions:Array<TAction>)
	{
		for (action in actions)
		{
			if (get(action).check())
				return true;
		}
		return false;
	}

	inline function add(action:TAction, input:FlxControlInputType)
	{
		return get(action).add(parent, input, event.toState());
	}

	inline function remove(action:TAction, input:FlxControlInputType)
	{
		return get(action).remove(parent, input);
	}

	function setGamepadID(id:FlxDeviceID)
	{
		for (control in mappings)
			control.setGamepadID(id);
	}
}

class FlxControlRepeatDigital extends FlxActionDigital
{
	final input:Null<FlxRepeatInput<Int>>;
	final intitial:Float;
	final repeat:Float;

	public function new (name, intitial = 0.5, repeat = 0.1, ?callback)
	{
		input = new FlxRepeatInput(0);
		this.intitial = intitial;
		this.repeat = repeat;
		super(name, callback);
	}

	override function update()
	{
		super.update();

		input.updateWithState(super.check());
	}

	override function check():Bool
	{
		return input.triggerRepeat(intitial, repeat);
	}

	override function toString()
	{
		return input.toString();
	}
}

/**
 * An digital control containing all the inputs associated with a single action
 */
@:allow(flixel.addons.input.FlxDigitalSet)
@:access(flixel.addons.input.FlxControls)
@:forward(check, update, destroy, name)
abstract FlxControlDigital(FlxActionDigital) to FlxActionDigital
{
	function new (name, event, ?callback)
	{
		this = switch event
		{
			case REPEAT_CUSTOM(initial, repeat):
				new FlxControlRepeatDigital(name, initial, repeat, callback);
			case REPEAT:
				new FlxControlRepeatDigital(name, 0.5, 0.1, callback);
			default:
				new FlxActionDigital(name, callback);
		}
	}

	function add<TAction:EnumValue>(parent:FlxControls<TAction>, input:FlxControlInputType, state)
	{
		return switch input
		{
			case Keyboard(Lone(id)):
				this.addKey(id, state);
			case Keyboard(found):
				throw 'Internal error - Unexpected Keyboard($found)';
			case Gamepad(Lone(id)):
				this.addGamepad(id, state, parent.gamepadID.toLegacy());
			case Gamepad(found):
				throw 'Internal error - Unexpected Gamepad($found)';
			#if (flixel >= version("6.0.0"))
			case VirtualPad(Lone(STICK)):
				throw 'Internal error - Unexpected VirtualPad(STICK)';
			#end
			case VirtualPad(Lone(id)):
				@:privateAccess
				this.addInput(parent.vPadProxies[id], state);
			case VirtualPad(found):
				throw 'Internal error - Unexpected VirtualPad($found)';
			case Mouse(Button(id)):
				this.addMouse(id, state);
			case Mouse(found):
				throw 'Internal error - Unexpected Mouse($found)';
		}
	}

	function remove<TAction:EnumValue>(parent:FlxControls<TAction>, input:FlxControlInputType):Null<FlxActionInput>
	{
		return switch input
		{
			case Keyboard(Lone(id)):
				removeKey(id);
			case Keyboard(found):
				throw 'Internal error - Unexpected Keyboard($found)';
			case Gamepad(Lone(id)):
				removeGamepad(id);
			case Gamepad(found):
				throw 'Internal error - Unexpected Gamepad($found)';
			#if (flixel >= version("6.0.0"))
			case VirtualPad(Lone(STICK)):
				throw 'Internal error - Unexpected VirtualPad(STICK)';
			#end
			case VirtualPad(Lone(id)):
				removeVirtualPad(parent, id);
			case VirtualPad(found):
				throw 'Internal error - Unexpected VirtualPad($found)';
			case Mouse(Button(id)):
				removeMouse(id);
			case Mouse(_):
				throw 'Mouse not implemented, yet';
		}
	}

	function removeKey(key:FlxKey):Null<FlxActionInput>
	{
		for (input in this.inputs)
		{
			if (input.device == KEYBOARD && key == cast input.inputID)
			{
				this.remove(input);
				return input;
			}
		}

		return null;
	}

	function removeGamepad(id:FlxGamepadInputID):Null<FlxActionInput>
	{
		for (input in this.inputs)
		{
			if (input.device == GAMEPAD && id == cast input.inputID)
			{
				this.remove(input);
				return input;
			}
		}

		return null;
	}

	function removeMouse(id:FlxMouseButtonID):Null<FlxActionInput>
	{
		for (input in this.inputs)
		{
			if (input.device == MOUSE && id == cast input.inputID)
			{
				this.remove(input);
				return input;
			}
		}

		return null;
	}

	function removeVirtualPad<TAction:EnumValue>(parent:FlxControls<TAction>, id:FlxVirtualPadInputID):Null<FlxActionInput>
	{
		final proxy = parent.vPadProxies[id];
		for (input in this.inputs)
		{
			@:privateAccess
			if (input is FlxActionInputDigitalIFlxInput && (cast input:FlxActionInputDigitalIFlxInput).input == proxy)
			{
				this.remove(input);
				return input;
			}
		}

		return null;
	}

	public function setGamepadID(id:FlxDeviceID)
	{
		for (input in this.inputs)
		{
			if (input.device == GAMEPAD)
				input.deviceID = id.toLegacy();
		}
	}

	public function toString()
	{
		if (this is FlxControlRepeatDigital)
		{
			return Std.downcast(this, FlxControlRepeatDigital).toString();
		}

		return Std.string(this.triggered);
	}
}