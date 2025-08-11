// Wolven Trainer by rejuvenate
// https://next.nexusmods.com/profile/rejuvenate7/about-me

exec function wolven_PlaySound(sound : string)
{
   theSound.SoundEvent(sound);
}

exec function wolven_toggleGodmode()
{
    if(!theGame.getWolvenTrainer().getGodMode())
    {
		thePlayer.SetImmortalityMode( AIM_Invulnerable, AIC_Default, true );
		thePlayer.SetCanPlayHitAnim(false);
		thePlayer.AddBuffImmunity_AllNegative('god', true);
		StaminaBoyInternal(true);
		LogCheats( "God is now ON" );
        theGame.getWolvenTrainer().setGodMode(true);
	}
	else
	{
		thePlayer.SetImmortalityMode( AIM_None, AIC_Default, true );	
		thePlayer.SetCanPlayHitAnim(true);
		thePlayer.RemoveBuffImmunity_AllNegative('god');
		StaminaBoyInternal(false);
		LogCheats( "God is now OFF" );
        theGame.getWolvenTrainer().setGodMode(false);
    }
}
exec function wolven_toggleGhostmode()
{
    if(!theGame.getWolvenTrainer().getGhostMode())
    {
        thePlayer.PlayEffect( 'invisible' );
        theGame.getWolvenTrainer().setGhostmode(true);
    }
    else
    {
        thePlayer.StopEffect( 'invisible' );
        theGame.getWolvenTrainer().setGhostmode(false);
    }
}


exec function wolven_toggleEnemiesIgnore()
{
    if(!theGame.getWolvenTrainer().getEnemiesIgnore())
    {
        if(thePlayer.GetGameplayVisibility())
        {
            thePlayer.SetGameplayVisibility( false );
            thePlayer.SetTemporaryAttitudeGroup('neutral_to_player',3);
            theGame.getWolvenTrainer().setEnemiesIgnore(true);
        }
    }
    else
    {
        if(!thePlayer.GetGameplayVisibility())
        {
            thePlayer.SetGameplayVisibility( true );
            thePlayer.ResetTemporaryAttitudeGroup(3);
            theGame.getWolvenTrainer().setEnemiesIgnore(false);
        }
    }
}

exec function wolven_setPlayerSpeedValue(value : float)
{
    theGame.getWolvenTrainer().setPlayerSpeed(value);
    if(value == 1)
    {
        thePlayer.ResetAnimationSpeedMultiplier(thePlayer.playerAnimationSpeedCauserID);
    }
    else
    {
    thePlayer.wolven_setAnimationSpeedCauserID();
    }
}

statemachine class cJumpExtend 
{
    function JumpExtend()
	{
		this.PushState('JumpExtendState');
	}
}

state JumpExtendState in cJumpExtend
{
	private var dest, prev_pos				 								: Vector;
	private var ticket 														: SMovementAdjustmentRequestTicket;
	private var movementAdjustor											: CMovementAdjustor;
	private var settings_interrupt											: SAnimatedComponentSlotAnimationSettings;

    event OnEnterState(prevStateName : name)
	{
        if(theGame.getWolvenTrainer().getSuperJump())
        {
		    JumpExtend_Entry(17, 12, 7);
        }
        else if(theGame.getWolvenTrainer().getUltraJump())
        {
            JumpExtend_Entry(34, 24, 14);
        }
	}

    entry function JumpExtend_Entry(x: float, y : float, z : float)
	{
        settings_interrupt.blendIn = 0;
        settings_interrupt.blendOut = 0;

        GetWitcherPlayer().GetRootAnimatedComponent().PlaySlotAnimationAsync( '', 'PLAYER_SLOT', settings_interrupt);
        prev_pos = GetWitcherPlayer().GetWorldPosition();
                            
        movementAdjustor = GetWitcherPlayer().GetMovingAgentComponent().GetMovementAdjustor();
        movementAdjustor.CancelByName( 'jumpextend' );
        movementAdjustor.CancelAll();

        ticket = movementAdjustor.CreateNewRequest( 'jumpextend' );
        movementAdjustor.AdjustmentDuration( ticket, 0.5 );
        movementAdjustor.AdjustLocationVertically( ticket, true );
        movementAdjustor.ScaleAnimationLocationVertically( ticket, true );

        if (GetWitcherPlayer().GetIsSprinting())
        {
            dest = GetWitcherPlayer().PredictWorldPosition(1.0) + (GetWitcherPlayer().GetHeadingVector() * y);
            
            dest.Z += z;
            
            movementAdjustor.MaxLocationAdjustmentDistance(ticket, true, x, y);
        }
        else
        {
            dest = GetWitcherPlayer().PredictWorldPosition(1.0) + (GetWitcherPlayer().GetHeadingVector() * (y-2));
            
            dest.Z += z-2 ;
            
            movementAdjustor.MaxLocationAdjustmentDistance(ticket, true, x-2, y-2);
        }
            
        movementAdjustor.SlideTo(ticket, dest);
    }
}

