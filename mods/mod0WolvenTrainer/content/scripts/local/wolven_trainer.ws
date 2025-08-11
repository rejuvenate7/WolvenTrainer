// Wolven Trainer by rejuvenate
// https://next.nexusmods.com/profile/rejuvenate7/about-me

class WolvenTrainer
{
    private var godMode : bool;
    private var ghostMode : bool;
    private var enemiesIgnore : bool;
    private var playerSpeed : float;
    private var horseSpeed : float;
    private var customHorseSpeed : bool;
	private var superJump : bool;
    private var ultraJump : bool;
    private var flyMode : bool;
    private var collision : bool;
    private var forcefield : bool;
    private var fallDamage : bool;
    private var weightLimit : bool;
    private var noToxicity : bool;
    private var noCrafting : bool;
    private var customBoatSpeed : bool;
    private var boatSpeed : float;
    private var infiniteBreath : bool;
    private var nightVision : bool;
    private var freecamRotation : EulerAngles;
    private var freecamSpeed : float;
    private var freecamFOV : float;
    private var freecamRoll : float;
    private var lastAction : int;

    private var fullBodyEnabled : bool;
    private var fullBodyPrevTemp : CEntityTemplate;

    private var hairEnabled : bool;
    private var hairPrevTemp : name;

    private var headEnabled : bool;
    private var headPrevTemp : CEntityTemplate;

    private var maskEnabled : bool;
    private var maskPrevTemp : CEntityTemplate;

    private var capeEnabled : bool;
    private var capePrevTemp : CEntityTemplate;

    private var shoulderEnabled : bool;
    private var shoulderPrevTemp : CEntityTemplate;

    private var prevTempAccessories : array<CEntityTemplate>;
    private var accessoriesEnabled : bool;
    private var accessoriesPrevTemp : CEntityTemplate;

    private var chestEnabled : bool;
    private var chestPrevTemp : CEntityTemplate;

    private var leggingsEnabled : bool;
    private var leggingsPrevTemp : CEntityTemplate;

    private var bootsEnabled : bool;
    private var bootsPrevTemp : CEntityTemplate;

    private var glovesEnabled : bool;
    private var glovesPrevTemp : CEntityTemplate;

    private var stSwordEnabled : bool;
    private var stSwordCurEnt : CEntity;

    private var svSwordEnabled : bool;
    private var svSwordCurEnt : CEntity;

    private var stscabEnabled : bool;
    private var stscabPrevTemp: CEntityTemplate;

    private var noHairTuckEnabled : bool;
    private var noHairTuckPrevTemp: CEntityTemplate;

    private var svscabEnabled : bool;
    private var svscabPrevTemp: CEntityTemplate;

    private var svscabEnt : CEntity;
    private var stscabEnt : CEntity;

    private var hideSaddle : bool;
    private var hideReins : bool;
    private var hideHarness : bool;
    private var hideBags : bool;
    private var hideBlinders : bool;
    private var hideHorseHair : bool;
    private var hideTail : bool;
    private var hideTrophy : bool;

    private var saddlePrevTemp : CEntityTemplate;
    private var blindersPrevTemp : CEntityTemplate;
    private var horseHairPrevTemp : CEntityTemplate;
    private var tailsPrevTemp : CEntityTemplate;
    private var bagsPrevTemp : CEntityTemplate;
    private var trophiesPrevTemp : CEntityTemplate;
    private var reinsPrevTemp : CEntityTemplate;
    private var harnessPrevTemp : CEntityTemplate;
    private var devilFXToggle : bool;
    private var ruinFXToggle : bool;
    private var iceFXToggle : bool;

    private var saddleEnabled : bool;
    private var blindersEnabled : bool;
    private var horseHairEnabled : bool;
    private var tailsEnabled : bool;
    private var bagsEnabled : bool;
    private var trophiesEnabled : bool;
    private var reinsEnabled : bool;
    private var harnessEnabled : bool;

    private var prevTempHorseAccessories : array<CEntityTemplate>;
    private var horseAccessoriesEnabled : bool;
    private var horseAccessoriesPrevTemp : CEntityTemplate;

    private var horseDemonFX : bool;
    private var horseIceFX : bool;
    private var playerIceFX : bool;
    private var horseFireFX : bool;

    private var instantMount : bool;
    private var horseAnimationSpeedCauserID: int;
    private var boatAnimationSpeedCauserID: int;

    private var horseFlyMode: bool;
    private var horseInvis: bool;
    private var infiniteHorseStamina: bool;
    private var noHorsePanic: bool;
    private var infiniteSignStamina: bool;
    private var infiniteAdrenaline: bool;
    private var autoHeal: bool;
    private var noHorseRestrictions: bool;
    private var noLevelRequirements: bool;
    private var noDurability: bool;
    private var bloodbath: bool;
    private var unlimitedConsumables: bool;
    private var stealing: bool;
    private var ft: bool;

    private var damageMultiplier: bool;
    private var damageCrossbow: float;
    private var damageSign: float;
    private var damageFist: float;
    private var damageSwords: float;
    private var damageBombs: float;
    private var damageOverall: float;
    private var incomingDamageOverall: float;
    private var damageOT: float;

    private var steelIgniFX: bool;
    private var steelAardFX: bool;
    private var steelYrdenFX: bool;
    private var steelQuenFX: bool;
    private var steelAxiiFX: bool;
    private var steelRuneLvl: name;
    private var steelRuneType: name;
    private var steelOilType: name;
    private var steelRuneGlow: bool;

    private var silverIgniFX: bool;
    private var silverAardFX: bool;
    private var silverYrdenFX: bool;
    private var silverQuenFX: bool;
    private var silverAxiiFX: bool;
    private var silverRuneLvl: name;
    private var silverRuneType: name;
    private var silverOilType: name;
    private var silverRuneGlow: bool;

    private var hideCrossbow: bool;
    private var autoTeleportToWaypoint: bool;
    private var freezeTime: bool;
    private var noBorders: bool;
    private var unsinkable: bool;
    private var storedHoursPerMinute: float;
    
    private var paused: bool;
    private var lastActiveContext: name;

    private var appearancePath : string;

    private var menuOpen : bool;
    private var noStagger : bool;
    private var noCrossbowReload : bool;
    private var oilsNeverExpire : bool;
    private var invis : bool;
    private var wolvenCamera : WolvenCamera;
    private var m_lastActiveCam : CCustomCamera;
    private var freecam : bool;
    private var lastFreecamContext : name;

    public var newLoadScheduled : bool;

    function Init()
    {
        lastAction = 0;
        playerSpeed = 1;
        horseSpeed = 1;
        freecamSpeed = 1;
        freecamFOV = 60;
        freecamRoll = 0;
        damageCrossbow = 1;
        damageSign = 1;
        damageFist = 1;
        damageSwords = 1;
        damageBombs = 1;
        damageOverall = 1;
        incomingDamageOverall = 1;
        damageOT = 1;
        storedHoursPerMinute = theGame.GetHoursPerMinute();
        steelRuneLvl = 'none';
        steelRuneType = 'none';
        steelOilType = 'none';

        silverRuneLvl = 'none';
        silverRuneType = 'none';
        silverOilType = 'none';

        menuOpen = false;
    }

    public function setNewLoad( a : bool )
	{
		newLoadScheduled = a;
	}

	public function getNewLoad() : bool
	{
		return newLoadScheduled;
	}

    public function SetWolvenCamera( a : WolvenCamera )
	{
		this.wolvenCamera = a;
	}

	public function GetWolvenCamera() : WolvenCamera
	{
		return this.wolvenCamera;
	}

    public function setFreecam(val : bool)
    {
        freecam = val;
    }

    public function getFreecam() : bool
    {
        return freecam;
    }

    public function setLastFreecamContext(val : name)
    {
        lastFreecamContext = val;
    }

    public function getLastFreecamContext() : name
    {
        return lastFreecamContext;
    }

    public function setLastFreecamCam(val : CCustomCamera)
    {
        m_lastActiveCam = val;
    }

    public function getLastFreecamCam() : CCustomCamera
    {
        return m_lastActiveCam;
    }
    
    public function spawnWolvenCamera()
    {
        var template	: CEntityTemplate;
		var ent			: CEntity;

		template = (CEntityTemplate)LoadResource("dlc\dlcwolventrainer\data\wolven_camera.w2ent", true);

		ent = (CStaticCamera)theGame.CreateEntity(template, theCamera.GetCameraPosition(), theCamera.GetCameraRotation());	
    }

    function getMenuOpen() : bool
    {
        return menuOpen;
    }

    function setMenuOpen(val : bool)
    {
        menuOpen = val;
    }

    function stopAllFXRanOnce()
    {
        steelIgniFXranOnce = false;
        steelAardFXranOnce = false;
        steelAxiiFXranOnce = false;
        steelQuenFXranOnce = false;
        steelYrdenFXranOnce = false;
        steelRuneGlowRanOnce = false;

        silverIgniFXranOnce = false;
        silverAardFXranOnce = false;
        silverAxiiFXranOnce = false;
        silverQuenFXranOnce = false;
        silverYrdenFXranOnce = false;
        silverRuneGlowRanOnce = false;
    }

    function companionFollow(companion : CNewNPC)
    {
        var distanceToFollower, z 								: float;
		var horseComp											: W3HorseComponent;
		var dest1												: Vector;	
		var cameraRot											: EulerAngles;

        distanceToFollower = VecDistanceSquared2D( companion.GetWorldPosition(), thePlayer.GetWorldPosition() );

        if (distanceToFollower <= 5*5)
        {
            companion.GetMovingAgentComponent().SetGameplayRelativeMoveSpeed(0.f);
        }
        else if (distanceToFollower > 5*5 && distanceToFollower <= 10*10)
        {
            companion.GetMovingAgentComponent().SetGameplayRelativeMoveSpeed(2.f);
        }
        else if (distanceToFollower > 10*10)
        {
            companion.GetMovingAgentComponent().SetGameplayRelativeMoveSpeed(3.f);
        }

        companion.WolvenStartFollowing();

        companion.SetTemporaryAttitudeGroup( 'friendly_to_player', AGP_Default );	
    }

