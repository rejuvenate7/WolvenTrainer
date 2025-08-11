// Wolven Trainer by rejuvenate
// https://next.nexusmods.com/profile/rejuvenate7/about-me

statemachine class WolvenCamera extends CStaticCamera
{
	var originalCamPos : Vector;
	var originalCamRot : EulerAngles;
	var currentHeading : float;
	var currentPitch : float;
	var maxPitch : float; default maxPitch = 50;
	
	var cameraPos, vampPos : Vector;
	var cameraRot : EulerAngles;
	protected var comp: CCameraComponent;

	event OnSpawned( spawnData : SEntitySpawnData )	
	{
		var world: CGameWorld;
		theGame.getWolvenTrainer().SetWolvenCamera(this);
		
		cameraPos = theCamera.GetCameraPosition();
		cameraRot = theCamera.GetCameraRotation();
		comp = (CCameraComponent)this.GetComponentByClassName('CCameraComponent');
		currentHeading = cameraRot.Yaw;		
        world = (CGameWorld)theGame.GetWorld();

		Start();
	}

	function wolvenSetFov(val : float)
	{
		this.comp.fov = val;
	}
	function wolvenSetRotation(val : float)
	{
		cameraRot.Roll = val;
		this.TeleportWithRotation(this.GetWorldPosition(), cameraRot);
	}

	function Start()	
	{	
		this.deactivationDuration = 0;
		this.activationDuration = 0;
		this.fadeStartDuration = 0;
		this.fadeEndDuration = 0;
		this.Run();
		this.TeleportWithRotation(cameraPos,cameraRot);
	
		AddTimer('Tick', 0, true);
	}
	
	public function getHeading() : float
	{
		return this.currentHeading;
	}
	
	public function getPitch() : float
	{
		return this.currentPitch;
	}

	timer function Tick( deltaTime : float , id : int)	
	{	
        var freecamPosition : Vector;
		var inputX : float;
		var inputY : float;
		var freecamSpeed : float;

		if(!theGame.getWolvenTrainer().getFreecam())
		{
			GoBack();
			return;
		}	

		if(!this.IsRunning())
		{
			theInput.SetContext('Exploration');
			this.Run();
			this.TeleportWithRotation(theCamera.GetCameraPosition(),theCamera.GetCameraRotation());
		}

        freecamPosition = this.GetWorldPosition();
        freecamSpeed = theGame.getWolvenTrainer().getFreecamSpeed() / 4;
		this.comp.fov = theGame.getWolvenTrainer().getFreecamFOV();
		if(cameraRot.Roll != theGame.getWolvenTrainer().getFreecamRoll())
		{
			cameraRot.Roll = theGame.getWolvenTrainer().getFreecamRoll();
			this.TeleportWithRotation( freecamPosition , cameraRot);
		}

		if (theInput.IsActionPressed('Sprint'))
        {
			freecamSpeed = freecamSpeed * 2;
		}

		if ( thePlayer.IsPCModeEnabled() )
        {
			inputX = theInput.GetActionValue( 'GI_MouseDampX' ) * 0.20;
			inputY = 0 - theInput.GetActionValue( 'GI_MouseDampY' ) * 0.20;
		}
		else if (theGame.IsDialogOrCutscenePlaying())
        {
			inputX = theInput.GetActionValue( 'GI_AxisRightX' ) * 1.25;
			inputY = theInput.GetActionValue( 'GI_AxisRightY' ) * 1.25;
		}
        else
        {
			inputX = theInput.GetActionValue( 'GI_AxisRightX' );
			inputY = theInput.GetActionValue( 'GI_AxisRightY' );
		}

		cameraRot.Pitch += inputY;
		cameraRot.Yaw -= inputX;

		freecamPosition += RotForward(cameraRot) * theInput.GetActionValue('GI_AxisLeftY') * freecamSpeed;
		freecamPosition += RotRight(cameraRot) * theInput.GetActionValue('GI_AxisLeftX') * freecamSpeed;

		//if (theInput.IsActionPressed('CastSign'))
		if (theInput.IsActionPressed('Jump'))
        {
			freecamPosition.Z += 0.2;
		} 
		//if (theInput.IsActionPressed('Use'))
		if (theInput.IsActionPressed('SwordSheathe')|| theInput.IsActionPressed('DiveDown'))
        {
			freecamPosition.Z -= 0.2;
		} 

		if ( freecamPosition != this.GetWorldPosition() || theInput.GetActionValue( 'GI_MouseDampX' ) != 0 || theInput.GetActionValue( 'GI_MouseDampY' ) != 0 || theInput.GetActionValue( 'GI_AxisRightX' ) != 0 || theInput.GetActionValue( 'GI_AxisRightY' ) != 0 )
		{
			this.TeleportWithRotation( freecamPosition , cameraRot);
		}
	}		
	
	public function GoBack()
	{	
		this.Stop();
		this.Destroy();		
		RemoveTimer('Tick');	
	}
}