exec function wolven_toggleSuperJump()
{
    if(!theGame.getWolvenTrainer().getSuperJump())
    {
        theGame.getWolvenTrainer().setSuperJump(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSuperJump(false);
    }
}

exec function wolven_toggleUltraJump()
{
    if(!theGame.getWolvenTrainer().getUltraJump())
    {
        theGame.getWolvenTrainer().setUltraJump(true);
    }
    else
    {
        theGame.getWolvenTrainer().setUltraJump(false);
    }
}

exec function wolven_toggleFlyMode()
{
    if(!theGame.getWolvenTrainer().getFlyMode())
    {
        if(thePlayer.GetExplCamera())
        {
            thePlayer.SetExplCamera(false);
        }
        
        if(!theGame.getWolvenTrainer().getInvis())
        {
            thePlayer.SetVisibility(false);
        }
        thePlayer.EnableCollisions(false);
        thePlayer.SetCanPlayHitAnim(false); 
        if(!theGame.getWolvenTrainer().getEnemiesIgnore())
        {
            thePlayer.SetGameplayVisibility( false );
		    thePlayer.SetTemporaryAttitudeGroup('neutral_to_player',3);
        }
        if(!theGame.getWolvenTrainer().getCollision())
        {
            thePlayer.EnableCharacterCollisions(false); 
        }
        if(!theGame.getWolvenTrainer().getGodMode())
        {
            thePlayer.SetImmortalityMode( AIM_Invulnerable, AIC_Default, true ); 
        }

        if (!((CAnimatedComponent)thePlayer.GetComponentByClassName('CAnimatedComponent')).HasFrozenPose())
		{
			((CAnimatedComponent)thePlayer.GetComponentByClassName('CAnimatedComponent')).FreezePose();
		}

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

        thePlayer.PlayEffect('shadowdash_construct');
        thePlayer.StopEffect('shadowdash_construct');

        theGame.getWolvenTrainer().setFlyMode(true);
    }
    else
    {
        if(!theGame.getWolvenTrainer().getInvis())
        {
            thePlayer.SetVisibility(true);
        }
        thePlayer.EnableCollisions(true);
        thePlayer.SetCanPlayHitAnim(true); 
        thePlayer.SetPlayerCameraPreset();
        if(!theGame.getWolvenTrainer().getEnemiesIgnore())
        {
            thePlayer.SetGameplayVisibility( true );
            thePlayer.ResetTemporaryAttitudeGroup(3);
        }
        if(!theGame.getWolvenTrainer().getCollision())
        {
            thePlayer.EnableCharacterCollisions(true); 
        }
        if(!theGame.getWolvenTrainer().getGodMode())
        {
            thePlayer.SetImmortalityMode( AIM_None, AIC_Default, true ); 
        }

        if (((CAnimatedComponent)thePlayer.GetComponentByClassName('CAnimatedComponent')).HasFrozenPose())
		{
			((CAnimatedComponent)thePlayer.GetComponentByClassName('CAnimatedComponent')).UnfreezePose();
		}

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

        thePlayer.PlayEffect('shadowdash_construct');
        thePlayer.StopEffect('shadowdash_construct');

        theGame.getWolvenTrainer().setFlyMode(false);
    }
}

exec function wolven_toggleInvis()
{
    if(!theGame.getWolvenTrainer().getInvis())
    {
        theGame.getWolvenTrainer().setInvis(true);
        thePlayer.SetVisibility(false);
    }
    else
    {
        theGame.getWolvenTrainer().setInvis(false);
        thePlayer.SetVisibility(true);
    }
}

exec function wolven_toggleCollision()
{
    if(!theGame.getWolvenTrainer().getCollision())
    {
        theGame.getWolvenTrainer().setCollision(true);
        thePlayer.EnableCharacterCollisions(false);
    }
    else
    {
        theGame.getWolvenTrainer().setCollision(false);
        thePlayer.EnableCharacterCollisions(true);
    }
}

exec function wolven_toggleForcefield()
{
    if(!theGame.getWolvenTrainer().getForcefield())
    {
        theGame.getWolvenTrainer().setForcefield(true);

    }
    else
    {
        theGame.getWolvenTrainer().setForcefield(false);
    }
}

exec function wolven_toggleFallDamage()
{
    if(!theGame.getWolvenTrainer().getFallDamage())
    {
        theGame.getWolvenTrainer().setFallDamage(true);
    }
    else
    {
        theGame.getWolvenTrainer().setFallDamage(false);
    }
}

exec function wolven_toggleWeightLimit()
{
    if(!theGame.getWolvenTrainer().getWeightLimit())
    {
        theGame.getWolvenTrainer().setWeightLimit(true);
        GetWitcherPlayer().UpdateEncumbrance();
    }
    else
    {
        theGame.getWolvenTrainer().setWeightLimit(false);
        GetWitcherPlayer().UpdateEncumbrance();
    }
}

exec function wolven_toggleNoToxicity()
{
    if(!theGame.getWolvenTrainer().getNoToxicity())
    {
        theGame.getWolvenTrainer().setNoToxicity(true);
        GetWitcherPlayer().abilityManager.SetStatPointMax(BCS_Toxicity, 1000000);
    }
    else
    {
        theGame.getWolvenTrainer().setNoToxicity(false);
        GetWitcherPlayer().abilityManager.SetStatPointMax(BCS_Toxicity, 100);
    }
}

exec function wolven_toggleNoCrafting()
{
    if(!theGame.getWolvenTrainer().getNoCrafting())
    {
        theGame.getWolvenTrainer().setNoCrafting(true);
    }
    else
    {
        theGame.getWolvenTrainer().setNoCrafting(false);
    }
}

exec function wolven_toggleInfiniteBreath()
{
    if(!theGame.getWolvenTrainer().getInfiniteBreath())
    {
        theGame.getWolvenTrainer().setInfiniteBreath(true);
        
    }
    else
    {
        theGame.getWolvenTrainer().setInfiniteBreath(false);
    }
}

exec function wolven_toggleNightVision() 
{
    if (!theGame.getWolvenTrainer().getNightVision() && !thePlayer.HasBuff(EET_Mutation12Cat)) 
    {
        thePlayer.AddEffectDefault(EET_Mutation12Cat, thePlayer, "NVB", false);
        theGame.getWolvenTrainer().setNightVision(true);
    } 
    else 
    {
        thePlayer.RemoveBuff(EET_Mutation12Cat);
        theGame.getWolvenTrainer().setNightVision(false);
    }
}

exec function wolven_forceaction(val : int)
{
    thePlayer.PlayerStartAction(val);
    theGame.getWolvenTrainer().setLastAction(val);
}
exec function wolven_forceanim(anim : name)
{
    thePlayer.GetRootAnimatedComponent().PlaySlotAnimationAsync( anim, 'PLAYER_SLOT', SAnimatedComponentSlotAnimationSettings(0.7f, 0.7f) );
}

exec function wolven_stopanim()
{
    thePlayer.PlayerStopAction( theGame.getWolvenTrainer().getLastAction());
    thePlayer.GetRootAnimatedComponent().PlaySlotAnimationAsync( '', 'PLAYER_SLOT', SAnimatedComponentSlotAnimationSettings(0.7f, 0.7f) );
}

exec function wolven_setPlayerScale(value: float)
{
    var testcomp : CComponent;

    testcomp = thePlayer.GetComponentByClassName('CAnimatedComponent');
    testcomp.SetScale(Vector(value, value, value, 1));
}

exec function wolven_disableHair()
{
    theGame.getWolvenTrainer().disableNoHairTuck();
    theGame.getWolvenTrainer().disableHair();
}

exec function wolven_hairToggle(template : name)
{
    theGame.getWolvenTrainer().disableNoHairTuck();
    theGame.getWolvenTrainer().enableHair();
    theGame.getWolvenTrainer().ApplyHair(template);
}

exec function wolven_disableHead()
{
    theGame.getWolvenTrainer().disableHeadInternal();
}

exec function wolven_headToggle(template : string)
{
    theGame.getWolvenTrainer().enableHead();
    theGame.getWolvenTrainer().ApplyHead(template);
}

exec function wolven_disableMask()
{
    theGame.getWolvenTrainer().disableMaskInternal();
}

exec function wolven_maskToggle(temp : string)
{
    theGame.getWolvenTrainer().enableMask();
    theGame.getWolvenTrainer().ApplyMask(temp);
}

exec function wolven_disableCape()
{
    theGame.getWolvenTrainer().disableCapeInternal();
}

exec function wolven_capeToggle(cape : string)
{
    theGame.getWolvenTrainer().enableCape();
    theGame.getWolvenTrainer().ApplyCape(cape);
}

exec function wolven_disableFullBody()
{
    theGame.getWolvenTrainer().disableFullBodyInternal();
}

exec function wolven_fullBodyToggle(temp : string)
{
    theGame.getWolvenTrainer().enableFullBody();
    theGame.getWolvenTrainer().ApplyFullBody(temp);
}

exec function wolven_disableShoulder()
{
    theGame.getWolvenTrainer().disableShoulderInternal();
}

exec function wolven_shoulderToggle(temp : string)
{
    theGame.getWolvenTrainer().enableShoulder();
    theGame.getWolvenTrainer().ApplyShoulder(temp);
}

exec function wolven_disableAccessories()
{
    theGame.getWolvenTrainer().disableAccessoriesInternal();
}

exec function wolven_accessoriesToggle(temp : string)
{
    theGame.getWolvenTrainer().enableAccessories();
    theGame.getWolvenTrainer().ApplyAccessories(temp);
}

exec function wolven_disableChest()
{
    theGame.getWolvenTrainer().disableChestInternal();
}

exec function wolven_chestToggle(temp : string)
{
    theGame.getWolvenTrainer().enableChest();
    theGame.getWolvenTrainer().ApplyChest(temp);
    theGame.getWolvenTrainer().ChestAppearance(false);
}

exec function wolven_disableLeggings()
{
    theGame.getWolvenTrainer().disableLeggingsInternal();
}

exec function wolven_leggingsToggle(temp : string)
{
    theGame.getWolvenTrainer().enableLeggings();
    theGame.getWolvenTrainer().ApplyLeggings(temp);
    theGame.getWolvenTrainer().LeggingsAppearance(false);
}

exec function wolven_disableGloves()
{
    theGame.getWolvenTrainer().disableGlovesInternal();
}

exec function wolven_glovesToggle(temp : string)
{
    theGame.getWolvenTrainer().enableGloves();
    theGame.getWolvenTrainer().ApplyGloves(temp);
    theGame.getWolvenTrainer().GlovesAppearance(false);
}

exec function wolven_disableBoots()
{
    theGame.getWolvenTrainer().disableBootsInternal();
}

exec function wolven_bootsToggle(temp : string)
{
    theGame.getWolvenTrainer().enableBoots();
    theGame.getWolvenTrainer().ApplyBoots(temp);
    theGame.getWolvenTrainer().BootsAppearance(false);
}

exec function wolven_SetBeard( stage : int )
{
    var acs : array< CComponent >;
    
    acs = thePlayer.GetComponentsByClassName( 'CHeadManagerComponent' );
    ( ( CHeadManagerComponent ) acs[0] ).SetBeardStage( false, stage );
}

exec function wolven_SetHead(head : name)
{
    var acs : array< CComponent >;

    acs = thePlayer.GetComponentsByClassName( 'CHeadManagerComponent' );
    thePlayer.RememberCustomHead( head );
    ( ( CHeadManagerComponent ) acs[0] ).SetCustomHead( head );
}

exec function wolven_disableSteelSwords()
{
    theGame.getWolvenTrainer().disableSteelSwordsInternal();
}

exec function wolven_steelSwordToggle(temp : string)
{
    theGame.getWolvenTrainer().enableSteelSwords();
    theGame.getWolvenTrainer().SteelSwordChange(temp);
}

exec function wolven_disableSilverSwords()
{
    theGame.getWolvenTrainer().disableSilverSwordsInternal();
}

exec function wolven_silverSwordToggle(temp : string)
{
    theGame.getWolvenTrainer().enableSilverSwords();
    theGame.getWolvenTrainer().SilverSwordChange(temp);
}

exec function wolven_disableSteelScabbard()
{
    theGame.getWolvenTrainer().disableSteelScabbardInternal();
}

exec function wolven_steelScabbardToggle(temp : string)
{
    theGame.getWolvenTrainer().enableSteelScabbard();
    theGame.getWolvenTrainer().hideSteelScabbard(true);
    theGame.getWolvenTrainer().ApplyStscab(temp);
}

exec function wolven_disableSilverScabbard()
{
    theGame.getWolvenTrainer().disableSilverScabbardInternal();
}

exec function wolven_silverScabbardToggle(temp : string)
{
    theGame.getWolvenTrainer().enableSilverScabbard();
    theGame.getWolvenTrainer().hideSilverScabbard(true);
    theGame.getWolvenTrainer().ApplySvscab(temp);
}

exec function wolven_restoreOutfit()
{
    theGame.getWolvenTrainer().restoreOutfitInternal();
}

exec function wolven_removeAllComponents()
{
    theGame.getWolvenTrainer().removeAllComponents();
}

exec function wolven_setPlayerType(type : string)
{
    if(type == "Geralt")
    {
	    theGame.ChangePlayer( "Geralt" );
	    thePlayer.Debug_ReleaseCriticalStateSaveLocks();
    }
    else if(type == "Ciri")
    {
        theGame.ChangePlayer( "Ciri" );
	    thePlayer.Debug_ReleaseCriticalStateSaveLocks();
    }
}

exec function wolven_disableHorseModel()
{
    theGame.getWolvenTrainer().disableHorseModelInternal();
}

exec function wolven_changeHorseModel(customType : name)
{
    theGame.getWolvenTrainer().changeHorse(true, customType);
    theGame.getWolvenTrainer().refreshHorse();
}

exec function wolven_hideHorseEquipment()
{
    theGame.getWolvenTrainer().disableEquipment();
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableSaddle()
{
    theGame.getWolvenTrainer().disableSaddleInternal();
}

exec function wolven_saddleToggle(temp : string)
{
    theGame.getWolvenTrainer().enableSaddle();
    theGame.getWolvenTrainer().ApplySaddle(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableBlinders()
{
    theGame.getWolvenTrainer().disableBlindersInternal();
}

exec function wolven_blindersToggle(temp : string)
{
    theGame.getWolvenTrainer().enableBlinders();
    theGame.getWolvenTrainer().ApplyBlinders(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableHorseHair()
{
    theGame.getWolvenTrainer().disableHorseHairInternal();
}

exec function wolven_horseHairToggle(temp : string)
{
    theGame.getWolvenTrainer().enableHorseHair();
    theGame.getWolvenTrainer().ApplyHorseHair(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableTails()
{
    theGame.getWolvenTrainer().disableTailsInternal();
}

exec function wolven_tailsToggle(temp : string)
{
    theGame.getWolvenTrainer().enableTails();
    theGame.getWolvenTrainer().ApplyTails(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableBags()
{
    theGame.getWolvenTrainer().disableBagsInternal();
}

exec function wolven_bagsToggle(temp : string)
{
    theGame.getWolvenTrainer().enableBags();
    theGame.getWolvenTrainer().ApplyBags(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableTrophies()
{
    theGame.getWolvenTrainer().disableTrophiesInternal();
}

exec function wolven_trophiesToggle(temp : string)
{
    theGame.getWolvenTrainer().enableTrophies();
    theGame.getWolvenTrainer().ApplyTrophies(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableReins()
{
    theGame.getWolvenTrainer().disableReinsInternal();
}

exec function wolven_reinsToggle(temp : string)
{
    theGame.getWolvenTrainer().enableReins();
    theGame.getWolvenTrainer().ApplyReins(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableHarness()
{
    theGame.getWolvenTrainer().disableHarnessInternal();
}

exec function wolven_harnessToggle(temp : string)
{
    theGame.getWolvenTrainer().enableHarness();
    theGame.getWolvenTrainer().ApplyHarness(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_disableHorseAccessories()
{
    theGame.getWolvenTrainer().disableHorseAccessoriesInternal();
}

exec function wolven_horseAccessoriesToggle(temp : string)
{
    theGame.getWolvenTrainer().enableHorseAccessories();
    theGame.getWolvenTrainer().ApplyHorseAccessories(temp);
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_hideSaddle()
{
    theGame.getWolvenTrainer().disableSaddleInternal();
    theGame.getWolvenTrainer().hideSaddle();
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_hideBlinders()
{
    theGame.getWolvenTrainer().disableBlindersInternal();
    theGame.getWolvenTrainer().hideBlinders();
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_hideHorseHair()
{
    theGame.getWolvenTrainer().disableHorseHairInternal();
    theGame.getWolvenTrainer().hideHorseHair();
    theGame.getWolvenTrainer().hideHorseEquipment();
}
exec function wolven_hideTails()
{
    theGame.getWolvenTrainer().disableTailsInternal();
    theGame.getWolvenTrainer().hideTail();
    theGame.getWolvenTrainer().hideHorseEquipment();
}
exec function wolven_hideBags()
{
    theGame.getWolvenTrainer().disableBagsInternal();
    theGame.getWolvenTrainer().hideBags();
    theGame.getWolvenTrainer().hideHorseEquipment();
}
exec function wolven_hideTrophy()
{
    theGame.getWolvenTrainer().disableTrophiesInternal();
    theGame.getWolvenTrainer().hideTrophy();
    theGame.getWolvenTrainer().hideHorseEquipment();
}
exec function wolven_hideReins()
{
    theGame.getWolvenTrainer().disableReinsInternal();
    theGame.getWolvenTrainer().hideReins();
    theGame.getWolvenTrainer().hideHorseEquipment();
}
exec function wolven_hideHarness()
{
    theGame.getWolvenTrainer().disableHarnessInternal();
    theGame.getWolvenTrainer().hideHarness();
    theGame.getWolvenTrainer().hideHorseEquipment();
}

exec function wolven_toggleHorseDemonFX()
{
    if(theGame.getWolvenTrainer().getHorseDemonFX())
    {
        theGame.getWolvenTrainer().horseDemonFX(false);
        theGame.getWolvenTrainer().setHorseDemonFX(false);
    }
    else
    {
        theGame.getWolvenTrainer().horseDemonFX(true);
        theGame.getWolvenTrainer().setHorseDemonFX(true);
    }
}

exec function wolven_toggleHorseIceFX()
{
    if(theGame.getWolvenTrainer().getHorseIceFX())
    {
        theGame.getWolvenTrainer().horseIceFX(false);
        theGame.getWolvenTrainer().setHorseIceFX(false);
    }
    else
    {
        theGame.getWolvenTrainer().horseIceFX(true);
        theGame.getWolvenTrainer().setHorseIceFX(true);
    }
}

exec function wolven_togglePlayerIceFX()
{
    if(theGame.getWolvenTrainer().getPlayerIceFX())
    {
        theGame.getWolvenTrainer().playerIceFX(false);
        theGame.getWolvenTrainer().setPlayerIceFX(false);
    }
    else
    {
        theGame.getWolvenTrainer().playerIceFX(true);
        theGame.getWolvenTrainer().setPlayerIceFX(true);
    }
}

exec function wolven_toggleHorseFireFX()
{
    if(theGame.getWolvenTrainer().getHorseFireFX())
    {
        theGame.getWolvenTrainer().horseFireFX(false);
        theGame.getWolvenTrainer().setHorseFireFX(false);
    }
    else
    {
        theGame.getWolvenTrainer().horseFireFX(true);
        theGame.getWolvenTrainer().setHorseFireFX(true);
    }
}

exec function wolven_restoreHorse()
{
    theGame.getWolvenTrainer().restoreHorseInternal();
}

exec function wolven_toggleInstantMount()
{
    if(theGame.getWolvenTrainer().getInstantMount())
    {
        theGame.getWolvenTrainer().setInstantMount(false);
    }
    else
    {
        theGame.getWolvenTrainer().setInstantMount(true);
    }
}

exec function wolven_teleportToRoach()
{
    var theHorse : CNewNPC;
    
    theHorse = thePlayer.GetHorseWithInventory();
    if(!theHorse ||	!theHorse.IsAlive()) {
        theGame.getWolvenTrainer().summonRoach();
        GetWitcherPlayer().AddTimer('tpToHorse', 0.125, false);
    }
    else
    {
        theGame.getWolvenTrainer().tpToHorse();
    }
}

exec function wolven_teleportRoachToMe()
{
    var theHorse : CNewNPC;
    
    theHorse = thePlayer.GetHorseWithInventory();
    if(!theHorse ||	!theHorse.IsAlive()) {
        theGame.getWolvenTrainer().summonRoach();
        GetWitcherPlayer().AddTimer('tpHorse', 0.125, false);
    }
    else
    {
        theGame.getWolvenTrainer().tpHorse();
    }
}

exec function wolven_setHorseScale(value: float)
{
    var testcomp : CComponent;
    var theHorse : CNewNPC;
    
    theHorse = thePlayer.GetHorseWithInventory();
    if(!theHorse || !theHorse.IsAlive())
    {
        return;
    }

    testcomp = theHorse.GetComponentByClassName('CAnimatedComponent');
    testcomp.SetScale(Vector(value, value, value, 1));
}

exec function wolven_setHorseSpeedValue(value : float)
{
    theGame.getWolvenTrainer().setHorseSpeed(value);
}

exec function wolven_toggleHorseFlyMode()
{
    var theHorse : CNewNPC;
    theHorse = thePlayer.GetHorseWithInventory();

    if(!theGame.getWolvenTrainer().getHorseFlyMode())
    {
        theHorse.EnableCollisions(false);

        if(thePlayer.GetHorseCamera())
        {
            thePlayer.SetHorseCamera(false);
        }

        thePlayer.SetCanPlayHitAnim(false); 
        if(!theGame.getWolvenTrainer().getEnemiesIgnore())
        {
            thePlayer.SetGameplayVisibility( false );
		    thePlayer.SetTemporaryAttitudeGroup('neutral_to_player',3);
        }
        if(!theGame.getWolvenTrainer().getGodMode())
        {
            thePlayer.SetImmortalityMode( AIM_Invulnerable, AIC_Default, true ); 
        }

        theGame.getWolvenTrainer().setHorseFlyMode(true);
    }
    else
    {
        theHorse.EnableCollisions(true);
        thePlayer.SetCanPlayHitAnim(true); 

        thePlayer.SetPlayerCameraPreset();

        if(!theGame.getWolvenTrainer().getEnemiesIgnore())
        {
            thePlayer.SetGameplayVisibility( true );
            thePlayer.ResetTemporaryAttitudeGroup(3);
        }
        if(!theGame.getWolvenTrainer().getGodMode())
        {
            thePlayer.SetImmortalityMode( AIM_None, AIC_Default, true ); 
        }

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


        theGame.getWolvenTrainer().setHorseFlyMode(false);
    }
}

exec function wolven_toggleHorseInvis()
{
    var theHorse : CNewNPC;
    
    theHorse = thePlayer.GetHorseWithInventory();

    if(theGame.getWolvenTrainer().getHorseInvis())
    {
        if(theHorse || theHorse.IsAlive())
        {
            theHorse.SetVisibility(true);
        }

        theGame.getWolvenTrainer().setHorseInvis(false);
    }
    else
    {
        if(theHorse || theHorse.IsAlive())
        {
            theHorse.SetVisibility(false);
        }

        theGame.getWolvenTrainer().setHorseInvis(true);
    }
}

exec function wolven_toggleInfiniteHorseStamina()
{
    var theHorse : CNewNPC;
    
    theHorse = thePlayer.GetHorseWithInventory();

    if(!theGame.getWolvenTrainer().getInfiniteHorseStamina())
    {
        theGame.getWolvenTrainer().setInfiniteHorseStamina(true);

    }
    else
    {
        theGame.getWolvenTrainer().setInfiniteHorseStamina(false);
    }
}

exec function wolven_toggleNoHorsePanic()
{
    var theHorse : CNewNPC;
    
    theHorse = thePlayer.GetHorseWithInventory();

    if(!theGame.getWolvenTrainer().getNoHorsePanic())
    {
        theGame.getWolvenTrainer().setNoHorsePanic(true);

    }
    else
    {
        theGame.getWolvenTrainer().setNoHorsePanic(false);
    }
}

exec function wolven_toggleInfiniteSignStamina()
{
    if(!theGame.getWolvenTrainer().getInfiniteSignStamina())
    {
        theGame.getWolvenTrainer().setInfiniteSignStamina(true);
    }
    else
    {
        theGame.getWolvenTrainer().setInfiniteSignStamina(false);
    }
}

exec function wolven_toggleInfiniteAdrenaline()
{
    if(!theGame.getWolvenTrainer().getInfiniteAdrenaline())
    {
        theGame.getWolvenTrainer().setInfiniteAdrenaline(true);
    }
    else
    {
        theGame.getWolvenTrainer().setInfiniteAdrenaline(false);
    }
}

exec function wolven_toggleAutoHeal()
{
    if(!theGame.getWolvenTrainer().getAutoHeal())
    {
        theGame.getWolvenTrainer().setAutoHeal(true);
    }
    else
    {
        theGame.getWolvenTrainer().setAutoHeal(false);
    }
}

exec function wolven_pauseGame()
{
    theGame.getWolvenTrainer().setPaused(true);
    theInput.StoreContext( 'EMPTY_CONTEXT' );
    theGame.Pause( "user_pause" );
    theSound.SoundEvent('gui_global_highlight');
    thePlayer.EnableManualCameraControl(false, 'WolvenTrainer');
}
exec function wolven_unpauseGame()
{
    GetWitcherPlayer().AddTimer('delayUnpause', 0.125, false);
    theInput.RestoreContext( 'EMPTY_CONTEXT', true );
    theGame.Unpause( "user_pause" );
    theSound.SoundEvent('gui_global_highlight');
    thePlayer.EnableManualCameraControl(true, 'WolvenTrainer');
}

exec function wolven_toggleGallopInCities()
{
    if(!theGame.getWolvenTrainer().getGallopInCities())
    {
        thePlayer.SetIsHorseRacing( true );
        theGame.getWolvenTrainer().setGallopInCities(true);
    }
    else
    {
        thePlayer.SetIsHorseRacing( false );

        theGame.getWolvenTrainer().setGallopInCities(false);
    }
}

exec function wolven_toggleNoLevelRequirements()
{
    if(!theGame.getWolvenTrainer().getNoLevelRequirements())
    {
        theGame.getWolvenTrainer().setNoLevelRequirements(true);
    }
    else
    {
        theGame.getWolvenTrainer().setNoLevelRequirements(false);
    }
}

exec function wolven_toggleNoDurability()
{
    if(!theGame.getWolvenTrainer().getNoDurability())
    {
        theGame.getWolvenTrainer().setNoDurability(true);
    }
    else
    {
        theGame.getWolvenTrainer().setNoDurability(false);
    }
}

exec function wolven_toggleBloodbath()
{
    if(!theGame.getWolvenTrainer().getBloodbath())
    {
        theGame.getWolvenTrainer().setBloodbath(true);
    }
    else
    {
        theGame.getWolvenTrainer().setBloodbath(false);
    }
}

exec function wolven_toggleUnlimitedConsumables()
{
    if(!theGame.getWolvenTrainer().getUnlimitedConsumables())
    {
        theGame.getWolvenTrainer().setUnlimitedConsumables(true);
        FactsAdd("debug_fact_inf_bolts");
    }
    else
    {
        theGame.getWolvenTrainer().setUnlimitedConsumables(false);
        FactsRemove("debug_fact_inf_bolts");
    }
}

exec function wolven_toggleStealing()
{
    if(!theGame.getWolvenTrainer().getStealing())
    {
        theGame.getWolvenTrainer().setStealing(true);
    }
    else
    {
        theGame.getWolvenTrainer().setStealing(false);
    }
}

exec function wolven_repairItems()
{
    theSound.SoundEvent("gui_inventory_repair");
    theGame.getWolvenTrainer().repairEquippedItems();
}

exec function wolven_addCrowns(val : int)
{
	thePlayer.AddMoney(val);
}

exec function wolven_removeCrowns(val : int)
{
    if(val > thePlayer.inv.GetMoney())
    {
        thePlayer.RemoveMoney(thePlayer.inv.GetMoney());
    }
    else
    {
	    thePlayer.RemoveMoney(val);
    }
}

exec function wolven_setCrowns(val : int)
{
	thePlayer.RemoveMoney(thePlayer.inv.GetMoney());
	thePlayer.AddMoney(val);
}

exec function wolven_removeSkillPoints(val : int)
{
    theGame.getWolvenTrainer().removeSkillPointsInternal(val);
}

exec function wolven_setSkillPoints(val : int)
{
    if(val < 0)
		val = 0;

    GetWitcherPlayer().levelManager.SetFreeSkillPoints(val);
}

exec function wolven_trainerSetLevel( targetLvl : int )
{
    GetWitcherPlayer().levelManager.SetLevel(targetLvl);
}

exec function wolven_learnAllSkills()
{
	var i : int;
	var skills : array<SSkill>;

    skills = thePlayer.GetPlayerSkills();

    theSound.SoundEvent("gui_character_add_skill");

    for(i=0; i<skills.Size(); i+=1)
    {
        thePlayer.AddSkill(skills[i].skillType);
        thePlayer.AddSkill(skills[i].skillType);
        thePlayer.AddSkill(skills[i].skillType);
    }
}

exec function wolven_enchantArmor(wordAsName : name)
{
    var itemId : SItemUniqueId;

    if(GetWitcherPlayer().GetItemEquippedOnSlot(EES_Armor, itemId))
	{
        theSound.SoundEvent('gui_enchanting_runeword_add');
        GetWitcherPlayer().inv.EnchantItem(itemId, wordAsName, getEnchamtmentStatName(wordAsName));
    }
}

exec function wolven_removeEnchantArmor()
{
    var itemId : SItemUniqueId;

    if(GetWitcherPlayer().GetItemEquippedOnSlot(EES_Armor, itemId))
	{
        theSound.SoundEvent('gui_enchanting_runeword_remove');
        GetWitcherPlayer().inv.UnenchantItem(itemId);
    }
}

exec function wolven_enchantSteel(wordAsName : name)
{
    var itemId : SItemUniqueId;

    if(GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, itemId))
	{
        theSound.SoundEvent('gui_enchanting_runeword_add');
        GetWitcherPlayer().inv.EnchantItem(itemId, wordAsName, getEnchamtmentStatName(wordAsName));
    }
}

exec function wolven_removeEnchantSteel()
{
    var itemId : SItemUniqueId;

    if(GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, itemId))
	{
        theSound.SoundEvent('gui_enchanting_runeword_remove');
        GetWitcherPlayer().inv.UnenchantItem(itemId);
    }
}

exec function wolven_enchantSilver(wordAsName : name)
{
    var itemId : SItemUniqueId;

    if(GetWitcherPlayer().GetItemEquippedOnSlot(EES_SilverSword, itemId))
	{
        theSound.SoundEvent('gui_enchanting_runeword_add');
        GetWitcherPlayer().inv.EnchantItem(itemId, wordAsName, getEnchamtmentStatName(wordAsName));
    }
}

exec function wolven_removeEnchantSilver()
{
    var itemId : SItemUniqueId;

    if(GetWitcherPlayer().GetItemEquippedOnSlot(EES_SilverSword, itemId))
	{
        theSound.SoundEvent('gui_enchanting_runeword_remove');
        GetWitcherPlayer().inv.UnenchantItem(itemId);
    }
}

exec function wolven_addItem(itemName : name, optional count : int)
{
	var ids : array<SItemUniqueId>;
	var i : int;

	if(IsNameValid(itemName))
	{
		ids = thePlayer.inv.AddAnItem(itemName, count);

        theSound.SoundEvent("gui_inventory_other_attach");

		if(thePlayer.inv.IsItemSingletonItem(ids[0]))
		{
			for(i=0; i<ids.Size(); i+=1)
				thePlayer.inv.SingletonItemSetAmmo(ids[i], thePlayer.inv.SingletonItemGetMaxAmmo(ids[i]));
		}
		
		if(ids.Size() == 0)
		{
			return;
		}
	}
}

exec function wolven_removeItem(n : name, optional count : int)
{
    theSound.SoundEvent("gui_inventory_other_back");

    if(count == 0)
    {
		count = 1;
    }

	thePlayer.inv.RemoveItemByName( n, count );
}

exec function wolven_learnSkill(skillName : name)
{
	var i : int;
	var skills : array<SSkill>;

    theSound.SoundEvent("gui_character_add_skill");

	if(skillName == 'all')
	{
		skills = thePlayer.GetPlayerSkills();
		for(i=0; i<skills.Size(); i+=1)
		{
			thePlayer.AddSkill(skills[i].skillType);
		}
	}
	else
	{
		thePlayer.AddSkill(SkillNameToEnum(skillName));
	}
}

exec function wolven_mutEq( number : int )
{
	var mut : EPlayerMutationType;
	
	GetWitcherPlayer().MutationSystemEnable( true );
	mut = number;
	( ( W3PlayerAbilityManager ) GetWitcherPlayer().abilityManager ).DEBUG_DevelopAndEquipMutation( mut );

    theSound.SoundEvent("gui_character_synergy_effect");
}

exec function wolven_mutAll()
{
	var pam : W3PlayerAbilityManager;
	var i : int;
	
	GetWitcherPlayer().MutationSystemEnable( true );
	pam = ( W3PlayerAbilityManager ) GetWitcherPlayer().abilityManager;
	for( i=12; i>0; i-=1 )
	{
		pam.DEBUG_DevelopAndEquipMutation( i );
	}

    theSound.SoundEvent("gui_character_synergy_effect");
}

exec function wolven_refill()
{
    theSound.SoundEvent("gui_alchemy_brew");
	thePlayer.inv.SingletonItemsRefillAmmoNoAlco(true);
}

exec function wolven_toggleFT()
{
    if(!theGame.getWolvenTrainer().getFT())
    {
        theGame.getWolvenTrainer().setFT(true);
        theGame.GetCommonMapManager().DBG_AllowFT(true);
    }
    else
    {
        theGame.getWolvenTrainer().setFT(false);
        theGame.GetCommonMapManager().DBG_AllowFT(false);
    }
}

exec function wolven_unlockMap()
{
	var mapManager : CCommonMapManager = theGame.GetCommonMapManager();
    var arr : array< name >;
    var i : int;

    if ( !mapManager )
    {
        return;
    }

    arr = mapManager.GetDiscoverableEntityNames();
    
    theSound.SoundEvent("gui_ingame_new_journal");

    for ( i = 0; i < arr.Size(); i += 1 )
    {
        mapManager.SetEntityMapPinKnown( arr[ i ], true );
        mapManager.SetEntityMapPinDiscovered( arr[ i ], true );
    }
}

exec function wolven_unlockFT()
{
	var mapManager : CCommonMapManager = theGame.GetCommonMapManager();
	var arr : array< SAvailableFastTravelMapPin >;
    var i : int;

    if ( !mapManager )
    {
        return;
    }

    arr = mapManager.GetFastTravelPoints( false, false );

    theSound.SoundEvent("gui_ingame_new_journal");

    for ( i = 0; i < arr.Size(); i += 1 )
    {
        mapManager.SetEntityMapPinDiscovered( arr[ i ].tag, true );
    }
}

exec function wolven_unlockPlaceOfPowers()
{
    var mapManager : CCommonMapManager = theGame.GetCommonMapManager();
    var i, j : int;
    var areaMapPins : array< SAreaMapPinInfo >;
    var entityMapPins : array< SEntityMapPinInfo >;
    var names : array< name >;
    var type : name;
    var discoverableMapPinTypes : array< name >;
    
    if ( !mapManager )
    {
        return;
    }

    mapManager.GetDiscoverableMapPinTypes( discoverableMapPinTypes );

    areaMapPins = mapManager.GetAreaMapPins();
    for ( i = 0; i < areaMapPins.Size(); i += 1 )
    {
        entityMapPins = mapManager.GetEntityMapPins( areaMapPins[ i ].worldPath );
        for ( j = 0; j < entityMapPins.Size(); j += 1 )
        {
            if ( discoverableMapPinTypes.Contains( entityMapPins[ j ].entityType ) )
            {
                if(entityMapPins[j].entityType == 'PlaceOfPower')
                {
                    names.PushBack( entityMapPins[ j ].entityName );
                }
            }
        }
    }

    theSound.SoundEvent("gui_ingame_new_journal");

    for ( i = 0; i < names.Size(); i += 1 )
    {
        mapManager.SetEntityMapPinKnown( names[ i ], true );
        mapManager.SetEntityMapPinDiscovered( names[ i ], true );
    }
}

exec function wolven_unlockAllCrafting()
{
    var names : array<name>;
    var i : int;
    var locKey : string;
    var dm : CDefinitionsManagerAccessor;

    names = theGame.GetDefinitionsManager().GetItemsWithTag('ReadableItem');
    dm = theGame.GetDefinitionsManager();

    for(i = 0; i < names.Size(); i+=1)
    {
        if(dm.GetItemCategory(names[i]) == 'crafting_schematic')
        {
            locKey = GetLocStringByKeyExt(dm.GetItemLocalisationKeyName(names[i]));

            if(locKey != "")
            {
                GetWitcherPlayer().AddCraftingSchematic(names[i]);
            }
        }
    }
}

exec function wolven_addCraft(theName : name)
{
    GetWitcherPlayer().AddCraftingSchematic(theName);
}

exec function wolven_unlockAllRecipes()
{
    var names : array<name>;
    var i : int;
    var locKey : string;
    var dm : CDefinitionsManagerAccessor;

    names = theGame.GetDefinitionsManager().GetItemsWithTag('ReadableItem');
    dm = theGame.GetDefinitionsManager();

    for(i = 0; i < names.Size(); i+=1)
    {
        if(dm.GetItemCategory(names[i]) == 'alchemy_recipe')
        {
            locKey = GetLocStringByKeyExt(dm.GetItemLocalisationKeyName(names[i]));

            if(locKey != "")
            {
                if(names[i] != 'Recipe for Mutation Serum')
                {
                    GetWitcherPlayer().AddAlchemyRecipe(names[i]);
                }
            }
        }
    }
}

exec function wolven_addRecipe(theName : name)
{
    GetWitcherPlayer().AddAlchemyRecipe(theName);
}

exec function wolven_unlockAllAchievements()
{
	var gamerProfile : W3GamerProfile;
	var i : int;
	
    theSound.SoundEvent("gui_ingame_new_journal");

	gamerProfile = theGame.GetGamerProfile();
	for( i = 0; i <= EnumGetMax('EAchievement'); i += 1 )
	{
		gamerProfile.AddAchievement(i);
	}
}

exec function wolven_enableYenCookingScene()
{
    theSound.SoundEvent("gui_ingame_new_journal");
    FactsAdd("q401_cooking_enabled", 1, -1);
}

exec function wolven_unlockAllGwent()
{
    var names : array<name>;
    var i : int;
    var locKey : string;
    var dm : CDefinitionsManagerAccessor;

    names = theGame.GetDefinitionsManager().GetItemsWithTag('GwintCard');
    dm = theGame.GetDefinitionsManager();

    theSound.SoundEvent("gui_ingame_new_journal");

    for(i = 0; i < names.Size(); i+=1)
    {
	    GetWitcherPlayer().AddGwentCard( names[i], 1 );
    }

}

exec function wolven_unlockAllSkillSlots()
{
    var i, size : int;

    size = GetWitcherPlayer().GetSkillSlotsCount();

    theSound.SoundEvent("gui_ingame_new_journal");

    for(i=0; i<size; i+=1)
    {
        GetWitcherPlayer().Debug_HAX_UnlockSkillSlot(i);
    }
}

exec function wolven_addFact(factID : string, optional value : int, optional expires : int)
{
	var val : int;
	var exp : int;
	
	if(value == 0)
		val = 1;
	else
		val = value;

	if ( expires == 0)
	    exp = -1;
	else
		exp = expires;
	
    theSound.SoundEvent("gui_ingame_new_journal");
	FactsAdd(factID, val, exp);
}

exec function wolven_removeFact(factID : string)
{
    theSound.SoundEvent("gui_ingame_new_journal");
	FactsRemove(factID);
}

exec function wolven_toggleDamageMultiplier()
{
    if(!theGame.getWolvenTrainer().getDamageMultiplier())
    {
        theGame.getWolvenTrainer().setDamageMultiplier(true);
    }
    else
    {
        theGame.getWolvenTrainer().setDamageMultiplier(false);
    }
}

exec function wolven_setDamageOverall(val : float)
{
    theGame.getWolvenTrainer().setDamageOverall(val);
}

exec function wolven_setDamageBomb(val : float)
{
    theGame.getWolvenTrainer().setDamageBomb(val);
}

exec function wolven_setDamageCrossbow(val : float)
{
    theGame.getWolvenTrainer().setDamageCrossbow(val);
}

exec function wolven_setDamageFists(val : float)
{
    theGame.getWolvenTrainer().setDamageFists(val);
}

exec function wolven_setDamageSign(val : float)
{
    theGame.getWolvenTrainer().setDamageSign(val);
}

exec function wolven_setDamageSwords(val : float)
{
    theGame.getWolvenTrainer().setDamageSwords(val);
}

exec function wolven_setIncomingDamageOverall(val : float)
{
    theGame.getWolvenTrainer().setIncomingDamageOverall(val);
}

exec function wolven_setDamageOT(val : float)
{
    theGame.getWolvenTrainer().setDamageOT(val);
}

exec function wolven_toggleSteelAardFX()
{
    if(!theGame.getWolvenTrainer().getSteelAardFX())
    {
        theGame.getWolvenTrainer().setSteelAardFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSteelAardFX(false);
    }
}

exec function wolven_toggleSteelAxiiFX()
{
    if(!theGame.getWolvenTrainer().getSteelAxiiFX())
    {
        theGame.getWolvenTrainer().setSteelAxiiFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSteelAxiiFX(false);
    }
}

exec function wolven_toggleSteelIgniFX()
{
    if(!theGame.getWolvenTrainer().getSteelIgniFX())
    {
        theGame.getWolvenTrainer().setSteelIgniFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSteelIgniFX(false);
    }
}

exec function wolven_toggleSteelQuenFX()
{
    if(!theGame.getWolvenTrainer().getSteelQuenFX())
    {
        theGame.getWolvenTrainer().setSteelQuenFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSteelQuenFX(false);
    }
}

exec function wolven_toggleSteelYrdenFX()
{
    if(!theGame.getWolvenTrainer().getSteelYrdenFX())
    {
        theGame.getWolvenTrainer().setSteelYrdenFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSteelYrdenFX(false);
    }
}

exec function wolven_setSteelRuneLvl(val : string)
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(val == "Inherit")
    {
        theGame.getWolvenTrainer().setSteelRuneLvl('none');
    }
    else if(val == "None")
    {
        theGame.getWolvenTrainer().setSteelRuneLvl('rune_lvl0');
    }
    else if(val == "1")
    {
        theGame.getWolvenTrainer().setSteelRuneLvl('rune_lvl1');
    }
    else if(val == "2")
    {
        theGame.getWolvenTrainer().setSteelRuneLvl('rune_lvl2');
    }
    else if(val == "3")
    {
        theGame.getWolvenTrainer().setSteelRuneLvl('rune_lvl3');
    }

}

exec function wolven_setSteelRuneType(val : string)
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(val == "Inherit")
    {
        theGame.getWolvenTrainer().setSteelRuneType('none');
    }
    else if(val == "Stribog")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_stribog');
    }
    else if(val == "Dazhbog")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_dazhbog');
    }
    else if(val == "Devana")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_devana');
    }
    else if(val == "Zoria")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_zoria');
    }
    else if(val == "Morana")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_morana');
    }
    else if(val == "Triglav")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_triglav');
    }
    else if(val == "Svarog")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_svarog');
    }
    else if(val == "Veles")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_veles');
    }
    else if(val == "Perun")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_perun');
    }
    else if(val == "Elemental")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_elemental');
    }
    else if(val == "Pierog")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_pierog');
    }
    else if(val == "Tvarog")
    {
        theGame.getWolvenTrainer().setSteelRuneType('rune_tvarog');
    }
    else if(val == "Replenishment")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_replenishment');
    }
    else if(val == "Severance")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_severance');
    }
    else if(val == "Invigoration")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_invigoration');
    }
    else if(val == "Preservation")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_preservation');
    }
    else if(val == "Dumplings")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_dumplings');
    }
    else if(val == "Exhaustion")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_exhaustion');
    }
    else if(val == "Placation")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_placation');
    }
    else if(val == "Rejuvenation")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_rejuvenation');
    }
    else if(val == "Prolongation")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_prolongation');
    }
    else if(val == "Elation")
    {
        theGame.getWolvenTrainer().setSteelRuneType('runeword_elation');
    }

}

