// Wolven Trainer by rejuvenate
// https://next.nexusmods.com/profile/rejuvenate7/about-me

@addField(CR4Game) 
var wolvenTrainer: WolvenTrainer;

@addMethod(CR4Game)
public function getWolvenTrainer(): WolvenTrainer {
    if (!this.wolvenTrainer) {
      this.wolvenTrainer = new WolvenTrainer in this;
    }

    return this.wolvenTrainer;
}

@addMethod(CR4Game)
public function newWolvenTrainer() {
    this.wolvenTrainer = new WolvenTrainer in this;
}

@wrapMethod(W3PlayerWitcher)
function OnSpawned(spawnData: SEntitySpawnData) {
    var wolven: WolvenTrainer;

    wolven = theGame.getWolvenTrainer();
    wolven.Init();
    AddTimer('refreshTrainer', 0, true);
    AddTimer('flyEffectTimer', 1, true);

    wrappedMethod(spawnData);
  
}

@addMethod(W3PlayerWitcher) 
timer function refreshTrainer(dt : float, id : int)
{
    theGame.getWolvenTrainer().refresh();
}

@addMethod(W3PlayerWitcher) 
timer function flyEffectTimer(dt : float, id : int)
{
    theGame.getWolvenTrainer().flyEffect();
}

@addMethod(W3PlayerWitcher) 
timer function tpHorse(dt : float, id : int)
{
    theGame.getWolvenTrainer().tpHorse();
    RemoveTimer('tpHorse');
}

@addMethod(W3PlayerWitcher) 
timer function tpToHorse(dt : float, id : int)
{
    theGame.getWolvenTrainer().tpToHorse();
    RemoveTimer('tpToHorse');
}

@addMethod(W3PlayerWitcher) 
timer function delayUnpause(dt : float, id : int)
{
    theGame.getWolvenTrainer().setPaused(false);
    RemoveTimer('delayUnpause');
}

@addField(CPlayer) 
public var playerAnimationSpeedCauserID: int;

@addMethod(CPlayer)
public function wolven_setAnimationSpeedCauserID()
{
    this.playerAnimationSpeedCauserID = thePlayer.SetAnimationSpeedMultiplier( theGame.getWolvenTrainer().getPlayerSpeed(), this.playerAnimationSpeedCauserID);
}

@wrapMethod(CExplorationStateJump) 
function GetProperJumpTypeParameters( prevStateName : name )
{
	var	l_JumpTypeE	: EJumpType;
	
	if(false) 
	{
		wrappedMethod(prevStateName);
	}
	
	l_JumpTypeE	= GetJumpTypeThatShouldPlay( prevStateName );
	
	SetJumpParametersBasedOnType( l_JumpTypeE );
	theGame.getWolvenTrainer().Jump_Extend_Init( l_JumpTypeE );
	
	if( m_UseGenericJumpB )
	{
		if( m_JumpParmsS.m_JumpTypeE	== EJT_Idle || m_JumpParmsS.m_JumpTypeE == EJT_Walk ||  m_JumpParmsS.m_JumpTypeE == EJT_WalkHigh || m_JumpParmsS.m_JumpTypeE == EJT_Run || m_JumpParmsS.m_JumpTypeE == EJT_Sprint )
		{
			l_JumpTypeE					= m_JumpParmsS.m_JumpTypeE;
			m_JumpParmsS				= m_JumpParmsGenericS;
			m_JumpParmsS.m_HorImpulseF	= VecLength( m_ExplorationO.m_OwnerMAC.GetVelocity() );
			m_JumpParmsS.m_JumpTypeE	= l_JumpTypeE;
		}
	}
}

@wrapMethod(CExplorationStateJump) 
function UpdateCameraIfNeeded( out moveData : SCameraMovementData, dt : float ) : bool
{
	if(false) 
	{
		wrappedMethod(moveData, dt);
	}

	if(m_JumpParmsS.m_JumpTypeE == EJT_Vault)
	{
		return true;
	}
	
	if ( !thePlayer.IsCiri() && (theGame.getWolvenTrainer().getSuperJump() || theGame.getWolvenTrainer().getUltraJump()))
	{
		return theGame.getWolvenTrainer().UpdateJumpCamera(moveData,dt);
	}
	else
	{
		return true;
	}
}

@wrapMethod(CExplorationStateManager) 
function UpdateCameraIfNeeded( out moveData : SCameraMovementData, dt : float ) : bool
{
	if ( (theGame.getWolvenTrainer().getFlyMode()))
	{
		return theGame.getWolvenTrainer().UpdateJumpCamera(moveData,dt);
	}
	else
	{
		return wrappedMethod(moveData, dt);
	}
}

@wrapMethod(CR4Player) 
function ApplyFallingDamage(heightDiff : float, optional reducing : bool) : float
{
    if(theGame.getWolvenTrainer().getFallDamage())
    {
        return 0.0f;
    }
    else
    {
        return wrappedMethod(heightDiff, reducing);
    }
}

@wrapMethod(W3PlayerWitcher)
function GetEncumbrance() : float
{
    if(theGame.getWolvenTrainer().getWeightLimit())
    {
        return 0.0f;
    }
    else
    {
        return wrappedMethod();
    }
}

@wrapMethod(W3CraftsmanComponent)
function CalculateCostOfCrafting( craftedItemName : name ) : int
{
    if(theGame.getWolvenTrainer().getNoCrafting())
    {
        return 0;
    }
    else
    {
        return wrappedMethod(craftedItemName);
    }
}

@wrapMethod(W3CraftingManager)
function CanCraftSchematic(schematicName : name, checkMerchant : bool) : ECraftingException
{
    if(theGame.getWolvenTrainer().getNoCrafting())
    {
        return ECE_NoException;
    }
    else
    {
        return wrappedMethod(schematicName, checkMerchant);
    }
}

@wrapMethod(W3CraftingManager)
function Craft(schemName : name, out item : SItemUniqueId) : ECraftingException
{
    var i : int;
    var schem : SCraftingSchematic;

    if(theGame.getWolvenTrainer().getNoCrafting())
    {
        GetSchematic(schemName, schem);

        for(i=0; i<schem.ingredients.Size(); i+=1)
		{
            thePlayer.GetInventory().AddAnItem(schem.ingredients[i].itemName, schem.ingredients[i].quantity);
        }
    }
    
    return wrappedMethod(schemName, item);
}

@wrapMethod(W3AlchemyManager)
function CanCookRecipe(recipeName : name, optional ignorePlayerState:bool) : EAlchemyExceptions
{
    if(theGame.getWolvenTrainer().getNoCrafting())
    {
        return EAE_NoException;
    }
    else
    {
        return wrappedMethod(recipeName, ignorePlayerState);
    }
}