    function refresh()
	{
        var l_actors		: array<CActor>;
        var i : int;
	
        theGame.GetActorsByTag('WolvenTrainerCompanion', l_actors);

        for	( i = 0; i < l_actors.Size(); i+= 1 )
        {
            companionFollow(((CNewNPC) l_actors[i]));
        }

        if(autoTeleportToWaypoint)
        {
            pinTeleportInternal();
        }

        if(hideCrossbow)
        {
            if(!GetWitcherPlayer().IsWeaponHeld('crossbow'))
            {
                refreshCrossbow();
            }
        }

        if(!ApplySwordFX())
        {
            stopAllFXRanOnce();
        }

        if(flyMode && !freecam)
        {
            if(!thePlayer.GetHorseCurrentlyMounted())
            {
                fly();
            }
        }

        if(forcefield)
        {
            forcefieldLaunch();
        }

        if(infiniteBreath)
        {
            GetWitcherPlayer().abilityManager.ForceSetStat(BCS_Air, 100);
        }

        if(horseFlyMode)
        {
            if(thePlayer.GetHorseCurrentlyMounted())
            {
                horseFly();

                thePlayer.BlockAction( EIAB_Crossbow, 			'FlyMode');
                thePlayer.BlockAction( EIAB_CallHorse,			'FlyMode');
                thePlayer.BlockAction( EIAB_Signs, 				'FlyMode');
                thePlayer.BlockAction( EIAB_DrawWeapon, 			'FlyMode');
                thePlayer.BlockAction( EIAB_FastTravel, 			'FlyMode');
                thePlayer.BlockAction( EIAB_Fists, 				'FlyMode');
                thePlayer.BlockAction( EIAB_InteractionAction, 	'FlyMode');
                thePlayer.BlockAction( EIAB_UsableItem,			'FlyMode');
                thePlayer.BlockAction( EIAB_ThrowBomb,			'FlyMode');
                thePlayer.BlockAction( EIAB_SwordAttack,			'FlyMode');
                thePlayer.BlockAction( EIAB_LightAttacks,			'FlyMode');
                thePlayer.BlockAction( EIAB_HeavyAttacks,			'FlyMode');
                thePlayer.BlockAction( EIAB_SpecialAttackLight,	'FlyMode');
                thePlayer.BlockAction( EIAB_SpecialAttackHeavy,	'FlyMode');
                thePlayer.BlockAction( EIAB_Dodge,				'FlyMode');
                thePlayer.BlockAction( EIAB_Roll,					'FlyMode');
                thePlayer.BlockAction( EIAB_Parry,				'FlyMode');
                thePlayer.BlockAction( EIAB_MeditationWaiting,	'FlyMode');
                thePlayer.BlockAction( EIAB_OpenMeditation,		'FlyMode');
                thePlayer.BlockAction( EIAB_RadialMenu,			'FlyMode');
                thePlayer.BlockAction( EIAB_Movement,				'FlyMode');
                thePlayer.BlockAction( EIAB_Interactions, 		'FlyMode');
                thePlayer.BlockAction( EIAB_Jump, 				'FlyMode');
                thePlayer.BlockAction( EIAB_QuickSlots, 			'FlyMode');
            }
            else
            {
                thePlayer.UnblockAction( EIAB_Crossbow, 			'FlyMode');
                thePlayer.UnblockAction( EIAB_CallHorse,			'FlyMode');
                thePlayer.UnblockAction( EIAB_Signs, 				'FlyMode');
                thePlayer.UnblockAction( EIAB_DrawWeapon, 			'FlyMode');
                thePlayer.UnblockAction( EIAB_FastTravel, 			'FlyMode');
                thePlayer.UnblockAction( EIAB_Fists, 				'FlyMode');
                thePlayer.UnblockAction( EIAB_InteractionAction, 	'FlyMode');
                thePlayer.UnblockAction( EIAB_UsableItem,			'FlyMode');
                thePlayer.UnblockAction( EIAB_ThrowBomb,			'FlyMode');
                thePlayer.UnblockAction( EIAB_SwordAttack,			'FlyMode');
                thePlayer.UnblockAction( EIAB_LightAttacks,			'FlyMode');
                thePlayer.UnblockAction( EIAB_HeavyAttacks,			'FlyMode');
                thePlayer.UnblockAction( EIAB_SpecialAttackLight,	'FlyMode');
                thePlayer.UnblockAction( EIAB_SpecialAttackHeavy,	'FlyMode');
                thePlayer.UnblockAction( EIAB_Dodge,				'FlyMode');
                thePlayer.UnblockAction( EIAB_Roll,					'FlyMode');
                thePlayer.UnblockAction( EIAB_Parry,				'FlyMode');
                thePlayer.UnblockAction( EIAB_MeditationWaiting,	'FlyMode');
                thePlayer.UnblockAction( EIAB_OpenMeditation,		'FlyMode');
                thePlayer.UnblockAction( EIAB_RadialMenu,			'FlyMode');
                thePlayer.UnblockAction( EIAB_Movement,				'FlyMode');
                thePlayer.UnblockAction( EIAB_Interactions, 		'FlyMode');
                thePlayer.UnblockAction( EIAB_Jump, 				'FlyMode');
                thePlayer.UnblockAction( EIAB_QuickSlots, 			'FlyMode');
            }
        }

        if(theGame.getWolvenTrainer().getInfiniteHorseStamina())
        {
            refillHorseStamina();
        }
        if(theGame.getWolvenTrainer().getInfiniteSignStamina())
        {
            refillSignStamina();
        }
        if(theGame.getWolvenTrainer().getInfiniteAdrenaline())
        {
            refillInfiniteAdrenaline();
        }
        if(theGame.getWolvenTrainer().getAutoHeal())
        {
            refillAutoHeal();
        }
        if(theGame.getWolvenTrainer().getUnlimitedConsumables())
        {
            thePlayer.inv.SingletonItemsRefillAmmoNoAlco(true);
        }
	}