exec function wolven_toggleSteelRuneGlow()
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(!theGame.getWolvenTrainer().getSteelRuneGlow())
    {
        theGame.getWolvenTrainer().setSteelRuneGlow(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSteelRuneGlow(false);
    }
}

exec function wolven_setSteelOilType(val : string)
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(val == "Inherit")
    {
        theGame.getWolvenTrainer().setSteelOilType('none');
    }
    else if(val == "None")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_none');
    }
    else if(val == "Beast")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_beast');
    }
    else if(val == "Cursed")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_cursed');
    }
    else if(val == "Venom")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_venom');
    }
    else if(val == "Hybrid")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_hybrid');
    }
    else if(val == "Insectoid")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_insectoid');
    }
    else if(val == "Magical")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_magical');
    }
    else if(val == "Necrophage")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_necrophage');
    }
    else if(val == "Specter")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_specter');
    }
    else if(val == "Vampire")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_vampire');
    }
    else if(val == "Draconide")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_draconide');
    }
    else if(val == "Ogre")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_ogre');
    }
    else if(val == "Relic")
    {
        theGame.getWolvenTrainer().setSteelOilType('oil_relic');
    }
}

exec function wolven_toggleSilverAardFX()
{
    if(!theGame.getWolvenTrainer().getSilverAardFX())
    {
        theGame.getWolvenTrainer().setSilverAardFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSilverAardFX(false);
    }
}