@replaceMethod(W3AlchemyManager)
function CookItem(recipeName : name)
{
    var i, j, quantity, removedIngQuantity, maxAmmo : int;
    var recipe : SAlchemyRecipe;
    var dm : CDefinitionsManagerAccessor;
    var crossbowID, sword : SItemUniqueId; 
    var min, max : SAbilityAttributeValue;
    var uiStateAlchemy : W3TutorialManagerUIHandlerStateAlchemy;
    var uiStateAlchemyMutagens : W3TutorialManagerUIHandlerStateAlchemyMutagens;
    var ids : array<SItemUniqueId>;
    var items, alchIngs  : array<SItemUniqueId>;
    var isPotion, isSingletonItem : bool;
    var witcher : W3PlayerWitcher;
    var equippedOnSlot : EEquipmentSlots;
    var itemName:name;
    
    GetRecipe(recipeName, recipe);
    
    witcher = GetWitcherPlayer(); 
    
    
    equippedOnSlot = EES_InvalidSlot;
    dm = theGame.GetDefinitionsManager();
    dm.GetItemAttributeValueNoRandom(recipe.cookedItemName, true, 'ammo', min, max);
    quantity = (int)CalculateAttributeValue(GetAttributeRandomizedValue(min, max));
    
    if(recipe.cookedItemType == EACIT_Bomb && GetWitcherPlayer().CanUseSkill(S_Alchemy_s08))
        quantity += GetWitcherPlayer().GetSkillLevel(S_Alchemy_s08);
    
    
    isSingletonItem = dm.IsItemSingletonItem(recipe.cookedItemName);
    if(isSingletonItem && thePlayer.inv.GetItemQuantityByName(recipe.cookedItemName) > 0 )
    {
        items = thePlayer.inv.GetItemsByName(recipe.cookedItemName);
        
        if (items.Size() == 1 && thePlayer.inv.ItemHasTag(items[0], 'NoShow'))
        {
            if(!theGame.getWolvenTrainer().getNoCrafting())
            {
                thePlayer.inv.RemoveItemTag(items[i], 'NoShow');
            }
        }
    }
    else
    {
        ids = thePlayer.inv.AddAnItem(recipe.cookedItemName, quantity);
        if(isSingletonItem)
        {
            maxAmmo = thePlayer.inv.SingletonItemGetMaxAmmo(ids[0]);
            for(i=0; i<ids.Size(); i+=1)
                thePlayer.inv.SingletonItemSetAmmo(ids[i], maxAmmo);
        }
    }
    
    
    for(i=0; i<recipe.requiredIngredients.Size(); i+=1)
    {
        itemName = recipe.requiredIngredients[i].itemName;
        
        
        
        if( dm.ItemHasTag( itemName, 'MutagenIngredient' ) )
        {
            if(!theGame.getWolvenTrainer().getNoCrafting())
            {
                thePlayer.inv.RemoveUnusedMutagensCount( itemName, recipe.requiredIngredients[i].quantity);
            }
        }
        else if( dm.IsItemAlchemyItem( itemName ))
        {
            removedIngQuantity = 0;
            alchIngs = thePlayer.inv.GetItemsByName(itemName);
            
            for(j=0; j<alchIngs.Size(); j+=1)
            {
                equippedOnSlot = witcher.GetItemSlot(alchIngs[j]);
                
                if(equippedOnSlot != EES_InvalidSlot)
                {
                    witcher.UnequipItem(alchIngs[j]);
                }
                
                removedIngQuantity += 1;
                if(!theGame.getWolvenTrainer().getNoCrafting())
                {   
                    witcher.inv.RemoveItem(alchIngs[j], 1);
                }
                
                if(removedIngQuantity >= recipe.requiredIngredients[i].quantity)
                    break;
            }
        }
        else
        {
            if(!theGame.getWolvenTrainer().getNoCrafting())
            {
                thePlayer.inv.RemoveItemByName(itemName, recipe.requiredIngredients[i].quantity);
            }
        }
        
        
        if(recipe.cookedItemType == EACIT_Oil && recipe.level > 1 && thePlayer.inv.IsItemOil(ids[0]))
        {
            if( witcher.IsEquippedSwordUpgradedWithOil( false, recipe.requiredIngredients[i].itemName ) )
            {
                sword = thePlayer.GetEquippedSword( false );
                thePlayer.ApplyOil(ids[0], sword);
            }
            else if( witcher.IsEquippedSwordUpgradedWithOil( true, recipe.requiredIngredients[i].itemName ) )
            {
                sword = thePlayer.GetEquippedSword( true );
                thePlayer.ApplyOil(ids[0], sword);
            }
        }
        
    }
    
    RemoveLowerLevelItems(recipe);
    
    if( ids.Size() > 0  && thePlayer.inv.IsItemPotion( ids[0] ) )
    {
        isPotion = true;
    }
    else if( items.Size() > 0  && thePlayer.inv.IsItemPotion( items[0] ) )
    {
        isPotion = true;
    }
    else
    {
        isPotion = false;
    }
    
    if( isPotion )
    {
        theTelemetry.LogWithLabelAndValue( TE_ITEM_COOKED, recipe.cookedItemName, 1 );
    }
    else
    {
        theTelemetry.LogWithLabelAndValue( TE_ITEM_COOKED, recipe.cookedItemName, 0 );
    }
    
    
    if(equippedOnSlot != EES_InvalidSlot)
    {
        witcher.EquipItemInGivenSlot(ids[0], equippedOnSlot, false);
    }
    
    LogAlchemy("Item <<" + recipe.cookedItemName + ">> cooked x" + recipe.cookedItemQuantity);
    
    
    if(ShouldProcessTutorial('TutorialAlchemyCook'))
    {
        uiStateAlchemy = (W3TutorialManagerUIHandlerStateAlchemy)theGame.GetTutorialSystem().uiHandler.GetCurrentState();
        if(uiStateAlchemy)
        {
            uiStateAlchemy.CookedItem(recipeName);
        }
        else
        {
            uiStateAlchemyMutagens = (W3TutorialManagerUIHandlerStateAlchemyMutagens)theGame.GetTutorialSystem().uiHandler.GetCurrentState();
            if(uiStateAlchemyMutagens)
                uiStateAlchemyMutagens.CookedItem(recipeName);
        }
    }
}

@wrapMethod(W3HorseComponent)
function GetPanicPercent() : float
{
    if(theGame.getWolvenTrainer().getNoHorsePanic())
    {
        return 0;
    }
    else
    {
        return wrappedMethod();
    }
}

@wrapMethod(PhotomodeManager)
function EnablePhotomode()
{
    if(theGame.getWolvenTrainer().getPaused())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}

@wrapMethod(CPlayerInput)
function OnIngameMenu( action : SInputAction )
{
    if(theGame.getWolvenTrainer().getPaused())
    {

    }
    else
    {
        wrappedMethod(action);
    }
}