    function fly()
    {
        var direction : Vector;
        var dest : Vector;
	    var ticket : SMovementAdjustmentRequestTicket;
	    var movementAdjustor : CMovementAdjustor;
	    var settings_interrupt : SAnimatedComponentSlotAnimationSettings;
        var movementAmount : float;
        var forward : EulerAngles;
        var right : Vector;
        var magnitude : float;
        var inputX : float;
		var inputY : float;
        var freecamPosition : Vector;

        forward = theCamera.GetCameraRotation();
        freecamPosition = thePlayer.GetWorldPosition();

        settings_interrupt.blendIn = 0;
        settings_interrupt.blendOut = 0;

        GetWitcherPlayer().GetRootAnimatedComponent().PlaySlotAnimationAsync( '', 'PLAYER_SLOT', settings_interrupt);

        movementAdjustor = GetWitcherPlayer().GetMovingAgentComponent().GetMovementAdjustor();
        movementAdjustor.CancelByName( 'jumpextend' );
        movementAdjustor.CancelAll();

        ticket = movementAdjustor.CreateNewRequest( 'jumpextend' );
        movementAdjustor.AdjustmentDuration( ticket, 0.5 );
        movementAdjustor.AdjustLocationVertically( ticket, true );
        movementAdjustor.ScaleAnimationLocationVertically( ticket, true );

        movementAmount = 10;
        dest = thePlayer.GetWorldPosition();

        if(theInput.IsActionPressed('Sprint'))
        {
            movementAmount = movementAmount * 2;
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

        forward.Pitch += inputY;
		forward.Yaw -= inputX;

		freecamPosition += RotForward(forward) * theInput.GetActionValue('GI_AxisLeftY') * movementAmount;
		freecamPosition += RotRight(forward) * theInput.GetActionValue('GI_AxisLeftX') * movementAmount;

        if(theInput.IsActionPressed('Jump') || theInput.IsActionPressed('DiveUp'))
        {
            freecamPosition.Z += movementAmount;
        }
        if(theInput.IsActionPressed('SwordSheathe')|| theInput.IsActionPressed('DiveDown'))
        {
            freecamPosition.Z += movementAmount * -1;
        }
        
        movementAdjustor.MaxLocationAdjustmentDistance(ticket, true, 500, 500);
        movementAdjustor.SlideTo(ticket, freecamPosition);
        movementAdjustor.RotateTo( ticket, VecHeading( theCamera.GetCameraDirection()));
            
    }

    function horseFly()
    {
        var direction : Vector;
        var dest, prev_pos				 								: Vector;
	    var ticket 														: SMovementAdjustmentRequestTicket;
	    var movementAdjustor											: CMovementAdjustor;
	    var settings_interrupt											: SAnimatedComponentSlotAnimationSettings;
        var movementAmount : float;
        var theHorse : CNewNPC;
        var forward : EulerAngles;
        var inputX : float;
		var inputY : float;
        var freecamPosition : Vector;
        var horseComp : W3HorseComponent;
        
        theHorse = thePlayer.GetHorseWithInventory();
        if(!theHorse ||	!theHorse.IsAlive()) {
            return;
        }

        horseComp = ((CNewNPC)theHorse).GetHorseComponent();			
		if( !horseComp )
			return;
			
		if( !horseComp.IsFullyMounted() )
			return;

        forward = theCamera.GetCameraRotation();
        freecamPosition = theHorse.GetWorldPosition();

        settings_interrupt.blendIn = 0;
        settings_interrupt.blendOut = 0;

        movementAdjustor = theHorse.GetMovingAgentComponent().GetMovementAdjustor();
        movementAdjustor.CancelByName( 'jumpextend' );
        movementAdjustor.CancelAll();

        ticket = movementAdjustor.CreateNewRequest( 'jumpextend' );
        movementAdjustor.AdjustmentDuration( ticket, 0.5 );
        movementAdjustor.AdjustLocationVertically( ticket, true );
        movementAdjustor.ScaleAnimationLocationVertically( ticket, true );

        movementAmount = 10;
        dest = theHorse.GetWorldPosition();

        if(theInput.IsActionPressed('Canter') || theInput.IsActionPressed('Gallop'))
        {
            movementAmount = movementAmount * 2;
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

        forward.Pitch += inputY;
		forward.Yaw -= inputX;

		freecamPosition += RotForward(forward) * theInput.GetActionValue('GI_AxisLeftY') * movementAmount;
		freecamPosition += RotRight(forward) * theInput.GetActionValue('GI_AxisLeftX') * movementAmount;

        if(theInput.IsActionPressed('HorseJump'))
        {
            freecamPosition.Z += movementAmount;
        }
        if(theInput.IsActionPressed('SwordSheathe'))
        {
            freecamPosition.Z += movementAmount * -1;
        }

        movementAdjustor.MaxLocationAdjustmentDistance(ticket, true, 500, 500);
        movementAdjustor.SlideTo(ticket, freecamPosition);
        movementAdjustor.RotateTo( ticket, VecHeading( theCamera.GetCameraDirection() ));
            
    }

    function pushEntity(entity : CActor)
    {
        var direction : Vector;
        var dest, prev_pos				 								: Vector;
	    var ticket 														: SMovementAdjustmentRequestTicket;
	    var movementAdjustor											: CMovementAdjustor;
	    var settings_interrupt											: SAnimatedComponentSlotAnimationSettings;
        var movementAmount : float;

        settings_interrupt.blendIn = 0;
        settings_interrupt.blendOut = 0;

        prev_pos = entity.GetWorldPosition();

        movementAdjustor = entity.GetMovingAgentComponent().GetMovementAdjustor();
        movementAdjustor.CancelByName( 'pushvelocity' );
        movementAdjustor.CancelAll();

        ticket = movementAdjustor.CreateNewRequest( 'pushvelocity' );
        movementAdjustor.AdjustmentDuration( ticket, 0.25 );
        movementAdjustor.AdjustLocationVertically( ticket, true );
        movementAdjustor.ScaleAnimationLocationVertically( ticket, true );

        movementAmount = 3;
        direction = prev_pos - thePlayer.GetWorldPosition();
        direction = VecNormalize(direction);

        dest = prev_pos + direction * movementAmount;

        movementAdjustor.MaxLocationAdjustmentDistance(ticket, true, 50, 50);
        movementAdjustor.SlideTo(ticket, dest);
    }

    function forcefieldLaunch()
    {
        var forcefieldEnemies : array<CGameplayEntity>;
        var i : int;
        var entityName : string;
        var actor : CActor;

        FindGameplayEntitiesInSphere( forcefieldEnemies, GetWitcherPlayer().GetWorldPosition(), 5, 100 );
        for( i = 0; i < forcefieldEnemies.Size(); i += 1 )
        {
            entityName = forcefieldEnemies[i].GetDisplayName();
            if(entityName != "" && entityName != "Geralt")
            {
                actor = (CActor)forcefieldEnemies[i];
                pushEntity(actor);
            }
        
        }
    }

    function flyEffect()
    {
        if(flyMode)
        {
            GetWitcherPlayer().PlayEffect( 'shadowdash' );
            GetWitcherPlayer().StopEffect( 'shadowdash' );
        }
    }

    function CreateTemplate( entpath : string ) : CEntityTemplate
    {
        var temp : CEntityTemplate;
        temp = (CEntityTemplate)LoadResource(entpath, true);
        
        return temp;
    }

    function GearToggle(enabled : bool, template : CEntityTemplate, prevTemp : CEntityTemplate) : CEntityTemplate
    {

        var l_actor : CActor;
        var l_comp : CComponent;
        
        l_actor = thePlayer;
        l_comp = l_actor.GetComponentByClassName( 'CAppearanceComponent' );
        
        ((CAppearanceComponent)l_comp).ExcludeAppearanceTemplate(prevTemp);

        if(enabled)
        {
            ((CAppearanceComponent)l_comp).IncludeAppearanceTemplate(template);
        }
        
        return template;
    }

    function ChestAppearance(enabled : bool)
    {
        var inv : CInventoryComponent;
        var ids : array<SItemUniqueId>;
        var size : int;
        var i	: int;
        var witcher : W3PlayerWitcher;
        var itemId : SItemUniqueId;
        var ent : CEntity;
        
        inv = thePlayer.GetInventory();
        witcher = GetWitcherPlayer();
        
        if(witcher.GetItemEquippedOnSlot(EES_Armor, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
        }
        else
        {
            ids = inv.GetItemsByName('Body torso medalion');
            size = ids.Size();
            if(!enabled)
            {          
                for( i = 0; i < size; i+=1 )
                {
                    inv.DespawnItem(ids[i]);
                }	
            }
            else
            {
                if(size > 0)
                {
                    inv.MountItem(ids[0]);
                }
                else
                {
                    ids.Clear();
                    ids = inv.AddAnItem('Body torso medalion');
                    inv.MountItem(ids[0]);
                }			
            }
        } 
    }
    function LeggingsAppearance(enabled : bool)
    {
        var inv : CInventoryComponent;
        var ids : array<SItemUniqueId>;
        var size : int;
        var i	: int;
        var witcher : W3PlayerWitcher;
        var itemId : SItemUniqueId;
        var ent : CEntity;
        
        
        inv = thePlayer.GetInventory();
        witcher = GetWitcherPlayer();
        				
        if(witcher.GetItemEquippedOnSlot(EES_Pants, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
        }
        else
        {
            ids = inv.GetItemsByName('Body underwear 01');
            size = ids.Size();
            if(!enabled)
            {             
                for( i = 0; i < size; i+=1 )
                {
                    inv.DespawnItem(ids[i]);
                }	
            }
            else
            {
                if(size > 0)
                {
                    inv.MountItem(ids[0]);
                }
                else
                {
                    ids.Clear();
                    ids = inv.AddAnItem('Body underwear 01');
                    inv.MountItem(ids[0]);
                }			
            }
        }
    }

    function GlovesAppearance(enabled : bool)
    {
        var inv : CInventoryComponent;
        var ids : array<SItemUniqueId>;
        var size : int;
        var i	: int;
        var witcher : W3PlayerWitcher;
        var itemId : SItemUniqueId;
        var ent : CEntity;
        
        
        inv = thePlayer.GetInventory();
        witcher = GetWitcherPlayer();
        
		if(witcher.GetItemEquippedOnSlot(EES_Gloves, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
		}
		else
        {
			ids = inv.GetItemsByName('Body palms 01');
			size = ids.Size();
			if(!enabled)
            {
				for( i = 0; i < size; i+=1 
                ){
						inv.DespawnItem(ids[i]);
				}	
			}
			else
            {
				if(size > 0)
                {
					inv.MountItem(ids[0]);
				}
				else
                {
					ids.Clear();
					ids = inv.AddAnItem('Body palms 01');
					inv.MountItem(ids[0]);
				}			
			}
		}
    }

    function BootsAppearance(enabled : bool)
    {
        var inv : CInventoryComponent;
        var ids : array<SItemUniqueId>;
        var size : int;
        var i	: int;
        var witcher : W3PlayerWitcher;
        var itemId : SItemUniqueId;
        var ent : CEntity;
        
        inv = thePlayer.GetInventory();
        witcher = GetWitcherPlayer();
        
		if(witcher.GetItemEquippedOnSlot(EES_Boots, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
		}
		else
        {
			ids = inv.GetItemsByName('Body feet 01');
			size = ids.Size();
			if(!enabled)
            {
				for( i = 0; i < size; i+=1 ){
						inv.DespawnItem(ids[i]);
				}	
			}
			else
            {
				if(size > 0)
                {
					inv.MountItem(ids[0]);
				}
				else
                {
					ids.Clear();
					ids = inv.AddAnItem('Body feet 01');
					inv.MountItem(ids[0]);
				}			
			}
		}
    }

    function ArmorToggle(enabled : bool)
    {
        var inv : CInventoryComponent;
        var ids : array<SItemUniqueId>;
        var size : int;
        var i	: int;
        var witcher : W3PlayerWitcher;
        var itemId : SItemUniqueId;
        var ent : CEntity;
        
        inv = thePlayer.GetInventory();
        witcher = GetWitcherPlayer();
        
        if(witcher.GetItemEquippedOnSlot(EES_Armor, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
        }
        else
        {
            ids = inv.GetItemsByName('Body torso medalion');
            size = ids.Size();
            if(!enabled)
            {
                for( i = 0; i < size; i+=1 )
                {
                    inv.DespawnItem(ids[i]);
                }	
            }
            else
            {
                if(size > 0)
                {
                    inv.MountItem(ids[0]);
                }
                else
                {
                    ids.Clear();
                    ids = inv.AddAnItem('Body torso medalion');
                    inv.MountItem(ids[0]);
                }			
            }
        }

        ids.Clear();

        if(witcher.GetItemEquippedOnSlot(EES_Gloves, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
        }
        else
        {
            ids = inv.GetItemsByName('Body palms 01');
            size = ids.Size();
            if(!enabled)
            {
                for( i = 0; i < size; i+=1 )
                {
                    inv.DespawnItem(ids[i]);
                }	
            }
            else
            {
            
                if(size > 0)
                {
                    inv.MountItem(ids[0]);
                }
                else
                {
                    ids.Clear();
                    ids = inv.AddAnItem('Body palms 01');
                    inv.MountItem(ids[0]);
                }			
            }
        }
        
        ids.Clear();

        if(witcher.GetItemEquippedOnSlot(EES_Pants, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
         }
        else
        {
            ids = inv.GetItemsByName('Body underwear 01');
            size = ids.Size();
            if(!enabled)
            {
                for( i = 0; i < size; i+=1 )
                {
                    inv.DespawnItem(ids[i]);
                }	
            }
            else
            {
                if(size > 0)
                {
                    inv.MountItem(ids[0]);
                }
                else
                {
                    ids.Clear();
                    ids = inv.AddAnItem('Body underwear 01');
                    inv.MountItem(ids[0]);
                }			
            }
        }
        
        ids.Clear();
        
        if(witcher.GetItemEquippedOnSlot(EES_Boots, itemId))
        {		
            if(!enabled)
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(true);
            }
            else
            {
                ent = inv.GetItemEntityUnsafe(itemId);
                ent.SetHideInGame(false);
            }
        }
        else
        {
            ids = inv.GetItemsByName('Body feet 01');
            size = ids.Size();
            if(!enabled)
            {              
                for( i = 0; i < size; i+=1 )
                {
                    inv.DespawnItem(ids[i]);
                }	
            }
            else{
            
                if(size > 0)
                {
                    inv.MountItem(ids[0]);
                }
                else
                {
                    ids.Clear();
                    ids = inv.AddAnItem('Body feet 01');
                    inv.MountItem(ids[0]);
                }			
            }
        }
    }

    function disableHair()
    {
        hairEnabled = false;
        Hidehair();
    }

    function enableHair()
    {
        hairEnabled = true;
    }

    function ApplyHair(hairName : name)
    {
        if(hairEnabled)
        {
            SetHairstyle(hairName);
        }
    }

    function Hidehair()
    {
		var inv : CInventoryComponent;
		var ids : array<SItemUniqueId>;
		var size : int;
		var i		: int;
		
		inv = thePlayer.GetInventory();

		ids = inv.GetItemsByCategory( 'hair' );
		size = ids.Size();
		
		if( size > 0 )
		{
			for( i = 0; i < size; i+=1 )
			{
				if(inv.IsItemMounted( ids[i] ) )
					inv.DespawnItem(ids[i]);
			}
			
		}
	}

    function restoreHair()
    {

		var inv : CInventoryComponent;
		var ids : array<SItemUniqueId>;
		var size : int;
		var i		: int;
		
		inv = thePlayer.GetInventory();

		ids = inv.GetItemsByCategory( 'hair' );
		size = ids.Size();
		
		if( size > 0 )
		{
			for( i = 0; i < size; i+=1 )
			{
				inv.MountItem(ids[i]);
			}
			
		}
	}
    function SetHairstyle(hairStyle : name)
    {
		var inv : CInventoryComponent;
		var witcher : W3PlayerWitcher;
		var ids : array<SItemUniqueId>;

		var size : int;
		var i : int;

		witcher = GetWitcherPlayer();
		inv = witcher.GetInventory();

		ids = inv.GetItemsByCategory( 'hair' );
		size = ids.Size();
		
		if( size > 0 )
		{
			for( i = 0; i < size; i+=1 )
			{
				inv.RemoveItem(ids[i], 1);
			}
			
		}
		
		ids.Clear();
		
		ids = inv.AddAnItem(hairStyle);
		
		inv.MountItem(ids[0]);
	}

    function disableHead()
    {
        headEnabled = false;
        ApplyHead("");
    }

    function enableHead()
    {
        headEnabled = true;
    }

    function ApplyHead(template : string)
    {
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);

        if(headEnabled)
        {
            Hidehair();
            headPrevTemp = GearToggle(true,temp,headPrevTemp);
        }
        else 
        {
            restoreHair();
            GearToggle(false,temp,headPrevTemp);
        }
    }

    function disableMask()
    {
        maskEnabled = false;
        ApplyMask("");
    }

    function enableMask()
    {
        maskEnabled = true;
    }

    function ApplyMask(template : string)
    {
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(maskEnabled)
        {
            maskPrevTemp = GearToggle(true,temp,maskPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,maskPrevTemp);
        }
    }

    function disableShoulder()
    {
        shoulderEnabled = false;
        ApplyShoulder("");
    }

    function enableShoulder()
    {
        shoulderEnabled = true;
    }

    function ApplyShoulder(template : string){
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(shoulderEnabled)
        {
            shoulderPrevTemp = GearToggle(true,temp,shoulderPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,shoulderPrevTemp);
        }
    }

    function disableChest()
    {
        chestEnabled = false;
        ApplyChest("");
    }

    function enableChest()
    {
        chestEnabled = true;
    }

    function ApplyChest(template : string)
    {
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(chestEnabled)
        {
            chestPrevTemp = GearToggle(true,temp,chestPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,chestPrevTemp);
        }
    }

    function disableLeggings()
    {
        leggingsEnabled = false;
        ApplyLeggings("");
    }

    function enableLeggings()
    {
        leggingsEnabled = true;
    }

    function ApplyLeggings(template : string)
    {
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(leggingsEnabled)
        {
            leggingsPrevTemp = GearToggle(true,temp,leggingsPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,leggingsPrevTemp);
        }
    }

    function disableAccessories()
    {
        var i : int;
        var l_actor : CActor;
        var l_comp : CComponent;
        
        l_actor = thePlayer;
        l_comp = l_actor.GetComponentByClassName( 'CAppearanceComponent' );
        i = 0;

        accessoriesEnabled = false;

        for(i = 0; i < prevTempAccessories.Size(); i+=1)
        {
            ((CAppearanceComponent)l_comp).ExcludeAppearanceTemplate(prevTempAccessories[i]);
        }
        prevTempAccessories.Clear();
    }

    function enableAccessories()
    {
        accessoriesEnabled = true;
    }

    function ApplyAccessories(template : string){
        var temp : CEntityTemplate;
        var i : int;
        var l_actor : CActor;
        var l_comp : CComponent;
        
        l_actor = thePlayer;
        l_comp = l_actor.GetComponentByClassName( 'CAppearanceComponent' );
        i = 0;

        temp = CreateTemplate(template);
        prevTempAccessories.PushBack(temp);
        if(accessoriesEnabled)
        {
            ((CAppearanceComponent)l_comp).IncludeAppearanceTemplate(temp);
        }
    }

    function disableFullBody()
    {
        fullBodyEnabled = false;
        ApplyFullBody("");
    }

    function enableFullBody()
    {
        fullBodyEnabled = true;
    }

    function ApplyFullBody(template : string){
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(fullBodyEnabled)
        {
            fullBodyPrevTemp = GearToggle(true,temp,fullBodyPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,fullBodyPrevTemp);
        }
    }

    function disableGloves()
    {
        glovesEnabled = false;
        ApplyGloves("");
    }

    function enableGloves()
    {
        glovesEnabled = true;
    }

    function ApplyGloves(template : string)
    {
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(glovesEnabled)
        {
            glovesPrevTemp = GearToggle(true,temp,glovesPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,glovesPrevTemp);
        }
    }

    function disableNoHairTuck()
    {
        noHairTuckEnabled = false;
        ApplyNoHairTuck("");
    }

    function getNoHairTuck() : bool
    {
        return noHairTuckEnabled;
    }

    function enableNoHairTuck()
    {
        noHairTuckEnabled = true;
    }

    function ApplyNoHairTuck(template : string){
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(noHairTuckEnabled)
        {
            noHairTuckPrevTemp = GearToggle(true,temp,noHairTuckPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,noHairTuckPrevTemp);
        }
    }

    function disableBoots()
    {
        bootsEnabled = false;
        ApplyBoots("");
    }

    function enableBoots()
    {
        bootsEnabled = true;
    }

    function ApplyBoots(template : string)
    {
        var temp : CEntityTemplate;

        temp = CreateTemplate(template);
        if(bootsEnabled)
        {
            bootsPrevTemp = GearToggle(true,temp,bootsPrevTemp);
        }
        else 
        {
            GearToggle(false,temp,bootsPrevTemp);
        }
    }

    function disableCape()
    {
        capeEnabled = false;
        ApplyCape("");
    }

    function enableCape()
    {
        capeEnabled = true;
    }

    function ApplyCape(template : string)
    {
        var tempCape : CEntityTemplate;

        tempCape = CreateTemplate(template);
        if(capeEnabled)
        {
            capePrevTemp = GearToggle(true,tempCape,capePrevTemp);
        }
        else if(capeEnabled == false)
        {
            GearToggle(false,tempCape,capePrevTemp);
        }
    }

    function disableSteelSwords()
    {
        stSwordEnabled = false;
        SteelSwordChange("");
    }

    function enableSteelSwords()
    {
        stSwordEnabled = true;
    }

    function HideSwords()
    {
        var ent, ent2 : CEntity;
		var inv : CInventoryComponent;
		var i    : float;
		var temp : CEntityTemplate;
		var item : SItemUniqueId;
		var meshcomp, animcomp : CComponent;
		var wSword : CWitcherSword;
		var visible : bool;

		inv = thePlayer.GetInventory();

        GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, item);

        ent = inv.GetItemEntityUnsafe(item);
        animcomp = ent.GetComponentByClassName('CAnimatedComponent');
        meshcomp = ent.GetComponentByClassName('CMeshComponent');

        ((CMeshComponent)meshcomp).SetVisible(false);

        GetWitcherPlayer().GetItemEquippedOnSlot(EES_SilverSword, item);

        ent = inv.GetItemEntityUnsafe(item);
        animcomp = ent.GetComponentByClassName('CAnimatedComponent');
        meshcomp = ent.GetComponentByClassName('CMeshComponent');

        ((CMeshComponent)meshcomp).SetVisible(false);

    }
    function SteelSwordChange(sword : string)
    {
		var ent, ent2 : CEntity;
		var inv : CInventoryComponent;
		var i    : float;
		var temp : CEntityTemplate;
		var item : SItemUniqueId;
		var meshcomp, animcomp : CComponent;
		var wSword : CWitcherSword;
		var visible : bool;

		inv = thePlayer.GetInventory();

        GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, item);

        ent = inv.GetItemEntityUnsafe(item);

        animcomp = ent.GetComponentByClassName('CAnimatedComponent');
        meshcomp = ent.GetComponentByClassName('CMeshComponent');

        stSwordCurEnt.Destroy();
        
        if(stSwordEnabled)
        {
            visible = false;
            
            temp = CreateTemplate(sword);
            ent2 = theGame.CreateEntity(temp, ent.GetWorldPosition(), ent.GetWorldRotation());
                        
            ent2.CreateAttachment( ent );
            
            stSwordCurEnt = ent2;
        }
        else
        {
            visible = true;
        }

        ((CMeshComponent)meshcomp).SetVisible(visible);
	}

    function disableSilverSwords()
    {
        svSwordEnabled = false;
        SilverSwordChange("");
    }

    function enableSilverSwords()
    {
        svSwordEnabled = true;
    }

    function SilverSwordChange(sword : string)
    {
		var ent, ent2 : CEntity;
		var inv : CInventoryComponent;
		var i    : float;
		var temp : CEntityTemplate;
		var item : SItemUniqueId;
		var meshcomp, animcomp : CComponent;
		var wSword : CWitcherSword;
		var visible : bool;

		inv = thePlayer.GetInventory();

        GetWitcherPlayer().GetItemEquippedOnSlot(EES_SilverSword, item);

        ent = inv.GetItemEntityUnsafe(item);

        animcomp = ent.GetComponentByClassName('CAnimatedComponent');
        meshcomp = ent.GetComponentByClassName('CMeshComponent');
        
        svSwordCurEnt.Destroy();
        
        if(svSwordEnabled)
        {
            visible = false;
            
            temp = CreateTemplate(sword);
            ent2 = theGame.CreateEntity(temp, ent.GetWorldPosition(), ent.GetWorldRotation());

            ent2.CreateAttachment( ent );
            
            svSwordCurEnt = ent2;
        }
        else
        {
            visible = true;
        }

        ((CMeshComponent)meshcomp).SetVisible(visible);
	}

    function disableSteelScabbard()
    {
        stscabEnabled = false;
        ApplyStscab("");
    }

    function enableSteelScabbard()
    {
        stscabEnabled = true;
    }

    function ApplyStscab(temp : string)
    {
		var tempStscab : CEntityTemplate;

		tempStscab = CreateTemplate(temp);

        if(stscabEnabled)
        {
            stscabPrevTemp = GearToggle(true,tempStscab,stscabPrevTemp);
        }
        else
        {
            GearToggle(false,tempStscab,stscabPrevTemp);
        }
	}

    function disableSilverScabbard()
    {
        svscabEnabled = false;
        ApplySvscab("");
    }

    function enableSilverScabbard()
    {
        svscabEnabled = true;
    }

    function ApplySvscab(temp : string)
    {
		var tempSvscab : CEntityTemplate;

		tempSvscab = CreateTemplate(temp);

        if(stscabEnabled)
        {
            svscabPrevTemp = GearToggle(true,tempSvscab,svscabPrevTemp);
        }
        else
        {
            GearToggle(false,tempSvscab,svscabPrevTemp);
        }
	}

    function hideSteelScabbard(hide : bool)
    {
		var inv : CInventoryComponent;
		var ids : array<SItemUniqueId>;
		var size : int;
		var i	: int;
		var ent : CEntity;
		
		inv = thePlayer.GetInventory();
		
		ids = inv.GetItemsByCategory('steel_scabbards');
		size = ids.Size();

        if( size > 0)
        {
            for( i = 0; i < size; i+=1 )
            {
                if(hide)
                {
                    ent = inv.GetItemEntityUnsafe(ids[i]);
                    ent.SetHideInGame(true);
                    stscabEnt = ent;
                                                
                }
                else
                {
                    ent = inv.GetItemEntityUnsafe(ids[i]);
                    ent.SetHideInGame(false);
                    stscabEnt.SetHideInGame(false);
                }
            }
        }
	}
	
	function hideSilverScabbard(hide : bool)
    {
		var inv : CInventoryComponent;
		var ids : array<SItemUniqueId>;
		var size : int;
		var i	: int;
		var ent : CEntity;
		
		inv = thePlayer.GetInventory();
		
		ids = inv.GetItemsByCategory('silver_scabbards');
		size = ids.Size();
		
        if( size > 0)
        {  
            for( i = 0; i < size; i+=1 )
            {
                if(hide)
                {
                    ent = inv.GetItemEntityUnsafe(ids[i]);
                    ent.SetHideInGame(true);
                    svscabEnt = ent;
                                                    
                }
                else
                {
                    ent = inv.GetItemEntityUnsafe(ids[i]);
                    ent.SetHideInGame(false);
                    svscabEnt.SetHideInGame(false);
                }
            }
        }
	}

    function toggleHead(enabled : bool)
    {
        var inv : CInventoryComponent;
        var witcher : W3PlayerWitcher;
        var ids : array<SItemUniqueId>;
        var size : int;
        var i : int;		
        
		witcher = GetWitcherPlayer();
		inv = thePlayer.GetInventory();
		ids = inv.GetItemsByCategory('head');
		
		size = ids.Size();
		
		for(i=0;i < size;i+=1)
        {
			if(enabled == false)
            {
				inv.DespawnItem(ids[i]);			
			}
		}
	}

    function removeAllComponents()
    {
        restoreOutfitInternal();
        ArmorToggle(false);
        disableHair();
        disableHead();
        Hidehair();
        disableMask();
        disableShoulder();
        disableAccessories();
        disableCape();
        disableSteelSwords();
        disableSilverSwords();
        HideSwords();
        hideSteelScabbard(true);
        hideSilverScabbard(true);
    }

    function hideHorseEquipment()
    {
		var horse			: CNewNPC;
		var horseInv 		: CInventoryComponent;
		var ids : array<SItemUniqueId>;
		var ent : CEntity;
		var size , i : int;
			
		horse = thePlayer.GetHorseWithInventory();
		
		horseInv = horse.GetInventory();
		horseInv.GetAllItems(ids);

		size = ids.Size();
		
        for(i = 0; i < size; i += 1)
        {
            if ( horseInv.ItemHasTag(ids[i], 'Saddle')  )
            {	
                ent = horseInv.GetItemEntityUnsafe(ids[i]);
                if(hideSaddle)
                {
                    ent.SetHideInGame(true);
                }
                else
                {
                    ent.SetHideInGame(false);
                }
                
            }
            
            if ( horseInv.ItemHasTag(ids[i], 'HorseBag')  )
            {	
                ent = horseInv.GetItemEntityUnsafe(ids[i]);
                if(hideBags)
                {
                    ent.SetHideInGame(true);
                }
                else
                {
                    ent.SetHideInGame(false);
                }
                
            }
            
            if ( horseInv.ItemHasTag(ids[i], 'Blinders')  )
            {	
                ent = horseInv.GetItemEntityUnsafe(ids[i]);
                if(hideBlinders)
                {
                    ent.SetHideInGame(true);
                }
                else
                {
                    ent.SetHideInGame(false);
                }
                
            }
            
            if ( horseInv.ItemHasTag(ids[i], 'HorseTail')  )
            {	
                ent = horseInv.GetItemEntityUnsafe(ids[i]);
                if(hideTail)
                {
                    ent.SetHideInGame(true);
                }
                else
                {
                    ent.SetHideInGame(false);
                }
                
            }
            
            if ( horseInv.ItemHasTag(ids[i], 'Trophy')  )
            {	
                ent = horseInv.GetItemEntityUnsafe(ids[i]);
                if(hideTrophy)
                {
                    ent.SetHideInGame(true);
                }
                else
                {
                    ent.SetHideInGame(false);
                }
                
            }
            
            if ( horseInv.ItemHasTag(ids[i], 'HorseReins')  )
            {	
                ent = horseInv.GetItemEntityUnsafe(ids[i]);

                if(hideReins)
                {
                    ent.SetHideInGame(true);
                }
                else
                {
                    ent.SetHideInGame(false);
                }
                
            }                 
        }
        
        ids.Clear();
        ids = horseInv.GetItemsByCategory('horse_hair');
        size = ids.Size();

        for(i = 0; i < size; i += 1)
        {
            ent = horseInv.GetItemEntityUnsafe(ids[i]);
            if(hideHorseHair)
            {
                ent.SetHideInGame(true);
            }
            else
            {
                ent.SetHideInGame(false);
            }
        }
        
        ids.Clear();
        ids = horseInv.GetItemsByCategory('horse_harness');
        size = ids.Size();

        for(i = 0; i < size; i += 1)
        {
            ent = horseInv.GetItemEntityUnsafe(ids[i]);

            if(hideHarness)
            {
                ent.SetHideInGame(true);
            }
            else
            {
                ent.SetHideInGame(false);
            }
        }
	}

    function refreshCrossbow()
    {
        var inv : CInventoryComponent;
        var ent : CEntity;	
        var item : SItemUniqueId;
        inv = thePlayer.GetInventory();

        GetWitcherPlayer().GetItemEquippedOnSlot(EES_RangedWeapon, item);		

        if(hideCrossbow)
        {
            ent = inv.GetItemEntityUnsafe(item);
            ent.SetHideInGame(true);
        }
        else
        {
            ent = inv.GetItemEntityUnsafe(item);
            ent.SetHideInGame(false);
        }
    }

    function removePin()
    {
		var manager	: CCommonMapManager = theGame.GetCommonMapManager();
		var worldPath : string;
		var realShownArea : EAreaName;
		var area : int;
		var position : Vector;
		var idToAdd, idToRemove, indexToAdd : int;
		var realType : int;
        var id : int;
        var i : int;
        var type : int;
		
		idToAdd = 0;
		idToRemove = 0;
		
        worldPath = theGame.GetWorld().GetDepotPath();
        realShownArea = manager.GetAreaFromWorldPath( worldPath, true );

        if (manager.GetIdOfFirstUser1MapPin(id))
        {
            i = manager.GetUserMapPinIndexById(id);
            manager.GetUserMapPinByIndex( i, id, area, position.X, position.Y, type );
            position.Z = 0;
		
		    realType = type;

            manager.ToggleUserMapPin( (int)realShownArea, position, realType, false, idToAdd, idToRemove );
        }
        else
        {
            GetWitcherPlayer().DisplayHudMessage("No map marker to remove!");
        }
    }

    function pinTeleportInternal()
    {
        var mapManager 		: CCommonMapManager = theGame.GetCommonMapManager();
        var rootMenu		: CR4Menu = theGame.GetGuiManager().GetRootMenu();
        var currWorld		: CWorld = theGame.GetWorld();
        var destWorldPath	: string;
        var id				: int;
        var area			: int;
        var type			: int;
        var position		: Vector;
        var rotation 		: EulerAngles;
        var goToCurrent		: Bool = false;
        var goToOther		: Bool = false;
        var i				: int;
        
        if (mapManager.GetIdOfFirstUser1MapPin(id))
        {
            i = mapManager.GetUserMapPinIndexById(id);
            mapManager.GetUserMapPinByIndex( i, id, area, position.X, position.Y, type );
            destWorldPath = mapManager.GetWorldPathFromAreaType( area );
            
            if (destWorldPath == currWorld.GetPath() )
            {
                goToCurrent = true;
            }
            else
            {
                goToOther = true;
            }
        }
        else
        {
            if(autoTeleportToWaypoint)
            {
                return;
            }
            else
            {
                GetWitcherPlayer().DisplayHudMessage("No map marker found!");
                return;
            }
        }
        
        if (goToCurrent)
        {
            currWorld.NavigationComputeZ(position, -500.f, 500.f, position.Z);
            
            thePlayer.Teleport( position );
            
            if ( !currWorld.NavigationComputeZ(position, -500.f, 500.f, position.Z) )		
            {
                thePlayer.AddTimer( 'DebugWaitForNavigableTerrain', 0.25f, true );
            }
        }
        else if (goToOther)
        {
            theGame.ScheduleWorldChangeToPosition( destWorldPath, position, rotation );
            thePlayer.AddTimer( 'DebugWaitForNavigableTerrain', 0.25f, true, , , true );
        }
        
        if (rootMenu)
        {
            rootMenu.CloseMenu();
        }
    }

    function customPinTeleportInternal(destWorldPath : string, posX : float, posY : float)
    {
        var mapManager 		: CCommonMapManager = theGame.GetCommonMapManager();
        var currWorld		: CWorld = theGame.GetWorld();
        var position		: Vector;
        var rotation 		: EulerAngles;
        var goToCurrent		: bool = false;
        var goToOther		: bool = false;

        position.X = posX;
        position.Y = posY;
        
        if (destWorldPath == currWorld.GetPath())
        {
            goToCurrent = true;
        }
        else
        {
            goToOther = true;
        }
        
        if (goToCurrent)
        {
            currWorld.NavigationComputeZ(position, -500.f, 500.f, position.Z);
            
            thePlayer.Teleport( position );
            
            if ( !currWorld.NavigationComputeZ(position, -500.f, 500.f, position.Z) )		
            {
                thePlayer.AddTimer( 'DebugWaitForNavigableTerrain', 0.25f, true );
            }
        }
        else if (goToOther)
        {
            theGame.ScheduleWorldChangeToPosition( destWorldPath, position, rotation );
            thePlayer.AddTimer( 'DebugWaitForNavigableTerrain', 0.25f, true, , , true );
        }
    }

    function disableEquipment()
    {
        hideSaddle = true;
        hideReins = true;
        hideHarness = true;
        hideBags = true;
        hideBlinders = true;
        hideHorseHair = true;
        hideTail = true;
        hideTrophy = true;
    }

    function hideSaddle()
    {
        hideSaddle = true;
    }
    function hideReins()
    {
        hideReins = true;
    }
    function hideHarness()
    {
        hideHarness = true;
    }
    function hideBags()
    {
        hideBags = true;
    }
    function hideBlinders()
    {
        hideBlinders = true;
    }
    function hideHorseHair()
    {
        hideHorseHair = true;
    }    
    function hideTail()
    {
        hideTail = true;
    }   
    function hideTrophy()
    {
        hideTrophy = true;
    }    
 
    function changeHorse(enabled : bool, optional customType : name) : bool
    {
		var horse : CNewNPC;
		var defaultType : name;

		horse = thePlayer.GetHorseWithInventory();

		if( !horse )
        {
            return false;
        }
				
		if( FactsQuerySum( "q110_geralt_refused_pay" ) > 0 )
        {
            defaultType = 'player_horse_after_q110';
        }
        else{
            defaultType = 'player_horse';
        }

		if ( enabled )
        {
            horse.ApplyAppearance(customType);
        }
        else
        {
            horse.ApplyAppearance(defaultType);
        }
		
		return true;
	}

    function refreshHorse()
    {
        var i : int;

        if(saddleEnabled)
        {
            horseGear(true, saddlePrevTemp, saddlePrevTemp);
        }
        if(blindersEnabled)
        {
            horseGear(true, blindersPrevTemp, blindersPrevTemp);
        }
        if(horseHairEnabled)
        {
            horseGear(true, horseHairPrevTemp, horseHairPrevTemp);
        }
        if(tailsEnabled)
        {
            horseGear(true, tailsPrevTemp, tailsPrevTemp);
        }
        if(bagsEnabled)
        {
            horseGear(true, bagsPrevTemp, bagsPrevTemp);
        }
        if(trophiesEnabled)
        {
            horseGear(true, trophiesPrevTemp, trophiesPrevTemp);
        }
        if(reinsEnabled)
        {
            horseGear(true, reinsPrevTemp, reinsPrevTemp);
        }
        if(harnessEnabled)
        {
            horseGear(true, harnessPrevTemp, harnessPrevTemp);
        }
        if(horseAccessoriesEnabled)
        {
            for(i = 0; i < prevTempHorseAccessories.Size(); i+=1)
            {
                horseGear(true, prevTempHorseAccessories[i], prevTempHorseAccessories[i]);
            }
        }
    }

    function horseGear(enabled : bool, template : CEntityTemplate, prevTemp : CEntityTemplate) : CEntityTemplate
    {
		var horse : CNewNPC;
		var l_actor : CActor;
		var l_comp : CComponent;
		
		horse = thePlayer.GetHorseWithInventory();
		l_actor = horse;
		l_comp = l_actor.GetComponentByClassName( 'CAppearanceComponent' );

		((CAppearanceComponent)l_comp).ExcludeAppearanceTemplate(prevTemp);

		if(enabled)
        {
			((CAppearanceComponent)l_comp).IncludeAppearanceTemplate(template);
		}
		
		return template;
	}

    function disableSaddle()
    {
        saddleEnabled = false;
        hideSaddle = false;
        ApplySaddle("");
        hideHorseEquipment();
    }

    function enableSaddle()
    {
        saddleEnabled = true;
    }

	function ApplySaddle(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(saddleEnabled)
        {
            saddlePrevTemp = horseGear(true, temp, saddlePrevTemp);
            hideSaddle = true;
        }
        else
        {
            horseGear(false, temp, saddlePrevTemp);
        }
	}

    function disableBlinders()
    {
        blindersEnabled = false;
        hideBlinders = false;
        ApplyBlinders("");
        hideHorseEquipment();
    }

    function enableBlinders()
    {
        blindersEnabled = true;
    }

	function ApplyBlinders(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(blindersEnabled)
        {
            blindersPrevTemp = horseGear(true, temp, blindersPrevTemp);
            hideBlinders = true;
        }
        else
        {
            horseGear(false, temp, blindersPrevTemp);
        }
	}

    function disableHorseHair()
    {
        horseHairEnabled = false;
        hideHorseHair = false;
        ApplyHorseHair("");
        hideHorseEquipment();
    }

    function enableHorseHair()
    {
        horseHairEnabled = true;
    }

	function ApplyHorseHair(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(horseHairEnabled)
        {
            horseHairPrevTemp = horseGear(true, temp, horseHairPrevTemp);
            hideHorseHair = true;
        }
        else
        {
            horseGear(false, temp, horseHairPrevTemp);
        }
	}


    function disableTails()
    {
        tailsEnabled = false;
        hideTail = false;
        ApplyTails("");
        hideHorseEquipment();
    }

    function enableTails()
    {
        tailsEnabled = true;
    }

	function ApplyTails(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(tailsEnabled)
        {
            tailsPrevTemp = horseGear(true, temp, tailsPrevTemp);
            hideTail = true;
        }
        else
        {
            horseGear(false, temp, tailsPrevTemp);
        }
	}

    function disableBags()
    {
        bagsEnabled = false;
        hideBags = false;
        ApplyBags("");
        hideHorseEquipment();
    }

    function enableBags()
    {
        bagsEnabled = true;
    }

	function ApplyBags(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(bagsEnabled)
        {
            bagsPrevTemp = horseGear(true, temp, bagsPrevTemp);
            hideBags = true;
        }
        else
        {
            horseGear(false, temp, bagsPrevTemp);
        }
	}

    function disableTrophies()
    {
        trophiesEnabled = false;
        hideTrophy = false;
        ApplyTrophies("");
        hideHorseEquipment();
    }

    function enableTrophies()
    {
        trophiesEnabled = true;
    }

	function ApplyTrophies(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(trophiesEnabled)
        {
            trophiesPrevTemp = horseGear(true, temp, trophiesPrevTemp);
            hideTrophy = true;
        }
        else
        {
            horseGear(false, temp, trophiesPrevTemp);
        }
	}

    function disableReins()
    {
        reinsEnabled = false;
        hideReins = false;
        ApplyReins("");
        hideHorseEquipment();
    }

    function enableReins()
    {
        reinsEnabled = true;
    }

	function ApplyReins(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(reinsEnabled)
        {
            reinsPrevTemp = horseGear(true, temp, reinsPrevTemp);
            hideReins = true;
        }
        else
        {
            horseGear(false, temp, reinsPrevTemp);
        }
	}

    function disableHarness()
    {
        harnessEnabled = false;
        hideHarness = false;
        ApplyHarness("");
        hideHorseEquipment();
    }

    function enableHarness()
    {
        harnessEnabled = true;
    }

	function ApplyHarness(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);

        if(harnessEnabled)
        {
            harnessPrevTemp = horseGear(true, temp, harnessPrevTemp);
            hideHarness = true;
        }
        else
        {
            horseGear(false, temp, harnessPrevTemp);
        }
	}

    function disableHorseAccessories()
    {
        var i : int;
        i = 0;
        horseAccessoriesEnabled = false;

        for(i = 0; i < prevTempHorseAccessories.Size(); i+=1)
        {
            horseGear(false, prevTempHorseAccessories[i], prevTempHorseAccessories[i]);
        }

        hideHorseEquipment();
    }

    function enableHorseAccessories()
    {
        horseAccessoriesEnabled = true;
    }

	function ApplyHorseAccessories(template : string)
    {
		var temp : CEntityTemplate;

		temp = CreateTemplate(template);
        
        if(horseAccessoriesEnabled)
        {
            prevTempHorseAccessories.PushBack(temp);
            horseAccessoriesPrevTemp = horseGear(true, temp, temp);
        }
        else
        {
            horseGear(false, temp, horseAccessoriesPrevTemp);
        }
	}

    function horseDemonFX(enabled : bool)
    {
		var horse : CNewNPC;
		
		horse = thePlayer.GetHorseWithInventory();
		
		if (enabled)
        {
            horse.PlayEffectSingle('demon_horse');
        }
        else
        {
            horse.StopEffect('demon_horse');
        }
		
	}
		
	function horseIceFX(enabled : bool)
    {
		var horse : CNewNPC;
		
		horse = thePlayer.GetHorseWithInventory();
		
		if (enabled)
        {
			horse.PlayEffectSingle('ice_armor_cutscene');
				
		}
		else
        {
			horse.StopEffect('ice_armor_cutscene');
		}
	}

    function playerIceFX(enabled : bool)
    {		
		if (enabled)
        {
			thePlayer.PlayEffectSingle('ice_armor_cutscene');
		}
		else
        {
			thePlayer.StopEffect('ice_armor_cutscene');
		}
	}
	
	function horseFireFX(enabled : bool)
    {
		var horse : CNewNPC;
		
		horse = thePlayer.GetHorseWithInventory();
		
		if (enabled)
        {
            horse.PlayEffectSingle('fire_hooves_right_front');
            horse.PlayEffectSingle('fire_hooves_left_front');
            horse.PlayEffectSingle('fire_hooves_right_back');
            horse.PlayEffectSingle('fire_hooves_left_back');
				
		}
		else
		{
            horse.StopEffect('fire_hooves_right_front');
            horse.StopEffect('fire_hooves_left_front');
            horse.StopEffect('fire_hooves_right_back');
            horse.StopEffect('fire_hooves_left_back');			
		}
	}

    function tpHorse() 
    {
        var theHorse : CNewNPC;
        var horsePosition, player, playerDirection: Vector;
        var vehicle : CVehicleComponent;
        
        theHorse = thePlayer.GetHorseWithInventory();
        if(!theHorse ||	!theHorse.IsAlive()) {
            GetWitcherPlayer().DisplayHudMessage("Unsafe spawn location!");
            return;
        }
        
        player = thePlayer.GetWorldPosition();
        playerDirection = thePlayer.GetHeadingVector();
        playerDirection = VecRotByAngleXY(playerDirection, 90);
        playerDirection.X *= 2;	
        playerDirection.Y *= 2;
        horsePosition = playerDirection + player;
        horsePosition.Z = player.Z;
        theHorse.TeleportWithRotation(horsePosition, thePlayer.GetWorldRotation());

        if(theGame.getWolvenTrainer().getInstantMount())
        {
            vehicle = (CVehicleComponent)(theHorse.GetHorseComponent());
            if(vehicle) 
            {
                vehicle.Mount(thePlayer, VMT_ImmediateUse, EVS_driver_slot);
            }
        }
    }

    function tpToHorse() 
    {
        var theHorse : CNewNPC;
        var playerPosition, horsePos, horseDirection: Vector;
        var vehicle : CVehicleComponent;
        
        theHorse = thePlayer.GetHorseWithInventory();
        if(!theHorse ||	!theHorse.IsAlive()) {
            GetWitcherPlayer().DisplayHudMessage("Unsafe teleport location!");
            return;
        }
        
        horsePos = theHorse.GetWorldPosition();
        horseDirection = theHorse.GetHeadingVector();
        horseDirection = VecRotByAngleXY(horseDirection, 90);
        horseDirection.X *= 2;	
        horseDirection.Y *= 2;
        playerPosition = horseDirection + horsePos;
        playerPosition.Z = horsePos.Z;
        thePlayer.TeleportWithRotation(playerPosition, theHorse.GetWorldRotation());

        if(theGame.getWolvenTrainer().getInstantMount())
        {
            vehicle = (CVehicleComponent)(theHorse.GetHorseComponent());
            if(vehicle) 
            {
                vehicle.Mount(thePlayer, VMT_ImmediateUse, EVS_driver_slot);
            }
        }
    }
    function setHorseSpeed(value : float)
    {
        var theHorse : CNewNPC;
        theHorse = thePlayer.GetHorseWithInventory();

        if(!theHorse ||	!theHorse.IsAlive()) {
            return;
        }
        
        if(value == 1)
        {
            theHorse.ResetAnimationSpeedMultiplier(horseAnimationSpeedCauserID);
        }
        else
        {
            horseAnimationSpeedCauserID = theHorse.SetAnimationSpeedMultiplier( value, horseAnimationSpeedCauserID);
        }

        horseSpeed = value;
    }

    private var steelIgniFXranOnce : bool;
    private var steelAardFXranOnce : bool;
    private var steelQuenFXranOnce : bool;
    private var steelYrdenFXranOnce : bool;
    private var steelAxiiFXranOnce : bool;
    private var steelRuneGlowRanOnce : bool;

    private var silverIgniFXranOnce : bool;
    private var silverAardFXranOnce : bool;
    private var silverQuenFXranOnce : bool;
    private var silverYrdenFXranOnce : bool;
    private var silverAxiiFXranOnce : bool;
    private var silverRuneGlowRanOnce : bool;

    function applySteelFX(itemId : SItemUniqueId, ent : CEntity)
    {
        var inv : CInventoryComponent;
        inv = thePlayer.GetInventory();	

        if(steelIgniFX && !steelIgniFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_igni');
            steelIgniFXranOnce = true;
        }
        else if(!steelIgniFX)
        {
            inv.StopItemEffect(itemId,'runeword_igni');
            steelIgniFXranOnce = false;
        }

        if(steelAardFX && !steelAardFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_aard');
            steelAardFXranOnce = true;
        }
        else if(!steelAardFX)
        {
            inv.StopItemEffect(itemId,'runeword_aard');
            steelAardFXranOnce = false;
        }

        if(steelQuenFX && !steelQuenFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_quen');
            steelQuenFXranOnce = true;
        }
        else if(!steelQuenFX)
        {
            inv.StopItemEffect(itemId,'runeword_quen');
            steelQuenFXranOnce = false;
        }

        if(steelYrdenFX && !steelYrdenFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_yrden');
            steelYrdenFXranOnce = true;
        }
        else if(!steelYrdenFX)
        {
            inv.StopItemEffect(itemId,'runeword_yrden');
            steelYrdenFXranOnce = false;
        }

        if(steelAxiiFX && !steelAxiiFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_axii');
            steelAxiiFXranOnce = true;
        }
        else if(!steelAxiiFX)
        {
            inv.StopItemEffect(itemId,'runeword_axii');
            steelAxiiFXranOnce = false;
        }

        if(steelRuneLvl != 'none')
        {
            inv.PlayItemEffect(itemId, steelRuneLvl);
            ent.PlayEffectSingle(steelRuneLvl);
        }

        if(steelRuneType != 'none')
        {
            inv.PlayItemEffect(itemId, steelRuneType);
            ent.PlayEffectSingle(steelRuneType);
        }

        if(steelOilType != 'none')
        {
            inv.PlayItemEffect(itemId, steelOilType);
            ent.PlayEffectSingle(steelOilType);
        }

        if(steelRuneGlow && !steelRuneGlowRanOnce)
        {
            inv.PlayItemEffect(itemId,'rune_blast_loop'); 
            ent.PlayEffectSingle('rune_blast_loop');
            steelRuneGlowRanOnce = true;
        }
        else if(!steelRuneGlow)
        {
            inv.StopItemEffect(itemId, 'rune_blast_loop');
            steelRuneGlowRanOnce = false;
        }
        
    }

    function applySilverFX(itemId : SItemUniqueId, ent : CEntity)
    {
        var inv : CInventoryComponent;
        inv = thePlayer.GetInventory();	

        if(silverIgniFX && !silverIgniFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_igni');
            silverIgniFXranOnce = true;
        }
        else if(!silverIgniFX)
        {
            inv.StopItemEffect(itemId,'runeword_igni');
            silverIgniFXranOnce = false;
        }

        if(silverAardFX && !silverAardFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_aard');
            silverAardFXranOnce = true;
        }
        else if(!silverAardFX)
        {
            inv.StopItemEffect(itemId,'runeword_aard');
            silverAardFXranOnce = false;
        }

        if(silverQuenFX && !silverQuenFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_quen');
            silverQuenFXranOnce = true;
        }
        else if(!silverQuenFX)
        {
            inv.StopItemEffect(itemId,'runeword_quen');
            silverQuenFXranOnce = false;
        }

        if(silverYrdenFX && !silverYrdenFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_yrden');
            silverYrdenFXranOnce = true;
        }
        else if(!silverYrdenFX)
        {
            inv.StopItemEffect(itemId,'runeword_yrden');
            silverYrdenFXranOnce = false;
        }

        if(silverAxiiFX && !silverAxiiFXranOnce)
        {
            inv.PlayItemEffect(itemId,'runeword_axii');
            silverAxiiFXranOnce = true;
        }
        else if(!silverAxiiFX)
        {
            inv.StopItemEffect(itemId,'runeword_axii');
            silverAxiiFXranOnce = false;
        }

        if(silverRuneLvl != 'none')
        {
            inv.PlayItemEffect(itemId, silverRuneLvl);
            ent.PlayEffectSingle(silverRuneLvl);
        }

        if(silverRuneType != 'none')
        {
            inv.PlayItemEffect(itemId, silverRuneType);
            ent.PlayEffectSingle(silverRuneType);
        }

        if(silverOilType != 'none')
        {
            inv.PlayItemEffect(itemId, silverOilType);
            ent.PlayEffectSingle(silverOilType);
        }

        if(silverRuneGlow && !silverRuneGlowRanOnce)
        {
            inv.PlayItemEffect(itemId,'rune_blast_loop'); 
            ent.PlayEffectSingle('rune_blast_loop');
            silverRuneGlowRanOnce = true;
        }
        else if(!silverRuneGlow)
        {
            inv.StopItemEffect(itemId, 'rune_blast_loop');
            silverRuneGlowRanOnce = false;
        }
        
    }

    function ApplySwordFX() : bool
    {
        var itemId : SItemUniqueId;
        var inv : CInventoryComponent;
        var ent : CEntity;
        var item : SItemUniqueId;
            
        inv = thePlayer.GetInventory();		
        itemId = inv.GetItemFromSlot('r_weapon');
        
        if ( !inv.IsIdValid(itemId) )
        {
            itemId = inv.GetItemFromSlot('l_weapon');
            
            if ( !inv.IsIdValid(itemId) ){
                return false;
            }
        }

        if(thePlayer.IsWeaponHeld('silversword'))
        {
            if(svSwordEnabled)
            {
                ent = svSwordCurEnt;
            }
            else
            {
                GetWitcherPlayer().GetItemEquippedOnSlot(EES_SilverSword, item);
                ent = inv.GetItemEntityUnsafe(item);
            }

            applySilverFX(itemId, ent);
        }
        else if(thePlayer.IsWeaponHeld('steelsword'))
        {
            if(stSwordEnabled)
            {
                ent = stSwordCurEnt;
            }
            else
            {
                GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, item);
                ent = inv.GetItemEntityUnsafe(item);
            }

            applySteelFX(itemId, ent);
        }	
        
        return true;
    }

    function StopSwordFX() : bool
    {
        var itemId : SItemUniqueId;
        var inv : CInventoryComponent;
        var ent : CEntity;
        var item : SItemUniqueId;
            
        inv = thePlayer.GetInventory();		
        itemId = inv.GetItemFromSlot('r_weapon');

        stopAllFXRanOnce();
        
        if ( !inv.IsIdValid(itemId) )
        {
            itemId = inv.GetItemFromSlot('l_weapon');
            
            if ( !inv.IsIdValid(itemId) ){
                return false;
            }
        }

        if(thePlayer.IsWeaponHeld('silversword'))
        {
            if(svSwordEnabled)
            {
                ent = svSwordCurEnt;
            }
            else
            {
                GetWitcherPlayer().GetItemEquippedOnSlot(EES_SilverSword, item);
                ent = inv.GetItemEntityUnsafe(item);
            }

            ent.StopAllEffects();
        }
        else if(thePlayer.IsWeaponHeld('steelsword'))
        {
            if(stSwordEnabled)
            {
                ent = stSwordCurEnt;
            }
            else
            {
                GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, item);
                ent = inv.GetItemEntityUnsafe(item);
            }

            ent.StopAllEffects();
        }	

        return true;
    }


    function setGodMode(value : bool)
    {
        godMode = value;
    }
    function setGhostmode(value : bool)
    {
        ghostMode = value;
    }
    function setEnemiesIgnore(value : bool)
    {
        enemiesIgnore = value;
    }
    function setPlayerSpeed(value : float)
    {
        playerSpeed = value;
    }
    function setSuperJump(value : bool)
    {
        superJump = value;
    }
    function setUltraJump(value : bool)
    {
        ultraJump = value;
    }
    function setFlyMode(value : bool)
    {
        flyMode = value;
    }
    function setCollision(value : bool)
    {
        collision = value;
    }
    function setForcefield(value : bool)
    {
        forcefield = value;
    }
    function setFallDamage(value : bool)
    {
        fallDamage = value;
    }
    function setWeightLimit(value : bool)
    {
        weightLimit = value;
    }
    function setNoToxicity(value : bool)
    {
        noToxicity = value;
    }
    function setNoCrafting(value : bool)
    {
        noCrafting = value;
    }
    function setNoStagger(value : bool)
    {
        noStagger = value;
    }
    function setInfiniteBreath(value : bool)
    {
        infiniteBreath = value;
    }
    function setNightVision(value : bool)
    {
        nightVision = value;
    }
    function setLastAction(value : int)
    {
        lastAction = value;
    }
    function setHorseDemonFX(value : bool)
    {
        horseDemonFX = value;
    }
    function setHorseIceFX(value : bool)
    {
        horseIceFX = value;
    }
    function setPlayerIceFX(value : bool)
    {
        playerIceFX = value;
    }
    function setHorseFireFX(value : bool)
    {
        horseFireFX = value;
    }
    function setInstantMount(value : bool)
    {
        instantMount = value;
    }
    function setHorseFlyMode(value : bool)
    {
        horseFlyMode = value;
    }
    function setHorseInvis(value : bool)
    {
        horseInvis = value;
    }
    function setBoatSpeed(value : float)
    {
        boatSpeed = value;
    }
    function setCustomBoatSpeed(value : bool)
    {
        customBoatSpeed = value;
    }
    function setInfiniteHorseStamina(value : bool)
    {
        infiniteHorseStamina = value;
    }
    function setNoHorsePanic(value : bool)
    {
        noHorsePanic = value;
    }
    function setInfiniteSignStamina(value : bool)
    {
        infiniteSignStamina = value;
    }
    function setInfiniteAdrenaline(value : bool)
    {
        infiniteAdrenaline = value;
    }
    function setAutoHeal(value : bool)
    {
        autoHeal = value;
    }
    function setInvis(value : bool)
    {
        invis = value;
    }
    function setPaused(value : bool)
    {
        paused = value;
    }
    function setLastActiveContext(value : name)
    {
        lastActiveContext = value;
    }
    function setGallopInCities(value : bool)
    {
        noHorseRestrictions = value;
    }
    function setNoLevelRequirements(value : bool)
    {
        noLevelRequirements = value;
    }
    function setNoDurability(value : bool)
    {
        noDurability = value;
    }
    function setBloodbath(value : bool)
    {
        bloodbath = value;
    }
    function setUnlimitedConsumables(value : bool)
    {
        unlimitedConsumables = value;
    }
    function setStealing(value : bool)
    {
        stealing = value;
    }
    function setFT(value : bool)
    {
        ft = value;
    }
    function setDamageMultiplier(value : bool)
    {
        damageMultiplier = value;
    }
    function setDamageOverall(value : float)
    {
        damageOverall = value;
    }
    function setDamageBomb(value : float)
    {
        damageBombs = value;
    }
    function setDamageCrossbow(value : float)
    {
        damageCrossbow = value;
    }
    function setDamageFists(value : float)
    {
        damageFist = value;
    }
    function setDamageSign(value : float)
    {
        damageSign = value;
    }
    function setDamageSwords(value : float)
    {
        damageSwords = value;
    }
    function setIncomingDamageOverall(value : float)
    {
        incomingDamageOverall = value;
    }
    function setDamageOT(value : float)
    {
        damageOT = value;
    }
    function setSteelIgniFX(value : bool)
    {
        steelIgniFX = value;
    }
    function setSteelAardFX(value : bool)
    {
        steelAardFX = value;
    }
    function setSteelQuenFX(value : bool)
    {
        steelQuenFX = value;
    }
    function setSteelYrdenFX(value : bool)
    {
        steelYrdenFX = value;
    }
    function setSteelAxiiFX(value : bool)
    {
        steelAxiiFX = value;
    }
    function setUnsinkable(value : bool)
    {
        unsinkable = value;
    }
    function setSteelRuneLvl(value : name)
    {
        steelRuneLvl = value;
    }
    function setSteelRuneType(value : name)
    {
        steelRuneType = value;
    }
    function setSteelOilType(value : name)
    {
        steelOilType = value;
    }
    function setSteelRuneGlow(value : bool)
    {
        steelRuneGlow = value;
    }
    function setSilverIgniFX(value : bool)
    {
        silverIgniFX = value;
    }
    function setSilverAardFX(value : bool)
    {
        silverAardFX = value;
    }
    function setSilverQuenFX(value : bool)
    {
        silverQuenFX = value;
    }
    function setSilverYrdenFX(value : bool)
    {
        silverYrdenFX = value;
    }
    function setSilverAxiiFX(value : bool)
    {
        silverAxiiFX = value;
    }
    function setSilverRuneLvl(value : name)
    {
        silverRuneLvl = value;
    }
    function setSilverRuneType(value : name)
    {
        silverRuneType = value;
    }
    function setSilverOilType(value : name)
    {
        silverOilType = value;
    }
    function setSilverRuneGlow(value : bool)
    {
        silverRuneGlow = value;
    }
    function setHideCrossbow(value : bool)
    {
        hideCrossbow = value;
    }
    function setAutoTeleportToWaypoint(value : bool)
    {
        autoTeleportToWaypoint = value;
    }
    function setAppearancePath(value : string)
    {
        appearancePath = value;
    }
    function setFreezeTime(value : bool)
    {
        freezeTime = value;
    }
    function setStoredHoursPerMinute(value : float)
    {
        storedHoursPerMinute = value;
    }
    function setNoBorders(value : bool)
    {
        noBorders = value;
    }
    function setOilsNeverExpire(value : bool)
    {
        oilsNeverExpire = value;
    }
    function setNoCrossbowReload(value : bool)
    {
        noCrossbowReload = value;
    }
    function setFreecamSpeed(value : float)
    {
        freecamSpeed = value;
    }
    function setFreecamFOV(value : float)
    {
        freecamFOV = value;
    }
    function setFreecamRoll(value : float)
    {
        freecamRoll = value;
    }
    function getPlayerSpeed() : float
    {
        return playerSpeed;
    }
    function getStoredHoursPerMinute() : float
    {
        return storedHoursPerMinute;
    }
    function getHorseSpeed() : float
    {
        return horseSpeed;
    }
    function getGodMode() : bool
    {
        return godMode;
    }
    function getSpeedHorseState() : bool
    {
        return customHorseSpeed;
    }
    function getEnemiesIgnore() : bool
    {
        return enemiesIgnore;
    }
    function getUnsinkable() : bool
    {
        return unsinkable;
    }
    function getSuperJump() : bool
    {
        return superJump;
    }
    function getUltraJump() : bool
    {
        return ultraJump;
    }
    function getFlyMode() : bool
    {
        return flyMode;
    }
    function getCollision() : bool
    {
        return collision;
    }
    function getForcefield() : bool
    {
        return forcefield;
    }
    function getFallDamage() : bool
    {
        return fallDamage;
    }
    function getWeightLimit() : bool
    {
        return weightLimit;
    }
    function getNoToxicity() : bool
    {
        return noToxicity;
    }
    function getNoCrafting() : bool
    {
        return noCrafting;
    }
    function getInfiniteBreath() : bool
    {
        return infiniteBreath;
    }
    function getLastAction() : int
    {
        return lastAction;
    }
    function getHorseDemonFX() : bool
    {
        return horseDemonFX;
    }
    function getNoBorders() : bool
    {
        return noBorders;
    }
    function getHorseIceFX() : bool
    {
        return horseIceFX;
    }
    function getPlayerIceFX() : bool
    {
        return playerIceFX;
    }
    function getHorseFireFX() : bool
    {
        return horseFireFX;
    }
    function getNoCrossbowReload() : bool
    {
        return noCrossbowReload;
    }
    function getBoatSpeed() : float
    {
        return boatSpeed;
    }
    function getCustomBoatSpeed() : bool
    {
        return customBoatSpeed;
    }
    function getInstantMount() : bool
    {
        return instantMount;
    }
    function getHorseFlyMode() : bool
    {
        return horseFlyMode;
    }
    function getHorseInvis() : bool
    {
        return horseInvis;
    }
    function getInfiniteHorseStamina() : bool
    {
        return infiniteHorseStamina;
    }
    function getNoHorsePanic() : bool
    {
        return noHorsePanic;
    }
    function getInfiniteSignStamina() : bool
    {
        return infiniteSignStamina;
    }
    function getInfiniteAdrenaline() : bool
    {
        return infiniteAdrenaline;
    }
    function getAutoHeal() : bool
    {
        return autoHeal;
    }
    function getPaused() : bool
    {
        return paused;
    }
    function getLastActiveContext() : name
    {
        return lastActiveContext;
    }
    function getGallopInCities() : bool
    {
        return noHorseRestrictions;
    }
    function getNightVision() : bool
    {
        return nightVision;
    }
    function getGhostMode() : bool
    {
        return ghostMode;
    }
    function getNoLevelRequirements() : bool
    {
        return noLevelRequirements;
    }
    function getNoDurability() : bool
    {
        return noDurability;
    }
    function getNoStagger() : bool
    {
        return noStagger;
    }
    function getBloodbath() : bool
    {
        return bloodbath;
    }
    function getUnlimitedConsumables() : bool
    {
        return unlimitedConsumables;
    }
    function getStealing() : bool
    {
        return stealing;
    }
    function getFT() : bool
    {
        return ft;
    }
    function getDamageMultiplier() : bool
    {
        return damageMultiplier;
    }
    function getDamageSign() : float
    {
        return damageSign;
    }
    function getDamageCrossbow() : float
    {
        return damageCrossbow;
    }
    function getDamageFist() : float
    {
        return damageFist;
    }
    function getDamageSwords() : float
    {
        return damageSwords;
    }
    function getFreecamSpeed() : float
    {
        return freecamSpeed;
    }
    function getFreecamFOV() : float
    {
        return freecamFOV;
    }
    function getFreecamRoll() : float
    {
        return freecamRoll;
    }
    function getDamageBombs() : float
    {
        return damageBombs;
    }
    function getDamageOverall() : float
    {
        return damageOverall;
    }
    function getIncomingDamageOverall() : float
    {
        return incomingDamageOverall;
    }
    function getDamageOT() : float
    {
        return damageOT;
    }
    function getSteelIgniFX() : bool
    {
        return steelIgniFX;
    }
    function getOilsNeverExpire() : bool
    {
        return oilsNeverExpire;
    }
    function getSteelAardFX() : bool
    {
        return steelAardFX;
    }
    function getSteelQuenFX() : bool
    {
        return steelQuenFX;
    }
    function getSteelYrdenFX() : bool
    {
        return steelYrdenFX;
    }
    function getSteelAxiiFX() : bool
    {
        return steelAxiiFX;
    }
    function getSteelRuneGlow() : bool
    {
        return steelRuneGlow;
    }
    function getSilverIgniFX() : bool
    {
        return silverIgniFX;
    }
    function getSilverAardFX() : bool
    {
        return silverAardFX;
    }
    function getSilverQuenFX() : bool
    {
        return silverQuenFX;
    }
    function getSilverYrdenFX() : bool
    {
        return silverYrdenFX;
    }
    function getSilverAxiiFX() : bool
    {
        return silverAxiiFX;
    }
    function getSilverRuneGlow() : bool
    {
        return silverRuneGlow;
    }
    function getHideCrossbow() : bool
    {
        return hideCrossbow;
    }
    function getAutoTeleportToWaypoint() : bool
    {
        return autoTeleportToWaypoint;
    }
    function getAppearancePath() : string
    {
        return appearancePath;
    }
    function getFreezeTime() : bool
    {
        return freezeTime;
    }
    function getInvis() : bool
    {
        return invis;
    }

    function Jump_Extend_Init( type : EJumpType )
    {
        var vJumpExtend : cJumpExtend;
        vJumpExtend = new cJumpExtend in theGame;
        
        if ( 
        !thePlayer.IsCiri() 
        && GetWitcherPlayer().IsAlive()
        && !GetWitcherPlayer().IsInAir()
        && GetWitcherPlayer().IsOnGround()
        && (type == EJT_Idle 
        || type == EJT_IdleToWalk 
        || type == EJT_Walk 
        || type == EJT_WalkHigh 
        || type == EJT_Run 
        || type == EJT_Sprint 
        || type == EJT_Slide
        )
        )
        {	
            vJumpExtend.JumpExtend();
        }
    }

    function UpdateJumpCamera( out moveData : SCameraMovementData, dt : float ) : bool
    {
        var camera								: CCustomCamera;
        var cameraPreset						: SCustomCameraPreset;
        
        camera = (CCustomCamera)theCamera.GetTopmostCameraObject();
        cameraPreset = camera.GetActivePreset();

        camera.ChangePivotDistanceController( 'Default' );
        camera.ChangePivotPositionController( 'Default' );
        
        moveData.pivotDistanceController = camera.GetActivePivotDistanceController();
        moveData.pivotPositionController = camera.GetActivePivotPositionController();

        moveData.pivotDistanceController.SetDesiredDistance(cameraPreset.distance + 1.0f);
        moveData.pivotPositionController.SetDesiredPosition(GetWitcherPlayer().GetWorldPosition());

        if(theGame.getWolvenTrainer().getFlyMode())
        {
            moveData.pivotPositionController.offsetZ = 2.25f;
        }
        else
        {
            moveData.pivotPositionController.offsetZ = -0.25f;
        }
        

        return true;
    }

    function disableHeadInternal()
    {
        theGame.getWolvenTrainer().disableHead();
    }

    function disableMaskInternal()
    {
        theGame.getWolvenTrainer().disableMask();
    }

    function disableCapeInternal()
    {
        theGame.getWolvenTrainer().disableCape();
    }

    function disableFullBodyInternal()
    {
        theGame.getWolvenTrainer().disableFullBody();
    }

    function disableShoulderInternal()
    {
        theGame.getWolvenTrainer().disableShoulder();
    }

    function disableAccessoriesInternal()
    {
        theGame.getWolvenTrainer().disableAccessories();
    }

    function disableChestInternal()
    {
        theGame.getWolvenTrainer().disableChest();
        theGame.getWolvenTrainer().ChestAppearance(true);
    }

    function disableLeggingsInternal()
    {
        theGame.getWolvenTrainer().disableLeggings();
        theGame.getWolvenTrainer().LeggingsAppearance(true);
    }

    function disableGlovesInternal()
    {
        theGame.getWolvenTrainer().disableGloves();
        theGame.getWolvenTrainer().GlovesAppearance(true);
    }

    function disableBootsInternal()
    {
        theGame.getWolvenTrainer().disableBoots();
        theGame.getWolvenTrainer().BootsAppearance(true);
    }

    function resetHead()
    {
        var acs : array< CComponent >;

        acs = thePlayer.GetComponentsByClassName( 'CHeadManagerComponent' );
        thePlayer.ClearRememberedCustomHead();
        ( ( CHeadManagerComponent ) acs[0] ).RemoveCustomHead();
    }

    function disableSteelSwordsInternal()
    {
        theGame.getWolvenTrainer().disableSteelSwords();
    }

    function disableSilverSwordsInternal()
    {
        theGame.getWolvenTrainer().disableSilverSwords();
    }

    function disableSteelScabbardInternal()
    {
        theGame.getWolvenTrainer().disableSteelScabbard();
        theGame.getWolvenTrainer().hideSteelScabbard(false);
    }

    function disableSilverScabbardInternal()
    {
        theGame.getWolvenTrainer().disableSilverScabbard();
        theGame.getWolvenTrainer().hideSilverScabbard(false);
        
    }

    function restoreOutfitInternal()
    {
        disableHeadInternal();
        disableMaskInternal();
        disableCapeInternal();
        disableFullBodyInternal();
        disableShoulderInternal();
        disableAccessoriesInternal();
        disableChestInternal();
        disableLeggingsInternal();
        disableGlovesInternal();
        disableBootsInternal();
        disableSteelSwordsInternal();
        disableSilverSwordsInternal();
        disableSteelScabbardInternal();
        disableSilverScabbardInternal();
        resetHead();
        theGame.getWolvenTrainer().disableNoHairTuck();
    }

    function disableHorseModelInternal()
    {
        theGame.getWolvenTrainer().changeHorse(false);
        theGame.getWolvenTrainer().refreshHorse();
    }

    function disableSaddleInternal()
    {
        theGame.getWolvenTrainer().disableSaddle();
    }

    function disableBlindersInternal()
    {
        theGame.getWolvenTrainer().disableBlinders();
    }

    function disableHorseHairInternal()
    {
        theGame.getWolvenTrainer().disableHorseHair();
    }

    function disableTailsInternal()
    {
        theGame.getWolvenTrainer().disableTails();
    }

    function disableBagsInternal()
    {
        theGame.getWolvenTrainer().disableBags();
    }
    
    function disableTrophiesInternal()
    {
        theGame.getWolvenTrainer().disableTrophies();
    }

    function disableReinsInternal()
    {
        theGame.getWolvenTrainer().disableReins();
    }

    function disableHarnessInternal()
    {
        theGame.getWolvenTrainer().disableHarness();
    }

    function disableHorseAccessoriesInternal()
    {
        theGame.getWolvenTrainer().disableHorseAccessories();
    }

    function restoreHorseInternal()
    {
        theGame.getWolvenTrainer().changeHorse(false);
        theGame.getWolvenTrainer().refreshHorse();
        disableSaddleInternal();
        disableBlindersInternal();
        disableHorseHairInternal();
        disableTailsInternal();
        disableBagsInternal();
        disableTrophiesInternal();
        disableReinsInternal();
        disableHarnessInternal();
        disableHorseAccessoriesInternal();
    }

    function summonRoach()
    {
        var createEntityHelper : CR4CreateEntityHelper;
        createEntityHelper = new CR4CreateEntityHelper in theGame;
        createEntityHelper.SetPostAttachedCallback( theGame, 'OnPlayerHorseSummoned' );
        theGame.SummonPlayerHorse( true, createEntityHelper ); 
        thePlayer.OnSpawnHorse();
    }

    function refillHorseStamina()
    {
        var theHorse : CNewNPC;

        theHorse = thePlayer.GetHorseWithInventory();

        if(!theHorse || !theHorse.IsAlive())
        {
            return;
        }

        theHorse.abilityManager.SetStatPointCurrent(BCS_Stamina, theHorse.abilityManager.GetStatMax(BCS_Stamina));
    }

    function refillSignStamina()
    {
        thePlayer.abilityManager.SetStatPointCurrent(BCS_Stamina, thePlayer.abilityManager.GetStatMax(BCS_Stamina));
    }

    function refillInfiniteAdrenaline()
    {
        thePlayer.abilityManager.SetStatPointCurrent(BCS_Focus, thePlayer.abilityManager.GetStatMax(BCS_Focus));
    }

    function refillAutoHeal()
    {
        thePlayer.abilityManager.SetStatPointCurrent(BCS_Vitality, thePlayer.abilityManager.GetStatMax(BCS_Vitality));
    }

    function getToRepair() : array<EEquipmentSlots> 
    {
        var itemSlots: array<EEquipmentSlots>;

        itemSlots.PushBack(EES_SteelSword);
        itemSlots.PushBack(EES_SilverSword);
        itemSlots.PushBack(EES_Armor);
        itemSlots.PushBack(EES_Boots);
        itemSlots.PushBack(EES_Pants);
        itemSlots.PushBack(EES_Gloves);

        return itemSlots;
    }

    function repairEquippedItems() 
    {
        var i: int;
        var item: SItemUniqueId;
        var itemSlots: array<EEquipmentSlots>;

        itemSlots = getToRepair();
        
        for (i=0; i<itemSlots.Size(); i+=1) 
        {
            GetWitcherPlayer().GetInventory().GetItemEquippedOnSlot(itemSlots[i], item);
            
            thePlayer.inv.SetItemDurabilityScript( item, thePlayer.inv.GetItemMaxDurability( item ));
        }
    }

    function removeSkillPointsInternal(val : int)
    {
        var total : int;

        if(val < 1)
            val = 1;
            
        total = GetWitcherPlayer().levelManager.GetPointsFree(ESkillPoint);

        total = total - val;

        if(total < 0)
        {
            total = 0;
        }

        GetWitcherPlayer().levelManager.SetFreeSkillPoints(total);
    }

    function addAbility(npc	: CNewNPC, nam : name)
    {
        if(!npc.HasAbility(nam)) npc.AddAbility(nam, true); 
    }

    function wolven_addEntityInfo(text: string, entity: CEntity)
    {
        var oneliner: SU_OnelinerEntity;

        oneliner = new SU_OnelinerEntity in thePlayer;
        oneliner.text = text;
        oneliner.entity = entity;
        oneliner.visible = true;
        oneliner.tag = "WolvenTrainer";
        oneliner.register();
    }
}