exec function wolven_toggleSilverAxiiFX()
{
    if(!theGame.getWolvenTrainer().getSilverAxiiFX())
    {
        theGame.getWolvenTrainer().setSilverAxiiFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSilverAxiiFX(false);
    }
}

exec function wolven_toggleSilverIgniFX()
{
    if(!theGame.getWolvenTrainer().getSilverIgniFX())
    {
        theGame.getWolvenTrainer().setSilverIgniFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSilverIgniFX(false);
    }
}

exec function wolven_toggleSilverQuenFX()
{
    if(!theGame.getWolvenTrainer().getSilverQuenFX())
    {
        theGame.getWolvenTrainer().setSilverQuenFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSilverQuenFX(false);
    }
}

exec function wolven_toggleSilverYrdenFX()
{
    if(!theGame.getWolvenTrainer().getSilverYrdenFX())
    {
        theGame.getWolvenTrainer().setSilverYrdenFX(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSilverYrdenFX(false);
    }
}

exec function wolven_setSilverRuneLvl(val : string)
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(val == "Inherit")
    {
        theGame.getWolvenTrainer().setSilverRuneLvl('none');
    }
    else if(val == "None")
    {
        theGame.getWolvenTrainer().setSilverRuneLvl('rune_lvl0');
    }
    else if(val == "1")
    {
        theGame.getWolvenTrainer().setSilverRuneLvl('rune_lvl1');
    }
    else if(val == "2")
    {
        theGame.getWolvenTrainer().setSilverRuneLvl('rune_lvl2');
    }
    else if(val == "3")
    {
        theGame.getWolvenTrainer().setSilverRuneLvl('rune_lvl3');
    }

}