@wrapMethod(CR4Player)
function HasRequiredLevelToEquipItem(item : SItemUniqueId) : bool
{
    if(theGame.getWolvenTrainer().getNoLevelRequirements())
    {
        return true;
    }
    else
    {
        return wrappedMethod(item);
    }
}

@wrapMethod(CInventoryComponent)
function SetItemDurabilityScript( itemId : SItemUniqueId, durability : float )
{
    if(theGame.getWolvenTrainer().getNoDurability())
    {
        SetItemDurability( itemId, GetItemMaxDurability(itemId) );		
    }
    else
    {
        return wrappedMethod(itemId, durability);
    }
}

@wrapMethod(CInventoryComponent)
function ReduceItemDurability(itemId : SItemUniqueId, optional forced : bool) : bool
{
    if(theGame.getWolvenTrainer().getNoDurability())
    {
        SetItemDurabilityScript( itemId, GetItemMaxDurability(itemId) );
        return true;
    }
    else
    {
        return wrappedMethod(itemId, forced);
    }
}

@wrapMethod(CR4Player)
function RepairItemUsingConsumable(item, consumable : SItemUniqueId) : bool
{
    if(theGame.getWolvenTrainer().getNoDurability())
    {
        return true;
    }
    else
    {
        return wrappedMethod(item, consumable);
    }
}

@wrapMethod(W3DamageManagerProcessor)
function CanPerformFinisher( actorVictim : CActor ) : bool
{
    if(theGame.getWolvenTrainer().getBloodbath())
    {
        if ( (W3ReplacerCiri)thePlayer || playerVictim || thePlayer.isInFinisher )
			return false;
		
		if ( actorVictim.IsAlive() && !CanPerformFinisherOnAliveTarget(actorVictim) )
			return false;
		
		if ( actorVictim.WillBeUnconscious() && !theGame.GetDLCManager().IsEP2Available() )
			return false;

        if ( actorVictim.IsHuman() )
		{
            return true;
        }
    }

    return wrappedMethod(actorVictim);
}

@wrapMethod(CR4HudModuleLootPopup)
function SignalLootingReactionEvent()
{
    if(theGame.getWolvenTrainer().getStealing())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}
@wrapMethod(CR4HudModuleLootPopup)
function SignalStealingReactionEvent()
{
    if(theGame.getWolvenTrainer().getStealing())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}
@wrapMethod(CR4HudModuleLootPopup)
function SignalContainerClosedEvent()
{
    if(theGame.getWolvenTrainer().getStealing())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}

@wrapMethod(CR4LootPopup)
function SignalLootingReactionEvent()
{
    if(theGame.getWolvenTrainer().getStealing())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}
@wrapMethod(CR4LootPopup)
function SignalStealingReactionEvent()
{
    if(theGame.getWolvenTrainer().getStealing())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}
@wrapMethod(CR4LootPopup)
function SignalContainerClosedEvent()
{
    if(theGame.getWolvenTrainer().getStealing())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}

@addMethod(W3LevelManager)
function SetLevel(val : int) : bool
{
    var newLevelDef : SLevelDefinition;

    if(!(val >= 1 && val <= GetMaxLevel()))
    {
        return false;
    }
    
    level = val;
    
    newLevelDef = GetLevelDefinition(level);
    
    points[EExperiencePoint].used = newLevelDef.requiredTotalExp;
    points[EExperiencePoint].free = 100;

    if(level == GetMaxLevel())
    {
       points[EExperiencePoint].free = 0;  
    }
    
    owner.OnLevelGained(level, true);

    return true;
}

