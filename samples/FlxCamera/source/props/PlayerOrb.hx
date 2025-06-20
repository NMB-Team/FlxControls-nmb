package props;

import flixel.FlxG;
import input.PlayerControls;
import nape.geom.Vec2;

/**
 * User controlled orb
 */
class PlayerOrb extends Orb
{
	/**
	 * The impulse applied each frame when pressing the corresponding key
	 */
	static inline var IMPULSE = 20;

	/**
	 * Used Internally to avoid creating new instances each frame
	 */
	static final impulseHelper = new Vec2();

	public var controls:PlayerControls;

	public function new(x = 0.0, y = 0.0)
	{
		super(x, y, 18, "assets/Orb.png", "assets/OrbShadow.png");
		// small amount of drag
		setDrag(0.98);

		controls = new PlayerControls("player");
		#if (flixel < version("5.9.0"))
		FlxG.inputs.add(controls);
		#else
		FlxG.inputs.addInput(controls);
		#end

		#if debug
		FlxG.watch.addFunction("device", ()->controls.lastActiveDevice);
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// apply impusles to the body based on key presses

		if (controls.MOVE.pressed.left)
			applyImpulseXY(-IMPULSE, 0);

		if (controls.MOVE.pressed.down)
			applyImpulseXY(0, IMPULSE);

		if (controls.MOVE.pressed.right)
			applyImpulseXY(IMPULSE, 0);

		if (controls.MOVE.pressed.up)
			applyImpulseXY(0, -IMPULSE);
	}

	/**
	 * Helper to apply impulse via x and y floats to avoid creating new Vec2 instances each frame
	 */
	inline function applyImpulseXY(x:Float, y:Float)
	{
		body.applyImpulse(impulseHelper.setxy(x, y));
	}
}