exec function wolven_setSilverRuneType(val : string)
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(val == "Inherit")
    {
        theGame.getWolvenTrainer().setSilverRuneType('none');
    }
    else if(val == "Stribog")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_stribog');
    }
    else if(val == "Dazhbog")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_dazhbog');
    }
    else if(val == "Devana")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_devana');
    }
    else if(val == "Zoria")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_zoria');
    }
    else if(val == "Morana")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_morana');
    }
    else if(val == "Triglav")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_triglav');
    }
    else if(val == "Svarog")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_svarog');
    }
    else if(val == "Veles")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_veles');
    }
    else if(val == "Perun")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_perun');
    }
    else if(val == "Elemental")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_elemental');
    }
    else if(val == "Pierog")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_pierog');
    }
    else if(val == "Tvarog")
    {
        theGame.getWolvenTrainer().setSilverRuneType('rune_tvarog');
    }
    else if(val == "Replenishment")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_replenishment');
    }
    else if(val == "Severance")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_severance');
    }
    else if(val == "Invigoration")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_invigoration');
    }
    else if(val == "Preservation")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_preservation');
    }
    else if(val == "Dumplings")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_dumplings');
    }
    else if(val == "Exhaustion")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_exhaustion');
    }
    else if(val == "Placation")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_placation');
    }
    else if(val == "Rejuvenation")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_rejuvenation');
    }
    else if(val == "Prolongation")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_prolongation');
    }
    else if(val == "Elation")
    {
        theGame.getWolvenTrainer().setSilverRuneType('runeword_elation');
    }

}

exec function wolven_toggleSilverRuneGlow()
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(!theGame.getWolvenTrainer().getSilverRuneGlow())
    {
        theGame.getWolvenTrainer().setSilverRuneGlow(true);
    }
    else
    {
        theGame.getWolvenTrainer().setSilverRuneGlow(false);
    }
}

exec function wolven_setSilverOilType(val : string)
{
    theGame.getWolvenTrainer().StopSwordFX();

    if(val == "Inherit")
    {
        theGame.getWolvenTrainer().setSilverOilType('none');
    }
    else if(val == "None")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_none');
    }
    else if(val == "Beast")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_beast');
    }
    else if(val == "Cursed")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_cursed');
    }
    else if(val == "Venom")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_venom');
    }
    else if(val == "Hybrid")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_hybrid');
    }
    else if(val == "Insectoid")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_insectoid');
    }
    else if(val == "Magical")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_magical');
    }
    else if(val == "Necrophage")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_necrophage');
    }
    else if(val == "Specter")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_specter');
    }
    else if(val == "Vampire")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_vampire');
    }
    else if(val == "Draconide")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_draconide');
    }
    else if(val == "Ogre")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_ogre');
    }
    else if(val == "Relic")
    {
        theGame.getWolvenTrainer().setSilverOilType('oil_relic');
    }
}

exec function wolven_toggleHideCrossbow()
{
    if(!theGame.getWolvenTrainer().getHideCrossbow())
    {
        theGame.getWolvenTrainer().setHideCrossbow(true);
    }
    else
    {
        theGame.getWolvenTrainer().setHideCrossbow(false);
    }

    theGame.getWolvenTrainer().refreshCrossbow();
}

exec function wolven_toggleAutoTeleportToWaypoint()
{
    if(!theGame.getWolvenTrainer().getAutoTeleportToWaypoint())
    {
        theGame.getWolvenTrainer().setAutoTeleportToWaypoint(true);
    }
    else
    {
        theGame.getWolvenTrainer().setAutoTeleportToWaypoint(false);
    }
}

exec function wolven_teleportToPin()
{
    theGame.getWolvenTrainer().pinTeleportInternal();
}
exec function wolven_removePin()
{
    theGame.getWolvenTrainer().removePin();
}

exec function wolven_saveCustomPin()
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
        
        LogChannel('WOLVEN TRAINER', "SAVE PIN|" +destWorldPath+ " " +position.X+ " "+position.Y);
        if (destWorldPath == currWorld.GetPath() )
        {
            goToCurrent = true;
        }
        else
        {
            goToOther = true;
        }

        GetWitcherPlayer().DisplayHudMessage("Custom location saved!");
    }
    else
    {
        GetWitcherPlayer().DisplayHudMessage("No map marker to save!");
    }
}

exec function wolven_customTeleportToPin(level : string, x : float, y : float)
{
    theGame.getWolvenTrainer().customPinTeleportInternal(level, x, y);
}

exec function wolven_customFastTravel(destinationArea : int, destinationPinTag : name)
{
    var mapManager : CCommonMapManager = theGame.GetCommonMapManager();

    mapManager.PerformGlobalFastTravelTeleport(destinationArea, destinationPinTag);
}

exec function wolven_tpIsleOfMists()
{
	theGame.ScheduleWorldChangeToPosition( "levels\island_of_mist\island_of_mist.w2w", Vector( -10, 298, 0.567852 ), EulerAngles( 0, 225, 0 ) );
}

exec function wolven_tpDesert()
{
    theGame.ScheduleWorldChangeToPosition( "levels\the_spiral\spiral.w2w", Vector( -1458, -2545, 173.071518 ), EulerAngles( 0, 110, 0 ) );
    theGame.RequestAutoSave( "fast travel", true );
}

exec function wolven_tpToxicValley()
{
    theGame.ScheduleWorldChangeToPosition( "levels\the_spiral\spiral.w2w", Vector( -676, -2164, 95.645988 ), EulerAngles( 0, 70, 0 ) );
    theGame.RequestAutoSave( "fast travel", true );
}

exec function wolven_tpUnderwaterRuins()
{
    theGame.ScheduleWorldChangeToPosition( "levels\the_spiral\spiral.w2w", Vector( 1020, -3621, 414 ), EulerAngles( 0, 180, 0 ) );
    theGame.RequestAutoSave( "fast travel", true );
}

exec function wolven_tpEternalCold()
{
    theGame.ScheduleWorldChangeToPosition( "levels\the_spiral\spiral.w2w", Vector( 1088.5, -3615.5, 418.931732 ), EulerAngles( 0, 10, 0 ) );
    theGame.RequestAutoSave( "fast travel", true );
}

exec function wolven_tpAenElle()
{
    theGame.ScheduleWorldChangeToPosition( "levels\the_spiral\spiral.w2w", Vector( 1448, -1140, 117.7845 ), EulerAngles( 0, 0, 0 ) );
    theGame.RequestAutoSave( "fast travel", true );
}

exec function wolven_tpMirrorsPalace()
{
	if ( theGame.GetDLCManager().IsDLCAvailable( 'ep1' ) )
	{
        theGame.ScheduleWorldChangeToPosition( "levels\novigrad\novigrad.w2w", Vector( 3664.104248, -222.233139, 25.085951 ), EulerAngles( 0, 275, 0 ) );
        theGame.RequestAutoSave( "fast travel", true );
	}
	else
	{
		GetWitcherPlayer().DisplayHudMessage( "Missing DLC: Hearts of Stone" );
	}
}

exec function wolven_tpKiera()
{
    theGame.ScheduleWorldChangeToPosition( "levels\novigrad\novigrad.w2w", Vector( -291.575226, -36.957623, -28.204578 ), EulerAngles( 0, 275, 0 ) );
    theGame.RequestAutoSave( "fast travel", true );
}

exec function wolven_tpRumination()
{
	if ( theGame.GetDLCManager().IsDLCAvailable( 'ep1' ) )
	{
        theGame.ScheduleWorldChangeToPosition( "levels\novigrad\novigrad.w2w", Vector( 3546.905029, -279.862335, 18.604111 ), EulerAngles( 0, 0, 0 ) );
        theGame.RequestAutoSave( "fast travel", true );
	}
	else
	{
		GetWitcherPlayer().DisplayHudMessage( "Missing DLC: Hearts of Stone" );
	}
}

exec function wolven_tpWinterWhiteOrchard()
{
    theGame.ScheduleWorldChangeToPosition( "levels\prolog_village_winter\prolog_village.w2w", Vector( 54.076550, -5.429935, 2.302898 ), EulerAngles( 0, 250, 0 ) );
	theGame.RequestAutoSave( "fast travel", true );
}

exec function wolven_tpFable()
{
	if ( theGame.GetDLCManager().IsDLCAvailable( 'abob_001_001' ) )
	{
        theGame.ScheduleWorldChangeToPosition( "dlc\bob\data\levels\bob\bob.w2w", Vector( 2850.145020, 1220.098511, 177.583939 ), EulerAngles( 0, 70, 0 ) );
        theGame.RequestAutoSave( "fast travel", true );
	}
	else
	{
		GetWitcherPlayer().DisplayHudMessage( "Missing DLC: Blood & Wine" );
	}
}

exec function wolven_tpUnseen()
{
	var levelName 	: string;
	var pos			: Vector;
	
	if ( theGame.GetDLCManager().IsDLCAvailable( 'abob_001_001' ) )
	{
        theGame.ScheduleWorldChangeToPosition( "dlc\bob\data\levels\bob\bob.w2w", Vector( -655, -1888.255371, 86.149460 ), EulerAngles( 0, 150, 0 ) );
        theGame.RequestAutoSave( "fast travel", true );
	}
	else
	{
		GetWitcherPlayer().DisplayHudMessage( "Missing DLC: Blood & Wine" );
	}
}

exec function wolven_tpCDPTeam()
{
	if ( theGame.GetDLCManager().IsDLCAvailable( 'abob_001_001' ) )
	{
        theGame.ScheduleWorldChangeToPosition( "dlc\bob\data\levels\bob\bob.w2w", Vector( -2863.538574, -3318.138672, 1504.136475 ), EulerAngles( 0, 220, 0 ) );
        theGame.RequestAutoSave( "fast travel", true );
		
	}
	else
	{
		GetWitcherPlayer().DisplayHudMessage( "Missing DLC: Blood & Wine" );
	}
}