@wrapMethod(CActor)
function ReduceDamage( out damageData : W3DamageAction )
{
    var actorAttacker 			: CActor;
    var id 						: SItemUniqueId;
    var attackAction 			: W3Action_Attack;
    var arrStr 					: array<string>;
    var l_percAboutToBeRemoved 	: float;
    var l_healthPerc			: float;
    var l_threshold				: float;
    var l_maxPercLossAllowed	: float;
    var l_maxDamageAllowed		: float;
    var l_maxHealth, mult		: float;
    var l_actorTarget			: CActor;
    var canLog					: bool;
    var hitsToKill				: SAbilityAttributeValue;
    var thisNPC					: CNewNPC;
    var minDamage				: float;
    var i						: int;
    var dmgTypes 				: array< SRawDamage >;
    var hasPoisonDamage			: bool;

    if(theGame.getWolvenTrainer().getDamageMultiplier())
    {
        canLog = theGame.CanLog();
            

        if( damageData.victim == thePlayer && !damageData.IsDoTDamage() )
        {
            damageData.GetDTs( dmgTypes );
            
            
            for( i=0; i<dmgTypes.Size(); i+=1 )
            {
                if( dmgTypes[i].dmgType == theGame.params.DAMAGE_NAME_DIRECT )
                {
                    dmgTypes.EraseFast( i );
                    break;
                }
            }
            
            if( dmgTypes.Size() > 0 )
            {
                hasPoisonDamage = false;
                for( i=0; i<dmgTypes.Size(); i+=1 )
                {
                    if( dmgTypes[ i ].dmgType == theGame.params.DAMAGE_NAME_POISON )
                    {
                        hasPoisonDamage = true;
                        break;
                    }
                }
            
                if( !( hasPoisonDamage && this == GetWitcherPlayer() && HasBuff( EET_GoldenOriole ) && GetWitcherPlayer().GetPotionBuffLevel( EET_GoldenOriole ) == 3) )
                {
                    minDamage = 0;
                    for( i=0; i<dmgTypes.Size(); i+=1 )
                    {
                        if( DamageHitsVitality( dmgTypes[ i ].dmgType ) )
                        {
                            minDamage += dmgTypes[ i ].dmgVal;
                        }
                    }
                    minDamage *= 0.05;
                    if(minDamage < 1)
                    {
                        minDamage = 1;
                    }	
                    if( damageData.processedDmg.vitalityDamage < minDamage )
                    {
                        damageData.processedDmg.vitalityDamage = minDamage;
                    }
                }
            }
        }


        if(damageData.IsActionRanged() && damageData.attacker == thePlayer && (W3BoltProjectile)(damageData.causer) )
        {
            if(UsesEssence() && damageData.processedDmg.essenceDamage < 1)
            {
                damageData.processedDmg.essenceDamage = 1;
                    
                if ( canLog )
                {
                    LogDMHits("CActor.ReduceDamage: victim would take no damage but it's a bolt so we deal 1 pt of damage", damageData );
                }
            }
            else if(UsesVitality() && damageData.processedDmg.vitalityDamage < 1)
            {
                damageData.processedDmg.vitalityDamage = 1;
                
                if ( canLog )
                {
                    LogDMHits("CActor.ReduceDamage: victim would take no damage but it's a bolt so we deal 1 pt of damage", damageData );
                }
            }
        }


        thisNPC = (CNewNPC)this;
        if( thisNPC && damageData.attacker == thePlayer && !HasBuff(EET_AxiiGuardMe) &&
            ( GetAttitudeBetween( this, thePlayer ) == AIA_Friendly ||
            ( GetAttitudeBetween( this, thePlayer ) == AIA_Neutral && thisNPC.GetNPCType() == ENGT_Guard ) ) )
        {
            if ( canLog )
            {
                LogDMHits("Player attacked friendly or neutral community npc - no damage dealt", damageData);
            }
            damageData.SetAllProcessedDamageAs(0);
            damageData.ClearEffects();
            return;
        }


        if( HasBuff(EET_AxiiGuardMe) && damageData.attacker != thePlayer )
        {
            damageData.processedDmg.vitalityDamage *= 0.1f;
            damageData.processedDmg.essenceDamage *= 0.1f;
        }



        if(damageData.IsActionMelee() && HasAbility( 'ReflectMeleeAttacks' ) )
        {
            if ( canLog )
            {
                LogDMHits("CActor.ReduceDamage: victim is heavily armored and attacker bounces of his armor", damageData );
            }
            damageData.SetAllProcessedDamageAs(0);
            ((CActor)damageData.attacker).ReactToReflectedAttack( this );
            damageData.ClearEffects();
            return;
        }


        if(!damageData.DealsAnyDamage() && damageData.GetBuffSourceName() != "Mutation4")
            return;


        if(damageData.IsActionMelee() && HasAbility( 'CannotBeAttackedFromAllSides' ) )
        {
            if ( canLog )
            {
                LogDMHits("CActor.ReduceDamage: victim attacked from behind and immune to this type of strike - no damage will be done", damageData );
            }
            damageData.SetAllProcessedDamageAs(0);
            ((CActor)damageData.attacker).ReactToReflectedAttack( this );
            damageData.ClearEffects();
            return;
        }


        if(damageData.IsActionMelee() && HasAbility( 'CannotBeAttackedFromBehind' ) && IsAttackerAtBack(damageData.attacker) )
        {
            if ( canLog )
            {
                LogDMHits("CActor.ReduceDamage: victim attacked from behind and immune to this type of strike - no damage will be done", damageData );
            }
            damageData.SetAllProcessedDamageAs(0);
            ((CActor)damageData.attacker).ReactToReflectedAttack( this );
            damageData.ClearEffects();
            return;
        }


        if(damageData.IsActionMelee() && HasAbility( 'VulnerableFromFront' ) && !IsAttackerAtBack(damageData.attacker) )
        {
            if ( canLog )
            {
                LogDMHits("CActor.ReduceDamage: victim attacked from front and vulnerable to this type of strike - attack will ignor armor", damageData );
            }
            damageData.SetIgnoreArmor( true );
            damageData.SetPointResistIgnored( true );
            return;
        }



        if( this.HasAbility( 'EredinInvulnerable' ) && damageData.IsActionWitcherSign() )
        {
            if ( canLog )
            {
                LogDMHits("CActor.ReduceDamage: victim has EredinInvulnerable ability - no damage will be done", damageData );
            }
            damageData.SetAllProcessedDamageAs(0);
            return;
        }


        if(this != thePlayer && IsCurrentlyDodging() && damageData.CanBeDodged() && ( VecDistanceSquared(this.GetWorldPosition(),damageData.attacker.GetWorldPosition()) > 1.7 
            || this.HasAbility( 'IgnoreDodgeMinimumDistance' ) ))
        {
            if ( canLog )
            {
                LogDMHits("Non-player character dodge - no damage dealt", damageData);
            }
            damageData.SetWasDodged();
            damageData.SetAllProcessedDamageAs(0);
            damageData.ClearEffects();
            damageData.SetHitAnimationPlayType(EAHA_ForceNo);
            return;
        }


        if(this != thePlayer && FactsDoesExist("debug_fact_weak"))
        {
            if ( canLog )
            {
                LogDMHits("CActor.ReduceDamage: using 'weak' cheat - all damage set to 0.001", damageData );
            }
            damageData.processedDmg.essenceDamage = MinF(0.001, damageData.processedDmg.essenceDamage);
            damageData.processedDmg.vitalityDamage = MinF(0.001, damageData.processedDmg.vitalityDamage);
            damageData.processedDmg.staminaDamage = MinF(0.001, damageData.processedDmg.staminaDamage);
            damageData.processedDmg.moraleDamage = MinF(0.001, damageData.processedDmg.moraleDamage);
        }




        if(damageData.IsParryStagger())
        {
            actorAttacker = (CActor)damageData.attacker;
            
            if ( ((CMovingPhysicalAgentComponent)( actorAttacker ).GetMovingAgentComponent()).GetCapsuleHeight() > 2.f )
                mult = theGame.params.PARRY_STAGGER_REDUCE_DAMAGE_LARGE;
            else if ( actorAttacker.GetRadius() > 0.6 )
                mult = theGame.params.PARRY_STAGGER_REDUCE_DAMAGE_LARGE;
            else if ( this == thePlayer && thePlayer.GetBossTag() != '' )	
                mult = theGame.params.PARRY_STAGGER_REDUCE_DAMAGE_LARGE;
            else if ( actorAttacker.HasAbility( 'mon_troll_base' ) )
                mult = theGame.params.PARRY_STAGGER_REDUCE_DAMAGE_LARGE;
            else
                mult = theGame.params.PARRY_STAGGER_REDUCE_DAMAGE_SMALL;
            
            damageData.MultiplyAllDamageBy(mult);
            
            if ( canLog )
            {
                LogDMHits("Stagger-Parry, reducing damage by " + NoTrailZeros((1-mult)*100) + "%");
            }
        }
        else
        {
            
            attackAction = (W3Action_Attack)damageData;
            if(attackAction && damageData.IsActionMelee() && attackAction.CanBeParried() && (attackAction.IsParried() || attackAction.IsCountered()))
            {
                arrStr.PushBack(GetDisplayName());
                if(attackAction.IsParried())
                {
                    if ( canLog )
                    {
                        LogDMHits("Attack parried - no damage", damageData);
                    }
                    theGame.witcherLog.AddCombatMessage(GetLocStringByKeyExtWithParams("hud_combat_log_parries", , , arrStr), attackAction.attacker, this);
                }
                else
                {
                    if ( canLog )
                    {			
                        LogDMHits("Attack countered - no damage", damageData);
                    }
                    theGame.witcherLog.AddCombatMessage(GetLocStringByKeyExtWithParams("hud_combat_log_counters", , , arrStr), attackAction.attacker, this);
                }
                
                damageData.SetAllProcessedDamageAs(0);
                return;
            }
        }

        actorAttacker = (CActor)damageData.attacker;


        if((CPlayer)actorAttacker && !((CPlayer)damageData.victim) && FactsQuerySum('player_is_the_boss') > 0)
        {
            if ( canLog )
            {			
                LogDMHits("Using 'like a boss' cheat - damage set to 40% of targets MAX health", damageData);
            }
            damageData.processedDmg.vitalityDamage = GetStatMax(BCS_Vitality) / 2.5;		
            damageData.processedDmg.essenceDamage = GetStatMax(BCS_Essence) / 2.5;		
        }	


        if(attackAction && actorAttacker == thePlayer && thePlayer.inv.IsItemBolt(attackAction.GetWeaponId()) )		
        {
            if(thePlayer.IsOnBoat())
            {
                hitsToKill = GetAttributeValue('extraDamageWhenPlayerOnBoat');
                if(hitsToKill.valueAdditive > 0)
                {
                    damageData.processedDmg.vitalityDamage = CeilF(GetStatMax(BCS_Vitality) / hitsToKill.valueAdditive);	
                    damageData.processedDmg.essenceDamage = CeilF(GetStatMax(BCS_Essence) / hitsToKill.valueAdditive);		
                    
                    if(theGame.CanLog())
                    {
                        LogDMHits("Target is getting killed by " + NoTrailZeros(hitsToKill.valueAdditive) + " hits when being shot from boat by default bolts", damageData);
                        LogDMHits("Final hacked damage is now, vit: " + NoTrailZeros(damageData.processedDmg.vitalityDamage) + ", ess: " + NoTrailZeros(damageData.processedDmg.essenceDamage), damageData);
                    }
                }
            }
        }		



        if( HasAbility( 'ShadowFormActive' ) )
        {
            if ( canLog )
            {
                LogDMHits("CActor.ReduceDamage: victim has ShadowFormActive ability - damage reduced to 10% of base", damageData );
            }
            damageData.processedDmg.vitalityDamage *= 0.1f;
            damageData.processedDmg.essenceDamage *= 0.1f;
            damageData.SetCanPlayHitParticle( false );
            theGame.witcherLog.CombatMessageAddGlobalDamageMult(0.1f);
        }



        if( actorAttacker && HasAbility( 'IceArmor' ) && !actorAttacker.HasAbility( 'Ciri_Rage' ) )
        {
            if ( theGame.GetDifficultyMode() == EDM_Easy )
            {
                if ( canLog )
                {
                    LogDMHits("CActor.ReduceDamage: victim has IceArmor ability - damage reduced by 5%", damageData );
                }
                damageData.processedDmg.vitalityDamage *= 0.95f;
                damageData.processedDmg.essenceDamage *= 0.95f;
                theGame.witcherLog.CombatMessageAddGlobalDamageMult(0.95f);
            }
            else
            {
                if ( canLog )
                {
                    LogDMHits("CActor.ReduceDamage: victim has IceArmor ability - damage reduced by 50%", damageData );
                }
                damageData.processedDmg.vitalityDamage *= 0.5f;
                damageData.processedDmg.essenceDamage *= 0.5f;
                theGame.witcherLog.CombatMessageAddGlobalDamageMult(0.5f);
            }
        }




        if( HasAbility( 'LastBreath' ) )
        {
            l_threshold 	= CalculateAttributeValue( GetAttributeValue('lastbreath_threshold') );
            if( l_threshold == 0 ) l_threshold = 0.25f;
            l_healthPerc 	= GetHealthPercents();
            
            
            if( theGame.GetEngineTimeAsSeconds() - lastBreathTime < 1 )
            {
                if( damageData.processedDmg.vitalityDamage > 0 ) 	damageData.processedDmg.vitalityDamage 	= 0;
                if( damageData.processedDmg.essenceDamage > 0 ) 	damageData.processedDmg.essenceDamage 	= 0;
                
                if ( canLog )
                {
                    LogDMHits("CActor.ReduceDamage: victim just activated LastBreath ability - reducing damage" );
                }
            }
            else if( l_healthPerc > l_threshold )
            {
                l_maxHealth 			= GetMaxHealth();
                l_percAboutToBeRemoved 	= MaxF( damageData.processedDmg.vitalityDamage, damageData.processedDmg.essenceDamage ) / l_maxHealth;
                
                l_maxPercLossAllowed 	= l_healthPerc - l_threshold;
                
                if( l_percAboutToBeRemoved > l_maxPercLossAllowed )
                {
                    
                    l_maxDamageAllowed = l_maxPercLossAllowed * l_maxHealth;
                    if( damageData.processedDmg.vitalityDamage > 0 ) 	damageData.processedDmg.vitalityDamage 	= l_maxDamageAllowed;
                    if( damageData.processedDmg.essenceDamage > 0 ) 	damageData.processedDmg.essenceDamage 	= l_maxDamageAllowed;
                    if ( canLog )
                    {
                        LogDMHits("CActor.ReduceDamage: victim has LastBreath ability - reducing damage", damageData );
                    }
                    
                    SignalGameplayEvent('LastBreath');
                    lastBreathTime = theGame.GetEngineTimeAsSeconds();					
                    DisableHitAnimFor( 1 );
                }
            }
        }

        if((CPlayer)damageData.attacker && IsAlive() && actorAttacker == thePlayer) 
        {
            if(damageData.IsDoTDamage())
            {
                damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getDamageOT();
                damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getDamageOT();
            }
            else if(damageData.IsActionRanged() && ((W3BoltProjectile)(damageData.causer) || (W3ArrowProjectile)(damageData.causer)))
            {
                damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getDamageCrossbow();
                damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getDamageCrossbow();
            }
            else if(damageData.IsActionRanged())
            {
                damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getDamageBombs();
                damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getDamageBombs();
            }
            else if(damageData.IsActionWitcherSign())
            {
                damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getDamageSign();
                damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getDamageSign();
            }
            else if(actorAttacker.IsWeaponHeld('fist'))
            {
                damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getDamageFist();
                damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getDamageFist();
            }
            else if(damageData.IsActionMelee())
            {
                damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getDamageSwords();
                damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getDamageSwords();
            }

            damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getDamageOverall();
            damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getDamageOverall();
        }
        else if(IsAlive() && actorAttacker != thePlayer)
        {
            damageData.processedDmg.vitalityDamage *= theGame.getWolvenTrainer().getIncomingDamageOverall();
			damageData.processedDmg.essenceDamage *= theGame.getWolvenTrainer().getIncomingDamageOverall();
        }

        if(damageData.victim != thePlayer)
        {
            
            if(!damageData.GetIgnoreImmortalityMode())
            {
                if(!((W3PlayerWitcher)this))
                    Log("");
                
                
                if( IsInvulnerable() )
                {
                    if ( canLog )
                    {
                        LogDMHits("CActor.ReduceDamage: victim Invulnerable - no damage will be dealt", damageData );
                    }
                    damageData.SetAllProcessedDamageAs(0);
                    return;
                }
                
                if(actorAttacker && damageData.DealsAnyDamage() )
                    actorAttacker.SignalGameplayEventParamObject( 'DamageInstigated', damageData );
                
                
                if( IsImmortal() )
                {
                    if ( canLog )
                    {
                        LogDMHits("CActor.ReduceDamage: victim is Immortal, clamping damage", damageData );
                    }
                    damageData.processedDmg.vitalityDamage = ClampF(damageData.processedDmg.vitalityDamage, 0, GetStat(BCS_Vitality)-1 );
                    damageData.processedDmg.essenceDamage  = ClampF(damageData.processedDmg.essenceDamage, 0, GetStat(BCS_Essence)-1 );
                    return;
                }
            }
            else
            {
                
                if(actorAttacker && damageData.DealsAnyDamage() )
                    actorAttacker.SignalGameplayEventParamObject( 'DamageInstigated', damageData );
            }
        }
    }
    else
    {
        return wrappedMethod(damageData);
    }
    
    
}