exec function wolven_spawn(path : string, appearance : name, isCompanion : bool, isHostile : bool, isInvinicible : bool, scale : float, level : int, quantity : int)
{
	var npc	: CNewNPC;
	var pos, cameraDir, player, posFin, normal, posTemp : Vector;
	var rot : EulerAngles;
	var i, sign : int;
	var s,r,x,y : float;
    var testcomp : CComponent;

	rot = thePlayer.GetWorldRotation();

    cameraDir = theCamera.GetCameraDirection();
	
	cameraDir.X *= 3;	
	cameraDir.Y *= 3;
	
	player = thePlayer.GetWorldPosition();
	
	pos = cameraDir + player;	
	pos.Z = player.Z;
	
	posFin.Z = pos.Z;			
	s = quantity / 0.2;			
	r = SqrtF(s/Pi());
    
	for(i=0; i<quantity; i+=1)
	{		
		x = RandF() * r;			
		y = RandF() * (r - x);		
		
		if(RandRange(2))					
			sign = 1;
		else
			sign = -1;
			
		posFin.X = pos.X + sign * x;	
		
		if(RandRange(2))					
			sign = 1;
		else
			sign = -1;
			
		posFin.Y = pos.Y + sign * y;

        if(theGame.GetWorld().StaticTrace( posFin + Vector(0,0,5), posFin - Vector(0,0,5), posTemp, normal ))
        {
            posFin = posTemp;
        }

        npc = (CNewNPC)theGame.CreateEntity((CEntityTemplate)LoadResource(path, true ), posFin, rot, true, true, false, PM_DontPersist );
        npc.AddTag('WolvenTrainerEntity');

        if(isCompanion)
        {
            npc.AddTag('WolvenTrainerCompanion');
            npc.AddTag(theGame.params.TAG_NPC_IN_PARTY);
            npc.SetTemporaryAttitudeGroup( 'friendly_to_player', AGP_Default );	

            npc.SetNPCType(ENGT_Quest);
            npc.SetAttitude(thePlayer, AIA_Friendly);
            ((CActor)npc).GetComponent('talk').SetEnabled(true);
            
            npc.RemoveTag('no_talk');
            npc.DisableTalking(false, false);
            npc.SetOriginalInteractionPriority(IP_Prio_1);
            npc.RestoreOriginalInteractionPriority();

            theGame.getWolvenTrainer().addAbility(npc, '_canBeFollower');
            theGame.getWolvenTrainer().addAbility(npc, 'Ciri_CombatRegen');
            theGame.getWolvenTrainer().addAbility(npc, 'all_NPC_ability');
            theGame.getWolvenTrainer().addAbility(npc, 'difficulty_CommonHard');
            theGame.getWolvenTrainer().addAbility(npc, 'ConDefault');
            theGame.getWolvenTrainer().addAbility(npc, 'ablParryHeavyAttacks');
            theGame.getWolvenTrainer().addAbility(npc, 'ablComboAttacks');
            theGame.getWolvenTrainer().addAbility(npc, 'IsNotScaredOfMonsters'); 
        }

        if(isInvinicible)
        {
            ((CActor)npc).SetImmortalityMode( AIM_Invulnerable, AIC_Default, true );
        }

        if( isHostile || GetAttitudeBetween(thePlayer, npc) == AIA_Hostile)
        {
            npc.AddTag('WolvenTrainerHostile');
            ((CActor)npc).SetTemporaryAttitudeGroup( 'hostile_to_player', AGP_Default );
        }
            
        if ( level != 0 )
        {
            npc.SetLevel( level );
        }

        if( scale != 1)
        {
            testcomp = npc.GetComponentByClassName('CAnimatedComponent');
            testcomp.SetScale(Vector(scale, scale, scale, 1));
        }

        if(appearance != 'Default')
        {
            npc.ApplyAppearance(appearance);
        }
    }
}

exec function wolven_printEntitySettings(path : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var list : string;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == path)
        {
            if(l_actors[i].HasTag('WolvenTrainerCompanion'))
            {
                list += "companion ";
            }
            if(l_actors[i].HasTag('WolvenTrainerHostile') || GetAttitudeBetween(thePlayer, l_actors[i]) == AIA_Hostile)
            {
                list += "hostile ";
            }
            if(l_actors[i].IsInvulnerable())
            {
                list += "invincible ";
            }
            LogChannel('WOLVEN TRAINER', "ENTITY SETTINGS|"+list);
            return;
        }
    }
}

exec function wolven_toggleEntityCompanion(path : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var npc : CNewNPC;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == path)
        {
            npc = ((CNewNPC)l_actors[i]);
            if(npc.HasTag('WolvenTrainerCompanion'))
            {
                npc.RemoveTag('WolvenTrainerCompanion');
                npc.RemoveTag(theGame.params.TAG_NPC_IN_PARTY);
                npc.WolvenStopFollowing();
                npc.ResetAttitude(thePlayer);
                npc.GetMovingAgentComponent().ForceSetRelativeMoveSpeed( 0 );
				npc.GetMovingAgentComponent().SetGameplayRelativeMoveSpeed( 0 );
            }
            else
            {
                npc.AddTag('WolvenTrainerCompanion');
                npc.AddTag(theGame.params.TAG_NPC_IN_PARTY);
                npc.SetTemporaryAttitudeGroup( 'friendly_to_player', AGP_Default );	

                npc.SetNPCType(ENGT_Quest);
                npc.SetAttitude(thePlayer, AIA_Friendly);
                ((CActor)l_actors[i]).GetComponent('talk').SetEnabled(true);
                
                npc.RemoveTag('no_talk');
                npc.DisableTalking(false, false);
                npc.SetOriginalInteractionPriority(IP_Prio_1);
                npc.RestoreOriginalInteractionPriority();

                theGame.getWolvenTrainer().addAbility(npc, '_canBeFollower');
                theGame.getWolvenTrainer().addAbility(npc, 'Ciri_CombatRegen');
                theGame.getWolvenTrainer().addAbility(npc, 'all_NPC_ability');
                theGame.getWolvenTrainer().addAbility(npc, 'difficulty_CommonHard');
                theGame.getWolvenTrainer().addAbility(npc, 'ConDefault');
                theGame.getWolvenTrainer().addAbility(npc, 'ablParryHeavyAttacks');
                theGame.getWolvenTrainer().addAbility(npc, 'ablComboAttacks');
                theGame.getWolvenTrainer().addAbility(npc, 'IsNotScaredOfMonsters'); 
            }
            return;
        }
    }
}

exec function wolven_toggleEntityHostile(path : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var npc : CNewNPC;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == path)
        {
            npc = ((CNewNPC)l_actors[i]);
            if(npc.HasTag('WolvenTrainerHostile') || GetAttitudeBetween(thePlayer, l_actors[i]) == AIA_Hostile)
            {
                npc.RemoveTag('WolvenTrainerHostile');
                ((CActor)npc).SetTemporaryAttitudeGroup( 'friendly_to_player', AGP_Default );
            }
            else
            {
                npc.AddTag('WolvenTrainerHostile');
                ((CActor)npc).SetTemporaryAttitudeGroup( 'hostile_to_player', AGP_Default );
            }
            return;
        }
    }
}

exec function wolven_toggleEntityInvincible(path : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var npc : CNewNPC;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == path)
        {
            npc = ((CNewNPC)l_actors[i]);

            if(npc.IsInvulnerable())
            {
                npc.SetImmortalityMode( AIM_None, AIC_Default, true ); 
            }
            else
            {
                npc.SetImmortalityMode( AIM_Invulnerable, AIC_Default, true ); 
            }
            return;
        }
    }
}

exec function wolven_setEntityScale(path : string, scale : float)
{
    var l_actors		: array<CActor>;
    var i : int;
    var npc : CNewNPC;
    var actor : string;
    var comp : CComponent;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == path)
        {
            npc = ((CNewNPC)l_actors[i]);

            comp = npc.GetComponentByClassName('CAnimatedComponent');
            comp.SetScale(Vector(scale, scale, scale, 1));
            return;
        }
    }
}

exec function wolven_setEntityLevel(path : string, level : int)
{
    var l_actors		: array<CActor>;
    var i : int;
    var npc : CNewNPC;
    var actor : string;
    var comp : CComponent;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == path)
        {
            npc = ((CNewNPC)l_actors[i]);
            npc.SetLevel(level);
            return;
        }
    }
}

exec function wolven_healEntity(path : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var npc : CNewNPC;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == path)
        {
            npc = ((CNewNPC)l_actors[i]);
            npc.SetHealthPerc(100);
            return;
        }
    }
}

exec function wolven_printEntityManager(global : bool)
{
    var l_actors		: array<CActor>;
    var i : int;
    var list : string;
    var actor : string;
    
    if(!global)
    {
        theGame.GetActorsByTag('WolvenTrainerEntity', l_actors);
    }
    else
    {
        l_actors = GetActorsInRange( thePlayer, 10000, 101, , true );
    }

    LogChannel('WOLVEN TRAINER', "actSize: " + l_actors.Size());

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        if(l_actors[i] == thePlayer || !l_actors[i].IsAlive())
            continue;
        
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(StrContains(actor, "::") || StrContains(actor, "CLayer"))
            continue;

        list += actor + " ";

        if(l_actors[i].GetDisplayName() != "")
        {
            theGame.getWolvenTrainer().wolven_addEntityInfo(l_actors[i].GetDisplayName(), l_actors[i]);
        }
        else
        {
            theGame.getWolvenTrainer().wolven_addEntityInfo(actor, l_actors[i]);
        }
    }

    LogChannel('WOLVEN TRAINER', "ENTITY MANAGER|" + list);
}

exec function wolven_tpEntityToMe(entity : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var list : string;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == entity)
        {
            l_actors[i].TeleportWithRotation(thePlayer.GetWorldPosition(), thePlayer.GetWorldRotation());
            return;
        }
    }
}

exec function wolven_tpToEntity(entity : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var list : string;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );
    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == entity)
        {
            thePlayer.TeleportWithRotation(l_actors[i].GetWorldPosition(), l_actors[i].GetWorldRotation());
            return;
        }
    }
}

exec function wolven_destroyEntity(entity : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var list : string;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == entity)
        {
            l_actors[i].Destroy();
            return;
        }
    }
}

exec function wolven_killEntity(entity : string)
{
    var l_actors		: array<CActor>;
    var i : int;
    var list : string;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == entity)
        {
            l_actors[i].Kill('WolvenTrainer', true);
            return;
        }
    }
}

exec function wolven_untuckHair()
{
    var inv : CInventoryComponent;
    var ids : array<SItemUniqueId>;
    var i : int;
    var hairName : name;
    var l_comp : CComponent;
    var temp : CEntityTemplate;
    inv = thePlayer.GetInventory();
    l_comp = thePlayer.GetComponentByClassName( 'CAppearanceComponent' );
    ids = inv.GetItemsByCategory('hair');
    
    for(i = 0; i < ids.Size(); i+=1)
    {
        if(inv.IsItemMounted(ids[i]))
        {
            hairName = inv.GetItemName(ids[i]);

            if(hairName == 'Half With Tail Hairstyle')
            {
				inv.DespawnItem(ids[i]);
                theGame.getWolvenTrainer().enableNoHairTuck();
                theGame.getWolvenTrainer().ApplyNoHairTuck("items\bodyparts\geralt_items\coif\c_01a_mg__witcher.w2ent");
            }
            else if(hairName == 'Long Loose Hairstyle')
            {
				inv.DespawnItem(ids[i]);
                theGame.getWolvenTrainer().enableNoHairTuck();
                theGame.getWolvenTrainer().ApplyNoHairTuck("items\bodyparts\geralt_items\coif\c_03_mg__witcher.w2ent");
            }

            return;
        }
    }
}

exec function wolven_tuckHair()
{
    var inv : CInventoryComponent;
    var ids : array<SItemUniqueId>;
    var i : int;
    var hairName : name;
    var l_comp : CComponent;
    var temp : CEntityTemplate;
    inv = thePlayer.GetInventory();
    l_comp = thePlayer.GetComponentByClassName( 'CAppearanceComponent' );
    ids = inv.GetItemsByCategory('hair');
    
    for(i = 0; i < ids.Size(); i+=1)
    {
        if(inv.IsItemMounted(ids[i]))
        {
            hairName = inv.GetItemName(ids[i]);

            if(hairName == 'Half With Tail Hairstyle')
            {
				inv.DespawnItem(ids[i]);
                theGame.getWolvenTrainer().enableNoHairTuck();
                theGame.getWolvenTrainer().ApplyNoHairTuck("items\bodyparts\geralt_items\coif\c_01_mg__witcher_br02.w2ent");
            }
            else if(hairName == 'Long Loose Hairstyle')
            {
				inv.DespawnItem(ids[i]);
                theGame.getWolvenTrainer().enableNoHairTuck();
                theGame.getWolvenTrainer().ApplyNoHairTuck("items\bodyparts\geralt_items\coif\c_03_mg__witcher_br.w2ent");
            }

            return;
        }
    }
}

exec function wolven_changeEntityAppearance(entity : string, appearance : name)
{
    var l_actors		: array<CActor>;
    var i : int;
    var list : string;
    var actor : string;

    l_actors = GetActorsInRange( thePlayer, 10000, 99, , true );

    for	( i = 0; i < l_actors.Size(); i+= 1 )
    {
        actor = l_actors[i];

        actor = StrReplace(actor, "Unnamed CDynamicLayer::", "");

        if(actor == entity)
        {
            l_actors[i].ApplyAppearance(appearance);
            return;
        }
    }
}