@addField(CNewNPC) 
private var wolvenAITreeFollow : CAIFollowAction;

@addField(CNewNPC) 
private var wolvenActionID : int;

@addField(CNewNPC) 
private var wolvenIsFollowing : bool;

@addMethod(CNewNPC)
private function WolvenStartFollowing() 
{
    if( !wolvenIsFollowing )
    {
        wolvenAITreeFollow = new CAIFollowAction in this;
        wolvenAITreeFollow.OnCreated();
        wolvenAITreeFollow.params.targetTag = 'PLAYER';
        wolvenAITreeFollow.params.moveSpeed = 6;
        wolvenAITreeFollow.params.teleportToCatchup = true;
        
        wolvenActionID = ForceAIBehavior(wolvenAITreeFollow, BTAP_Emergency);

        if( wolvenActionID )
        {
            wolvenIsFollowing = true;
        }
    }
}

@addMethod(CNewNPC)
private function WolvenStopFollowing() 
{
    if( wolvenIsFollowing )
    {
        CancelAIBehavior(wolvenActionID);
        wolvenIsFollowing = false;
        delete wolvenAITreeFollow;
    }
}

@wrapMethod(CExplorationStateJump)
function StateCanEnter( curStateName : name ) : bool
{
    if(theGame.getWolvenTrainer().getFlyMode() || theGame.getWolvenTrainer().getFreecam() || (theGame.getWolvenTrainer().getMenuOpen() && theInput.LastUsedGamepad()))
    {
        return false;
    }
    else
    {
        return wrappedMethod(curStateName);
    }
}