exec function wolven_execspawn(nam : name, optional quantity : int, optional distance : float, optional isHostile : bool, optional level : int )
{
	var ent : CEntity;
	var horse : CEntity;
	var pos, cameraDir, player, posFin, normal, posTemp : Vector;
	var rot : EulerAngles;
	var i, sign : int;
	var s,r,x,y : float;
	var template : CEntityTemplate;
	var horseTemplate : CEntityTemplate;
	var horseTag : array<name>;
	var resourcePath	: string;
	var l_aiTree		: CAIHorseDoNothingAction;
	var templateCSV : C2dArray;
	quantity = Max(quantity, 1);
	
	rot = thePlayer.GetWorldRotation();	
	if(nam != 'boat')
	{
		rot.Yaw += 180;		
	}
	
	
	cameraDir = theCamera.GetCameraDirection();
	
	if( distance == 0 ) distance = 3; 
	cameraDir.X *= distance;	
	cameraDir.Y *= distance;
	
	
	player = thePlayer.GetWorldPosition();
	
	
	pos = cameraDir + player;	
	pos.Z = player.Z;
	
	
	posFin.Z = pos.Z;			
	s = quantity / 0.2;			
	r = SqrtF(s/Pi());
	
	
	template = (CEntityTemplate)LoadResource(nam);
	
	if ( nam == 'rider' ) 
		horseTemplate = (CEntityTemplate)LoadResource('horse');
		
	if(!template)
	{
		resourcePath = "characters\npc_entities\monsters";
		resourcePath = resourcePath + NameToString(nam);
		resourcePath = resourcePath + ".w2ent";
		template = (CEntityTemplate)LoadResource( resourcePath, true );
	}
	
	if( nam == 'def' )
	{
		templateCSV = LoadCSV("gameplay\globals\temp_spawner.csv");
		
		resourcePath = templateCSV.GetValueAt(0,0);
		template = (CEntityTemplate)LoadResource( resourcePath, true );
	}

	for(i=0; i<quantity; i+=1)
	{		
		x = RandF() * r;			
		y = RandF() * (r - x);		
		
		if(RandRange(2))					
			sign = 1;
		else
			sign = -1;
			
		posFin.X = pos.X + sign * x;	
		
		if(RandRange(2))					
			sign = 1;
		else
			sign = -1;
			
		posFin.Y = pos.Y + sign * y;	
		
		if(nam == 'boat')
		{
			posFin.Z = 0.0f;
		}
		else
		{
			if(theGame.GetWorld().StaticTrace( posFin + Vector(0,0,5), posFin - Vector(0,0,5), posTemp, normal ))
			{
				posFin = posTemp;
			}
		}
		
		if( nam == 'boat' )
		{
			ent = theGame.CreateEntity(template, posFin, rot, true, false, false, PM_Persist );
		}
		else
		{
			ent = theGame.CreateEntity(template, posFin, rot);
		}
		
		if ( horseTemplate )
		{
			horseTag.PushBack('enemy_horse');
			horse = theGame.CreateEntity(horseTemplate, posFin, rot,true,false,false,PM_DontPersist,horseTag);
			
			
			
			
			l_aiTree = new CAIHorseDoNothingAction in ent;
			l_aiTree.OnCreated();
			((CActor)ent).ForceAIBehavior( l_aiTree, BTAP_AboveEmergency2, 'AI_Rider_Load_Forced' );
			
			((CActor)ent).SignalGameplayEventParamInt( 'RidingManagerMountHorse', MT_instant | MT_fromScript );
		}
			
		if( isHostile )
		{
			((CActor)ent).SetTemporaryAttitudeGroup( 'hostile_to_player', AGP_Default );
		}
			
		if ( level != 0 )
		{
			((CNewNPC)ent).SetLevel( level );
		}

        ent.AddTag('WolvenTrainerEntity');
	}

}

exec function wolven_hideEntityInfo()
{
    var manager : SUOL_Manager;
    var oneliners : array<SU_Oneliner>;
    var i : int;
    manager = thePlayer.getSharedutilsOnelinersManager();
    oneliners = manager.findByTag("WolvenTrainer");
    
    LogChannel('WOLVEN TRAINER', "Liners size: " + oneliners.Size());

    for(i = 0; i < oneliners.Size(); i+=1)
    {
        oneliners[i].unregister();
    }
}

exec function wolven_printTimeInfo()
{
    var day : int;
    var hour : int;
    var minute : int;
    var second : int;
    
    day = GameTimeDays(theGame.GetGameTime());
    hour = GameTimeHours(theGame.GetGameTime());
    minute = GameTimeMinutes(theGame.GetGameTime());
    second = GameTimeSeconds(theGame.GetGameTime());

    LogChannel('WOLVEN TRAINER', "GAME TIME|"+hour+ " " +minute+ " " +second+ " " +day);
}

exec function wolven_setDay(day : int)
{
	var newTime : GameTime;
	newTime = GameTimeCreate(day, GameTimeHours(theGame.GetGameTime()), GameTimeMinutes(theGame.GetGameTime()), GameTimeSeconds(theGame.GetGameTime()) );
	theGame.SetGameTime( newTime, true );
}

exec function wolven_setHour(hour : int)
{
	var newTime : GameTime;
	newTime = GameTimeCreate(GameTimeDays(theGame.GetGameTime()), hour, GameTimeMinutes(theGame.GetGameTime()), GameTimeSeconds(theGame.GetGameTime()) );
	theGame.SetGameTime( newTime, true );
}

exec function wolven_setMinutes(minutes : int)
{
	var newTime : GameTime;
	newTime = GameTimeCreate(GameTimeDays(theGame.GetGameTime()), GameTimeHours(theGame.GetGameTime()), minutes, GameTimeSeconds(theGame.GetGameTime()) );
	theGame.SetGameTime( newTime, true );
}

exec function wolven_setSeconds(seconds : int)
{
	var newTime : GameTime;
	newTime = GameTimeCreate(GameTimeDays(theGame.GetGameTime()), GameTimeHours(theGame.GetGameTime()), GameTimeMinutes(theGame.GetGameTime()), seconds );
	theGame.SetGameTime( newTime, true );
}

exec function wolven_toggleFreezeTime()
{
    if(!theGame.getWolvenTrainer().getFreezeTime())
    {
        theGame.getWolvenTrainer().setFreezeTime(true);
        theGame.getWolvenTrainer().setStoredHoursPerMinute(theGame.GetHoursPerMinute());
        theGame.SetHoursPerMinute(0);
    }
    else
    {
        theGame.getWolvenTrainer().setFreezeTime(false);
        theGame.SetHoursPerMinute(theGame.getWolvenTrainer().getStoredHoursPerMinute());
    }
}

exec function wolven_setTimeCycle(speed : float)
{
    if(!theGame.getWolvenTrainer().getFreezeTime())
    {
        theGame.SetHoursPerMinute(speed);
    }

    theGame.getWolvenTrainer().setStoredHoursPerMinute(speed);
}

exec function wolven_wait(days : int, optional hours : int, optional minutes : int, optional seconds : int )
{
	theGame.SetGameTime( theGame.GetGameTime() + GameTimeCreate(days, hours, minutes, seconds), true);
    theSound.SoundEvent("gui_alchemy_brew");
	thePlayer.inv.SingletonItemsRefillAmmoNoAlco(true);
}

exec function wolven_gameTime(factor : float)
{
    if(factor == 1)
    {
        theGame.RemoveTimeScale('WolvenTrainer');
    }
    else
    {
        theGame.SetTimeScale(factor, 'WolvenTrainer', 30, true );
    }
}

exec function wolven_setWeather(type : name)
{
    RequestWeatherChangeTo(type, 1.0, false);
}

exec function wolven_printArea()
{
    var area : EAreaName;
	area = theGame.GetCommonMapManager().GetCurrentArea();

    LogChannel('WOLVEN TRAINER', "AREA|" +area);
}

exec function wolven_toggleNoBorders()
{
    if(!theGame.getWolvenTrainer().getNoBorders())
    {
        theGame.getWolvenTrainer().setNoBorders(true);
    }
    else
    {
        theGame.getWolvenTrainer().setNoBorders(false);
    }
}

exec function wolven_toggleUnsinkable()
{
    if(!theGame.getWolvenTrainer().getUnsinkable())
    {
        theGame.getWolvenTrainer().setUnsinkable(true);
    }
    else
    {
        theGame.getWolvenTrainer().setUnsinkable(false);
    }
}

exec function wolven_repairBoat()
{
	var boat : W3Boat;
	var destruction : CBoatDestructionComponent;
	var boatPos : Vector;
	var i : int;
	
	boat = NULL;
	destruction = NULL;
	
	boat = (W3Boat)thePlayer.GetUsedVehicle();
	
	if( boat )
	{
		destruction = (CBoatDestructionComponent)boat.GetComponentByClassName('CBoatDestructionComponent');
	
		if( destruction )
		{
            destruction.wolven_repairBoatInternal();
		}
	}	
}

exec function wolven_spawnBoatAndMount()
{
	var entities : array<CGameplayEntity>;
	var vehicle : CVehicleComponent;
	var i : int;
	var boat : W3Boat;
	var ent : CEntity;
	var player : Vector;
	var rot : EulerAngles;
	var template : CEntityTemplate;

    if((W3Boat)thePlayer.GetUsedVehicle())
    {
        GetWitcherPlayer().DisplayHudMessage("You are already riding a boat!");
        return;
    }
	
	rot = thePlayer.GetWorldRotation();	
	player = thePlayer.GetWorldPosition();
	template = (CEntityTemplate)LoadResource( 'boat' );
	player.Z = 0.0f;

	ent = theGame.CreateEntity(template, player, rot, true, false, false, PM_Persist );

	if( ent )
	{
		vehicle = ( CVehicleComponent )( ent.GetComponentByClassName( 'CVehicleComponent' ) );
		if ( vehicle )
		{
			vehicle.Mount( thePlayer, VMT_ImmediateUse, EVS_driver_slot );
		}
	}
}

exec function wolven_toggleFastBoat()
{
    if(!theGame.getWolvenTrainer().getCustomBoatSpeed())
    {
        theGame.getWolvenTrainer().setCustomBoatSpeed(true);
    }
    else
    {
        theGame.getWolvenTrainer().setCustomBoatSpeed(false);
    }
}

exec function wolven_flood()
{
    var i : int;
    for(i = 0; i < 20000; i+=1)
    {
        LogChannel('WOLVEN', "Flood");
    }
}

exec function wolven_flood2()
{
    var i : int;
    for(i = 0; i < 10000; i+=1)
    {
        LogChannel('WOLVEN', "Flood");
    }
}