@wrapMethod(W3FastTravelEntity)
function OnPlayerEnteredBorder()
{
    if(theGame.getWolvenTrainer().getNoBorders())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}

@wrapMethod(W3FastTravelEntity)
function OnPlayerExitedBorder()
{
    if(theGame.getWolvenTrainer().getNoBorders())
    {
        return;
    }
    else
    {
        return wrappedMethod();
    }
}

@wrapMethod(CBoatDestructionComponent)
function GetClosestFreeGrabSlotInfo( _ActorPosition : Vector, _ActorHeading : float ,out _ClosestSlotName : name, out _Position : Vector, out _Heading : float ) : bool
{
    if(theGame.getWolvenTrainer().getUnsinkable())
    {
        return false;
    }
    else
    {
        return wrappedMethod(_ActorPosition, _ActorHeading, _ClosestSlotName, _Position, _Heading); 
    }
}

@wrapMethod(CBoatDestructionComponent)
function ReduceHealth(dmg : float, index : int, globalHitPos : Vector)
{
    if(theGame.getWolvenTrainer().getUnsinkable())
    {
        dmg = 0;
    }

    return wrappedMethod(dmg, index, globalHitPos);
}

@addMethod(CBoatDestructionComponent)
function wolven_repairBoatInternal()
{
    var i : int;

    for(i=0; i<destructionVolumes.Size(); i+=1)
    {
        destructionVolumes[i].areaHealth = 100;
    }
}

@addField(CBoatComponent)
private var wolven_deltaDamper : DeltaDamper;