exec function wolven_printData()
{
    var list : string;
    var playerPos : Vector;
    var area : EAreaName;
    var rot : EulerAngles;
    var gameTime		: GameTime;
	var gameTimeHours	: string;
    var gameTimeMinutes : string;
    var valueStr 		: string;
	var valueAbility 	: float;
    var curStats:SPlayerOffenseStats;
    var sp 				: SAbilityAttributeValue;
    var temp			: bool;
    var theHorse : CNewNPC;
	var item : SItemUniqueId;
	var horseMan : W3HorseManager;
    var dm : CDefinitionsManagerAccessor;
    var curGameTime : GameTime;
    var currentDayPart:EDayPart;
    var currentWeatherEffect:EWeatherEffect;
    var currentMoonState:EMoonState;
    var trophy : string;
    var cleanedTrophy : string;
    var tempTrophy : string;

    if(!thePlayer)
    {
        return;
    }

    dm = theGame.GetDefinitionsManager();
    curStats = GetWitcherPlayer().GetOffenseStatsList();
	area = theGame.GetCommonMapManager().GetCurrentArea();
    playerPos = thePlayer.GetWorldPosition();
    rot = thePlayer.GetWorldRotation();	

    list += playerPos.X;
    list += " ";

    list += playerPos.Y;
    list += " ";

    list += playerPos.Z;
    list += " ";

    list += thePlayer.GetMovingAgentComponent().GetSpeed();
    list += " ";

    list += area;
    list += " ";

    list += rot.Pitch;
    list += " ";

    list += rot.Yaw;
    list += " ";

    list += rot.Roll;
    list += " ";

    list += VecHeading(theCamera.GetCameraDirection());
    list += " ";

    list += NoTrailZeros(RoundMath(thePlayer.GetStat(BCS_Vitality)));
    list += " ";

    list += NoTrailZeros(RoundMath(thePlayer.GetStat(BCS_Toxicity)));
    list += "% ";

    sp += GetWitcherPlayer().GetTotalSignSpellPower(S_Magic_1);
    sp += GetWitcherPlayer().GetTotalSignSpellPower(S_Magic_2);
    sp += GetWitcherPlayer().GetTotalSignSpellPower(S_Magic_3);
    sp += GetWitcherPlayer().GetTotalSignSpellPower(S_Magic_4);
    sp += GetWitcherPlayer().GetTotalSignSpellPower(S_Magic_5);
    
    valueAbility = sp.valueMultiplicative / 5 - 1;
    valueStr = "+" + (string)RoundMath(valueAbility * 100) + "%";
    list += valueStr;
    list += " ";

    valueStr = NoTrailZeros(RoundMath((curStats.silverFastDPS+curStats.silverStrongDPS)/2));
    list += valueStr;
    list += " ";

    valueStr = NoTrailZeros(RoundMath((curStats.steelFastDPS+curStats.steelStrongDPS)/2));	
    list += valueStr;
    list += " ";

    list += GetWitcherPlayer().GetLevel();
    list += " ";

    list += thePlayer.inv.GetMoney();
    list += " ";

    gameTime =	theGame.CalculateTimePlayed();
	gameTimeHours = (string)(GameTimeDays(gameTime) * 24 + GameTimeHours(gameTime));
    gameTimeMinutes = (string)GameTimeMinutes(gameTime);
    list += gameTimeHours;
    list += " ";

    valueAbility =  CalculateAttributeValue( GetWitcherPlayer().GetTotalArmor() );
	valueStr = IntToString( RoundMath(  valueAbility ) );
    list += valueStr;
    list += " ";

    list += NoTrailZeros(RoundMath((GetWitcherPlayer().GetEncumbrance())));
    list += "/";
    list += NoTrailZeros(RoundMath((GetWitcherPlayer().GetMaxRunEncumbrance(temp))));
    list += " ";

    list += gameTimeMinutes;
    list += " ";
        
    theHorse = thePlayer.GetHorseWithInventory();
    if(!theHorse ||	!theHorse.IsAlive()) 
    {
        list += "N/A";
        list += " ";
        list += "N/A";
        list += " ";
        list += NoTrailZeros(RoundMath((CalculateAttributeValue(GetWitcherPlayer().GetHorseManager().GetHorseAttributeValue('stamina', false)))));
        list += " ";
    }
    else
    {
        if(VecDistance(thePlayer.GetWorldPosition(), theHorse.GetWorldPosition()) == 0)
        {
            list += "Riding";
            list += " ";
        }
        else
        {
            list += VecDistance(thePlayer.GetWorldPosition(), theHorse.GetWorldPosition());
            list += " ";
        }

        list += theHorse.GetMovingAgentComponent().GetSpeed();
        list += " ";
        list += NoTrailZeros(RoundMath((CalculateAttributeValue(GetWitcherPlayer().GetHorseManager().GetHorseAttributeValue('stamina', false)))));
        list += " ";
    }

    horseMan = GetWitcherPlayer().GetHorseManager();
    item = horseMan.GetItemInSlot(EES_HorseTrophy);

    trophy = GetLocStringByKeyExt(dm.GetItemLocalisationKeyName(horseMan.GetInventoryComponent().GetItemName(item)));
    StrSplitFirst(trophy, " ", cleanedTrophy, tempTrophy);

    if(cleanedTrophy == "")
    {
        list += "None";
    }
    else
    {
        list += cleanedTrophy;
    }
    list += " ";
    
    curGameTime = theGame.GetGameTime();
    currentDayPart = GetDayPart(curGameTime);
    currentWeatherEffect = GetCurWeather();
    currentMoonState = GetCurMoonState();

    if(currentDayPart == EDP_Midnight)
    {
        list += "Midnight";
    }
    else if(currentDayPart == EDP_Dawn)
    {
        list += "Dawn";
    }
    else if(currentDayPart == EDP_Noon)
    {
        list += "Noon";
    }
    else if(currentDayPart == EDP_Dusk)
    {
        list += "Dusk";
    }
    else
    {
        list += "Undefined";
    }
    list += " ";

    if(currentWeatherEffect == EWE_Storm)
    {
        list += "Storm";
    }
    else if(currentWeatherEffect == EWE_Rain)
    {
        list += "Rain";  
    }
    else if(currentWeatherEffect == EWE_Snow)
    {
        list += "Snow";  
    }
    else if(currentWeatherEffect == EWE_Clear)
    {
        list += "Clear";  
    }
    else
    {
        list += "None";  
    }
    list += " ";

    if(currentMoonState == EMS_Red)
    {
        list += "Red";
    }
    else if(currentMoonState == EMS_Full)
    {
        list += "Full";  
    }
    else
    {
        if(theGame.envMgr.IsDay())
        {
            list += "None"; 
        }
        else
        {
            list += "Partial";  
        }
    }
    list += " ";

    LogChannel('WOLVEN TRAINER', "TRAINER DATA|" + list);
}

statemachine class cAsyncUtils 
{
	function PrintAppearances()
	{
		this.PushState('PrintAppearances');
	}
}

state PrintAppearances in cAsyncUtils
{
    event OnEnterState(prevStateName : name)
	{
		LogAppearancesEntry();
	}

    entry function LogAppearancesEntry()
	{
		LogAppearancesLatent();	
	}

    latent function LogAppearancesLatent()
    {
        var names : array<name>;
        var template : CEntityTemplate;
        var i : int;
        var list : string;
        var path : string;
        path = theGame.getWolvenTrainer().getAppearancePath();

        template = (CEntityTemplate)LoadResourceAsync(path, true);

        if(template)
        {
            GetAppearanceNames(template, names);
            for(i = 0; i < names.Size(); i+=1)
            {
                list += names[i] + " ";
            }
            LogChannel('WOLVEN TRAINER', path +"|" + list);
        }
    }
}

exec function wolven_printAppearances(path : string)
{
	var asyncUtils : cAsyncUtils;
	theGame.getWolvenTrainer().setAppearancePath(path);
    asyncUtils = new cAsyncUtils in theGame;
    asyncUtils.PrintAppearances();
}

exec function wolven_healme(optional perc : int)
{
	var max, current : float;

	if(perc <= 0)
		perc = 100;
		
	max = thePlayer.GetStatMax(BCS_Vitality);
	current = thePlayer.GetStat(BCS_Vitality);
	thePlayer.ForceSetStat(BCS_Vitality, MinF(max, current + max * perc / 100));

    theSound.SoundEvent("gui_alchemy_brew");
}

exec function wolven_setFreecamSpeed(val : float)
{
    theGame.getWolvenTrainer().setFreecamSpeed(val);
}

exec function wolven_setFOV(val : float)
{
    theCamera.GetTopmostCamera().SetFov(val);
}

exec function wolven_popup(val : string)
{
    GetWitcherPlayer().DisplayHudMessage(val);
}

exec function wolven_setMenuOpen(val : bool)
{
    theGame.getWolvenTrainer().setMenuOpen(val);
}

exec function wolven_playSpeech(line_id : int)
{
    thePlayer.PlayLine(line_id, false);
}

exec function wolven_startDancing()
{
    thePlayer.PlayerStartAction(1, 'locomotion_salsa_cycle_02');
}

exec function wolven_setTattoo( hasTattoo : bool )
{
	var acs : array< CComponent >;
    var head : name;
	
	acs = thePlayer.GetComponentsByClassName( 'CHeadManagerComponent' );
	( ( CHeadManagerComponent ) acs[0] ).SetTattoo( hasTattoo );
}

exec function wolven_setMark( mark : bool )
{
	var acs : array< CComponent >;
	
	acs = thePlayer.GetComponentsByClassName( 'CHeadManagerComponent' );
	( ( CHeadManagerComponent ) acs[0] ).SetDemonMark( mark );
}

exec function wolven_unlockDoor()
{
    var door  : W3LockableEntity;
    door = (W3LockableEntity)theGame.GetInteractionsManager().GetActiveInteraction().GetEntity();
    door.Unlock();
}

exec function wolven_openStash()
{	theGame.GameplayFactsAdd("stashMode", 1);
	theGame.RequestMenuWithBackground( 'InventoryMenu', 'CommonMenu' );
}

exec function wolven_toggleNoStagger()
{
    if(!theGame.getWolvenTrainer().getNoStagger())
    {
        theGame.getWolvenTrainer().setNoStagger(true);
    }
    else
    {

        theGame.getWolvenTrainer().setNoStagger(false);
    }
}

exec function wolven_toggleNoCrossbowReload()
{
    if(!theGame.getWolvenTrainer().getNoCrossbowReload())
    {
        theGame.getWolvenTrainer().setNoCrossbowReload(true);
    }
    else
    {
        theGame.getWolvenTrainer().setNoCrossbowReload(false);
    }
}

exec function wolven_toggleOilsNeverExpire()
{
    if(!theGame.getWolvenTrainer().getOilsNeverExpire())
    {
        theGame.getWolvenTrainer().setOilsNeverExpire(true);
    }
    else
    {
        theGame.getWolvenTrainer().setOilsNeverExpire(false);
    }
}

exec function wolven_lightUp(val : bool)
{
    var i: int;
    var c	: CGameplayLightComponent;
    var entities	: array<CGameplayEntity>;

    FindGameplayEntitiesInRange( entities, thePlayer, 50, 10000 );
    
    for ( i = 0; i < entities.Size(); i += 1 )
    {
        c = (CGameplayLightComponent)entities[i].GetComponentByClassName('CGameplayLightComponent');
        if ( c && c.IsInteractive() && ( c.IsLightOn() != val ) )
        {
            c.SetLight(val);
        }
    }
}

exec function wolven_toggleFreecam()
{
    if(!theGame.getWolvenTrainer().getFreecam())
    {
        LogChannel('FREECAM ON', "Context: " + theInput.GetContext());
        theGame.getWolvenTrainer().setFreecam(true);
        theGame.getWolvenTrainer().spawnWolvenCamera();
        theGame.getWolvenTrainer().setLastFreecamContext(theInput.GetContext());
        theGame.getWolvenTrainer().setLastFreecamCam(theGame.GetGameCamera());
        theInput.SetContext('Exploration');
        LogChannel('FREECAM ON', "New Context: " + theInput.GetContext());
        thePlayer.BlockAction( EIAB_Crossbow, 			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_CallHorse,			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Signs, 				'WolvenFreecam');
        thePlayer.BlockAction( EIAB_DrawWeapon, 			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_FastTravel, 			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Fists, 				'WolvenFreecam');
        thePlayer.BlockAction( EIAB_InteractionAction, 	'WolvenFreecam');
        thePlayer.BlockAction( EIAB_UsableItem,			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_ThrowBomb,			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_SwordAttack,			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_LightAttacks,			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_HeavyAttacks,			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_SpecialAttackLight,	'WolvenFreecam');
        thePlayer.BlockAction( EIAB_SpecialAttackHeavy,	'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Dodge,				'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Roll,					'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Parry,				'WolvenFreecam');
        thePlayer.BlockAction( EIAB_MeditationWaiting,	'WolvenFreecam');
        thePlayer.BlockAction( EIAB_OpenMeditation,		'WolvenFreecam');
        thePlayer.BlockAction( EIAB_RadialMenu,			'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Movement,				'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Interactions, 		'WolvenFreecam');
        thePlayer.BlockAction( EIAB_Jump, 				'WolvenFreecam');
        thePlayer.BlockAction( EIAB_QuickSlots, 			'WolvenFreecam');
    }
    else
    {
        theGame.getWolvenTrainer().setFreecam(false);
        theGame.getWolvenTrainer().getLastFreecamCam().Activate( 0.0f, false );	
        LogChannel('FREECAM OFF', "Current Context: " + theInput.GetContext());
        theInput.SetContext( theGame.getWolvenTrainer().getLastFreecamContext() );
        LogChannel('FREECAM OFF', "New Context: " + theInput.GetContext());
        thePlayer.UnblockAction( EIAB_Crossbow, 			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_CallHorse,			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Signs, 				'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_DrawWeapon, 			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_FastTravel, 			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Fists, 				'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_InteractionAction, 	'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_UsableItem,			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_ThrowBomb,			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_SwordAttack,			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_LightAttacks,			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_HeavyAttacks,			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_SpecialAttackLight,	'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_SpecialAttackHeavy,	'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Dodge,				'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Roll,					'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Parry,				'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_MeditationWaiting,	'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_OpenMeditation,		'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_RadialMenu,			'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Movement,				'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Interactions, 		'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_Jump, 				'WolvenFreecam');
        thePlayer.UnblockAction( EIAB_QuickSlots, 			'WolvenFreecam');
    }
}

exec function wolven_setFreecamFOV(val : float)
{
    theGame.getWolvenTrainer().setFreecamFOV(val);
}

exec function wolven_setFreecamRoll(val : float)
{
    theGame.getWolvenTrainer().setFreecamRoll(val);
}

exec function wolven_suicide()
{
	var action : W3DamageAction;

	action = new W3DamageAction in theGame.damageMgr;
	action.Initialize(NULL, thePlayer, NULL, 'console', EHRT_Light, CPS_Undefined, false, false, false, false);
	action.AddDamage(theGame.params.DAMAGE_NAME_DIRECT, (thePlayer.GetStatMax( BCS_Vitality )*100)/100);
	
	action.SetSuppressHitSounds(true);
	action.SetHitAnimationPlayType(EAHA_ForceNo);

	
	theGame.damageMgr.ProcessAction(action);
	delete action;
}