@wrapMethod( CBoatComponent ) 
function OnTick( dt : float )	
{
	var currentFrontPosZ : float;
	var currentFrontVelZ : float;
	var currentFrontAccZ : float;
	
	var currentRightPosZ : float;
	var currentRightVelZ : float;
	var currentRightAccZ : float;

	var currentMastPosZ : float;
	var currentMastVelZ : float;
	
	var sailingMaxSpeed : float;
	var currentSpeed : float;
	var isMoving : bool;
	var tilt : float;
	var turnFactor : float;
	var currentGear: int;
	
	var fDiff,bDiff,rDiff,lDiff: float;

	if(false)
	{
		wrappedMethod(dt);
	}
	
	if ( dt <= 0.f )
	{
		LogBoat( "!!!!!!!!!!!!! dt <= 0.f !!!!!!!!!!!!!" );
		return false;
	}
	
	if( !boatEntity )
	{
		LogBoatFatal( "Entity not set in CBoatComponent::OnTick event." );
		return false;
	}
	
	
	fr = GetBuoyancyPointStatus_Front();
	ba = GetBuoyancyPointStatus_Back();
	ri = GetBuoyancyPointStatus_Right();
	le = GetBuoyancyPointStatus_Left();
	
	fDiff = fr.Z - fr.W;
	bDiff = ba.Z - ba.W;
	rDiff = ri.Z - ri.W;
	lDiff = le.Z - le.W;
	
	
	tilt = le.Z - ri.Z;
	sailDir = tilt*dt;
	sailTilt = tilt;
	
	
	boatEntity.CalcEntitySlotMatrix( 'front_splash', frontSlotTransform );
	currentFrontPosZ = (frontSlotTransform.W).Z;
	currentFrontVelZ = currentFrontPosZ - prevFrontPosZ;
	currentFrontAccZ = currentFrontVelZ - prevFrontVelZ;
	
	
	boatEntity.CalcEntitySlotMatrix( 'mast_trail', mastSlotTransform );
	currentMastPosZ = (mastSlotTransform.W).Z;
	if( tilt > 0.f )
	{
		currentMastVelZ = currentMastPosZ - ri.W;
	}
	else
	{
		currentMastVelZ = currentMastPosZ - le.W;
	}
	
	isMoving = ( GetLinearVelocityXY() > IDLE_SPEED_THRESHOLD );
	sailingMaxSpeed = GetMaxSpeed();
	
	if( isMoving )
	{
		
		boatEntity.StopEffectIfActive( 'idle_splash' );
		
		
		
		currentSpeed = GetLinearVelocityXY() / sailingMaxSpeed;

		if ( user && !passenger && GetCurrentStateName() != 'RealSailing' && IsPlayerInput() && (GetCurrentGear() > 0 ))
		{
			if ( !CheckForCollision() )
			{
                if(theGame.getWolvenTrainer().getCustomBoatSpeed())
                {
				    ModifyBoatSpeed(dt);
                }
			}
		}

		if( IsInWater(ri) && rDiff < TILT_PARTICLE_THRESHOLD )
		{
			boatEntity.PlayEffectSingle( 'right_splash_stronger' );
		}
		else
		{
			boatEntity.StopEffectIfActive( 'right_splash_stronger' );
		}
		
		
		if( IsInWater(le) && lDiff < TILT_PARTICLE_THRESHOLD )
		{
			boatEntity.PlayEffectSingle( 'left_splash_stronger' );
		}
		else
		{
			boatEntity.StopEffectIfActive( 'left_splash_stronger' );
		}
		
		
		if( currentMastVelZ < MAST_PARTICLE_THRESHOLD )
		{
			boatEntity.PlayEffectSingle( 'mast_trail' );
			
			if( !boatEntity.SoundIsActiveName( 'boat_mast_trail_loop' ) && !boatMastTrailLoopStarted)
			{
				boatEntity.SoundEvent( 'boat_mast_trail_loop', 'mast_trail', true );
				boatMastTrailLoopStarted = true;
			}
		}
		else
		{
			boatEntity.StopEffectIfActive( 'mast_trail' );
			if( boatEntity.SoundIsActiveName( 'boat_mast_trail_loop' ) && boatMastTrailLoopStarted )
			{
				if( !boatEntity.SoundIsActiveName( 'boat_mast_trail_loop_stop' ) )
				{
					boatEntity.SoundEvent( 'boat_mast_trail_loop_stop' , 'mast_trail', true );
					boatMastTrailLoopStarted = false;
				}
			}
		}
		
		
		if( IsDiving( currentFrontVelZ, prevFrontWaterPosZ, fDiff ) )
		{
			boatEntity.SoundEvent( "boat_stress" );
			if ( !boatEntity.IsEffectActive('front_splash') )
			{
				boatEntity.SoundEvent( "boat_water_splash_soft" );
				boatEntity.PlayEffect( 'front_splash' );
			}
		}
	}
	else
	{
		if ( !IsPlayerInput() )
		{
			wolven_deltaDamper.Reset();
		}

		if( IsInWater(le) && IsInWater(ri) && IsInWater(fr) && IsInWater(ba) && !boatEntity.IsEffectActive('idle_splash') )
		{
			boatEntity.PlayEffect( 'idle_splash' );
		}
		
		SwitchEffectsByGear( 0 );
		
		
		boatEntity.StopEffectIfActive( 'front_splash' );
		boatEntity.StopEffectIfActive( 'mast_trail' );
		boatEntity.StopEffectIfActive( 'right_splash_stronger' );
		boatEntity.StopEffectIfActive( 'left_splash_stronger' );
		
		
		boatEntity.StopEffectIfActive( 'fake_wind_right' );
		boatEntity.StopEffectIfActive( 'fake_wind_left' );
		boatEntity.StopEffectIfActive( 'fake_wind_back' );
		currentSpeed = 0.f;
	}
	
	
	currentGear = GetCurrentGear();
	
	
	if( passenger )
		UpdatePassengerSailAnimByGear( currentGear );
	
	if( IsInWater(le) && IsInWater(ri) && IsInWater(fr) && IsInWater(ba) && currentGear != previousGear )
	{
		SwitchEffectsByGear( currentGear );
	}
	
	
	UpdateMastPositionAndRotation( currentGear, tilt, isMoving );
	
	
	UpdateSoundParams( currentSpeed );
	
	
	
	previousGear = currentGear;
	
	
	prevFrontWaterPosZ = fr.W;
	
	
	prevFrontPosZ += currentFrontVelZ;
	prevFrontVelZ = currentFrontVelZ;
	
	
	prevMastPosZ += currentMastVelZ;
	prevMastVelZ = currentMastVelZ;
	
	
	prevRightPosZ += currentRightVelZ;
	prevRightVelZ = currentRightVelZ;
	
	
	if( thePlayer.IsOnBoat() && !thePlayer.IsUsingVehicle() )
	{
		if( GetWeatherConditionName() == 'WT_Rain_Storm' )
		{
			if( thePlayer.GetBehaviorVariable( 'bRainStormIdleAnim' ) != 1.0 )
			{
				thePlayer.SetBehaviorVariable( 'bRainStormIdleAnim', 1.0 );
			}
		}
		else
		{
			if( thePlayer.GetBehaviorVariable( 'bRainStormIdleAnim' ) != 0.0 )
			{
				thePlayer.SetBehaviorVariable( 'bRainStormIdleAnim', 0.0 );
			}
		}
	}
}

@addMethod(CBoatComponent) 
function GetInputVectorInCamSpace( stickInputX : float, stickInputY : float ) : Vector
{
	var inputVec : Vector;
	var inputHeading : float;
	
	inputVec.X = stickInputX;
	inputVec.Y = stickInputY;
	inputVec = VecNormalize2D(inputVec);
	inputHeading = AngleDistance( theCamera.GetCameraHeading(), -VecHeading( inputVec ) ); 
	inputVec = VecFromHeading( inputHeading );
	
	return inputVec;
}

@addMethod(CBoatComponent)
private function ModifyBoatSpeed(deltaTime : float)
{
	var linVelocity, headingVec, boatHeadingVec, inputVec : Vector;
	var currentSpeed, min, max, heading, maxBoatSpeed, stickInputX, stickInputY : float;
	var accelerate : SInputAction;
	
	if ( !wolven_deltaDamper )
	{
		wolven_deltaDamper = new DeltaDamper in this;
		wolven_deltaDamper.SetDamp( 0.3f );
	}

	accelerate = theInput.GetAction( 'GI_Accelerate' );
	stickInputX = theInput.GetActionValue( 'GI_AxisLeftX' );
	stickInputY = theInput.GetActionValue( 'GI_AxisLeftY' );
	
	if( (stickInputX || stickInputY ) || (accelerate.value != 0) )
	{
		inputVec = GetInputVectorInCamSpace( stickInputX, stickInputY );
		boatHeadingVec = this.GetHeadingVector();		
		headingVec = VecNormalize2D( inputVec * 0.05 + boatHeadingVec * 1.0 );
		if (GetCurrentGear() < 0) headingVec = - headingVec;
		heading = VecHeading(headingVec);
		
		switch( GetCurrentGear() )
		{
			case -1:
				return;
			case 1:
				return;
			case 2:
				maxBoatSpeed = 16.0f * 7;
				break;
			case 3:
				maxBoatSpeed = 30.0f * 7;
				break;
		}

		currentSpeed = wolven_deltaDamper.UpdateAndGet( deltaTime, maxBoatSpeed );
		min = currentSpeed - RandRangeF( (0.1f * wolven_deltaDamper.GetValue()),0.f );
		max = currentSpeed + RandRangeF( (0.1f * wolven_deltaDamper.GetValue()),0.f );
		linVelocity = VecConeRand(heading, 10.0f, min, max);
		((CBoatBodyComponent)boatEntity.GetComponentByClassName( 'CBoatBodyComponent' )).SetPhysicalObjectLinearVelocity( linVelocity );
	}


}

@addMethod(CBoatComponent)
private function IsPlayerInput() : bool
{	
    if ( ( AbsF(theInput.GetActionValue( 'GI_AxisLeftX' )) + 
        AbsF(theInput.GetActionValue( 'GI_AxisLeftY' )) +
        AbsF(theInput.GetActionValue( 'GI_Accelerate' )) + 
        AbsF(theInput.GetActionValue( 'GI_Decelerate' )) ) > 0 )
        return true;
    else
        return false;
}
@addMethod(CBoatComponent)
private function CheckForCollision() : bool
{
    var startPos : Vector;
    var heading : Vector;
    var endPos, outPos, normal : Vector;
    var ret : bool;
    var CheckCollisionGroups : array<name>;
    var anticipationDist, heightOffset, radius : float;
    
    anticipationDist = 25;
    heightOffset = 0.3;
    radius = 0.45;
    
    CheckCollisionGroups.PushBack( 'Static' );		
    CheckCollisionGroups.PushBack( 'Terrain' );
    CheckCollisionGroups.PushBack( 'BoatDocking' );
    
    startPos = this.GetWorldPosition();
    heading = this.GetHeadingVector();
    
    endPos = startPos + heading * anticipationDist;
    startPos.Z += heightOffset;
    endPos.Z += heightOffset;
    
    if( theGame.GetWorld().SweepTest( startPos, endPos, radius, outPos, normal, CheckCollisionGroups ) ) 
        return true;
    else
        return false;
}

@wrapMethod(CR4Game)
function OnGameLoadInitFinishedSuccess()
{
    wrappedMethod();
    if(!this.wolvenTrainer.getNewLoad())
    {
        LogChannel('WOLVEN TRAINER', "NEW LOAD|clear options");
        this.wolvenTrainer = new WolvenTrainer in this;
        this.wolvenTrainer.setNewLoad(true);
    }
}

@wrapMethod(CR4GuiManager)
function OnEnteredMainMenu()
{
    wrappedMethod();
    LogChannel('WOLVEN TRAINER', "NEW LOAD|main menu");
    theGame.newWolvenTrainer();
    theGame.getWolvenTrainer().setNewLoad(true);
}

@wrapMethod(CR4Game)
function OnAfterLoadingScreenGameStart()
{
    wrappedMethod();
    if(this.wolvenTrainer.getNewLoad())
    {
        LogChannel('WOLVEN TRAINER', "TRAINER INIT|load trainer");
        this.wolvenTrainer.setNewLoad(false);
    }
}

@wrapMethod(CR4IngameMenu)
function StartNewGame():void
{
    theGame.newWolvenTrainer();
    theGame.getWolvenTrainer().setNewLoad(false);
    LogChannel('WOLVEN TRAINER', "TRAINER INIT|new game");
    wrappedMethod();
}

@wrapMethod(CPlayerInput)
function OnCommDrinkPotion1( action : SInputAction )
{
    if(theGame.getWolvenTrainer().getMenuOpen() && theInput.LastUsedGamepad())
    {
        return true;
    }
    else
    {
        return wrappedMethod(action);
    }
}

@wrapMethod(CPlayerInput)
function OnCommDrinkPotion2( action : SInputAction )
{
    if(theGame.getWolvenTrainer().getMenuOpen() && theInput.LastUsedGamepad())
    {
        return true;
    }
    else
    {
        return wrappedMethod(action);
    }
}

@wrapMethod(CPlayerInput)
function OnCommSteelSword( action : SInputAction )
{
    if(theGame.getWolvenTrainer().getMenuOpen() && theInput.LastUsedGamepad())
    {
        return true;
    }
    else
    {
        return wrappedMethod(action);
    }
}

@wrapMethod(CPlayerInput)
function OnCommSilverSword( action : SInputAction )
{
    if(theGame.getWolvenTrainer().getMenuOpen() && theInput.LastUsedGamepad())
    {
        return true;
    }
    else
    {
        return wrappedMethod(action);
    }
}

@wrapMethod(W3DamageManagerProcessor)
function CanDismember( wasFrozen : bool, out dismemberExplosion : bool, out weaponName : name ) : bool
{
    if(theGame.getWolvenTrainer().getBloodbath())
    {
        return true;
    }
    else
    {
        return wrappedMethod(wasFrozen, dismemberExplosion, weaponName);
    }
}

@wrapMethod(W3Effect_Stagger)
function OnEffectAdded(optional customParams : W3BuffCustomParams)
{
    if(theGame.getWolvenTrainer().getNoStagger())
    {
        
    }
    else
    {
        wrappedMethod(customParams);
    }
}

@wrapMethod(Crossbow)
function PlayOwnerReloadAnim() : bool
{
    if(theGame.getWolvenTrainer().getNoCrossbowReload())
    {
        return false;
    }
    else
    {
        return wrappedMethod();
    }
}

@wrapMethod(CR4Player)
function ReduceAllOilsAmmo( id : SItemUniqueId )
{
    if(theGame.getWolvenTrainer().getOilsNeverExpire())
    {

    }
    else
    {
        wrappedMethod(id);
    }
}

@wrapMethod(W3PlayerWitcher)
function EquipItem(item : SItemUniqueId, optional slot : EEquipmentSlots, optional toHand : bool) : bool
{
    var wolven_slot : EEquipmentSlots;
    
    if(thePlayer.inv.IsIdValid(item))
    {
        wolven_slot = thePlayer.inv.GetSlotForItemId(item);
            
        if (wolven_slot == EES_Armor && theGame.getWolvenTrainer().getNoHairTuck())
        {
            theGame.getWolvenTrainer().disableNoHairTuck();
        }
    }

    return wrappedMethod(item, slot, toHand);
}

@wrapMethod(CR4InventoryMenu)
function UnequipItem( item : SItemUniqueId, moveToIndex : int ) : bool
{
    var slot : EEquipmentSlots;
    
    if(thePlayer.inv.IsIdValid(item))
    {
        slot = thePlayer.inv.GetSlotForItemId(item);
            
        if (slot == EES_Armor && theGame.getWolvenTrainer().getNoHairTuck())
        {
            theGame.getWolvenTrainer().disableNoHairTuck();
        }
    }

    return wrappedMethod(item, moveToIndex);
}

@wrapMethod(CR4DeathScreenMenu)
function OnPress( tag : name )
{
    if(theGame.getWolvenTrainer().getMenuOpen())
    {

    }
    else
    {
        wrappedMethod(tag);
    }
    
}