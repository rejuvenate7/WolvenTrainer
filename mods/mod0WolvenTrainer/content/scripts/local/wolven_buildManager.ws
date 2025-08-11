// Wolven Trainer by rejuvenate
// https://next.nexusmods.com/profile/rejuvenate7/about-me
	
function wolven_resetCharacterMenu()
{	
	GetWitcherPlayer().ResetCharacterDev();
}

function wolven_getFirstUnequippedItem(itemName : name) : SItemUniqueId 
{
	var i: int;
	var items: array<SItemUniqueId>;
	var item: SItemUniqueId;
	var firstUnequippedItem: SItemUniqueId;

	firstUnequippedItem = GetInvalidUniqueId();
	
	// check if item in inventory
	GetWitcherPlayer().GetInventory().GetAllItems(items);
	
	for (i=0; i<items.Size(); i+=1) 
	{
		item = items[i];
			
		if(GetWitcherPlayer().GetInventory().GetItemName(item) == itemName)
		{
			if (!GetWitcherPlayer().IsItemEquipped(item)) 
			{
				firstUnequippedItem = item;
				return firstUnequippedItem;
			}
		}
	}
	
	return firstUnequippedItem;
}

function wolven_getStashedInventoryItem(itemNameStr : string) : SItemUniqueId 
{
	var i: int;
	var items: array<SItemUniqueId>;
	var itemName: name;
	var itemNameAsStr: string;
	var inv: CInventoryComponent;
	var stashedInvItem: SItemUniqueId;

	stashedInvItem = GetInvalidUniqueId();
	inv = GetWitcherPlayer().GetHorseManager().GetInventoryComponent();
	inv.GetAllItems(items);
	for(i=items.Size()-1; i>=0; i-=1)
	{
		itemName = inv.GetItemName(items[i]);
		itemNameAsStr = itemName;
		if(itemNameAsStr == itemNameStr) 
		{
			stashedInvItem = items[i];
			break;
		}
	}

	return stashedInvItem;
}

function wolven_playerInvItemStringToName(itemNameStr : string) : name 
{
	var i: int;
	var items: array<SItemUniqueId>;
	var itemName: name;
	var retItemName: name;
	var itemNameAsStr: string;

	retItemName = '';
	GetWitcherPlayer().GetInventory().GetAllItems(items);
	for(i=items.Size()-1; i>=0; i-=1)
	{
		itemName = GetWitcherPlayer().GetInventory().GetItemName(items[i]);
		itemNameAsStr = itemName;
		if(itemNameAsStr == itemNameStr) 
		{
			retItemName = itemName;
			break;
		}
	}

	return retItemName;
}

function wolven_equipHorseItemInt(itemStr : string) 
{
	var item: SItemUniqueId;
	var eqId: SItemUniqueId;

	if (itemStr != "") 
	{
		item = wolven_getFirstUnequippedHorseItem(wolven_playerInvItemStringToName(itemStr));
		if (item != GetInvalidUniqueId()) 
		{
			eqId = GetWitcherPlayer().GetHorseManager().MoveItemToHorse(item);
			GetWitcherPlayer().GetHorseManager().EquipItem(eqId);
		}
	}
}
	
function wolven_getEquippedHorseItem(itemSlot : EEquipmentSlots) : string 
{
	var item: SItemUniqueId;
	var equippedItem: string;

	item = GetWitcherPlayer().GetHorseManager().GetItemInSlot(itemSlot);
	equippedItem = GetWitcherPlayer().GetHorseManager().GetInventoryComponent().GetItemName(item);

	return equippedItem;
}

function wolven_getFirstUnequippedHorseItem(itemName : name) : SItemUniqueId 
{
	var i: int;
	var items: array<SItemUniqueId>;
	var item: SItemUniqueId;
	var firstUnequippedItem: SItemUniqueId;

	firstUnequippedItem = GetInvalidUniqueId();
	if (itemName != '') 
	{
		items = GetWitcherPlayer().GetInventory().GetItemsByName(itemName);
		for (i=0; i<items.Size(); i+=1) 
		{
			item = items[i];
			if (!GetWitcherPlayer().GetHorseManager().IsItemEquipped(item)) 
			{
				firstUnequippedItem = item;
				break;
			}
		}
	}

	return firstUnequippedItem;
}

function wolven_getItemSlots() : array<EEquipmentSlots> 
{
	var itemSlots: array<EEquipmentSlots>;

	itemSlots.PushBack(EES_SteelSword);
	itemSlots.PushBack(EES_SilverSword);
	itemSlots.PushBack(EES_Armor);
	itemSlots.PushBack(EES_Boots);
	itemSlots.PushBack(EES_Pants);
	itemSlots.PushBack(EES_Gloves);
	itemSlots.PushBack(EES_RangedWeapon);
	itemSlots.PushBack(EES_Bolt);
	itemSlots.PushBack(EES_Potion1);
	itemSlots.PushBack(EES_Potion2);
	itemSlots.PushBack(EES_Potion3);
	itemSlots.PushBack(EES_Potion4);
	itemSlots.PushBack(EES_Petard1);
	itemSlots.PushBack(EES_Petard2);
	itemSlots.PushBack(EES_Quickslot1);
	itemSlots.PushBack(EES_Quickslot2);
	itemSlots.PushBack(EES_Mask);

	return itemSlots;
}

function wolven_getHorseItemSlots() : array<EEquipmentSlots> 
{
	var itemSlots: array<EEquipmentSlots>;

	itemSlots.PushBack(EES_HorseBlinders);
	itemSlots.PushBack(EES_HorseSaddle);
	itemSlots.PushBack(EES_HorseBag);
	itemSlots.PushBack(EES_HorseTrophy);

	return itemSlots;
}

function wolven_unequipAllSlots() 
{
	var i: int;
	var item: SItemUniqueId;
	var itemSlots: array<EEquipmentSlots>;

	itemSlots = wolven_getItemSlots();
	
	for (i=0; i<itemSlots.Size(); i+=1) 
	{
		GetWitcherPlayer().GetInventory().GetItemEquippedOnSlot(itemSlots[i], item);
		
		GetWitcherPlayer().UnequipItemFromSlot(itemSlots[i]);
	}
	
	itemSlots = wolven_getHorseItemSlots();
	
	for (i=0; i<itemSlots.Size(); i+=1)
		GetWitcherPlayer().HorseUnequipItem(itemSlots[i]);

}

function wolven_saveSkills() : string
{
	var i: int;
	var skillLevel: int;
	var skills: array<SSkill>;
	var skillSlots: array<SSkillSlot>;
	var abMgr : W3PlayerAbilityManager;
	var skill: ESkill;
	var toReturn : string;
	
	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
	skills = abMgr.GetPlayerSkills();
	skillSlots = abMgr.GetSkillSlots();
	
	toReturn += "skills ";

	// save skills
	for(i = 0; i < skills.Size(); i += 1)
	{
		skillLevel = skills[i].level;
		toReturn += skillLevel;
		toReturn += " ";
	}

	return toReturn;
}

function wolven_saveSkillSlots() : string
{
	var i: int;
	var skillSlots: array<SSkillSlot>;
	var abMgr : W3PlayerAbilityManager;
	var skill: ESkill;
	var toReturn : string;
	
	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
	skillSlots = abMgr.GetSkillSlots();
	
	toReturn += "skillslots ";

	// save skill slots
	for(i = 0; i < skillSlots.Size(); i += 1)
	{
		abMgr.GetSkillOnSlot(i, skill);
		toReturn += SkillEnumToName(skill);
		toReturn += " ";
	}

	return toReturn;
}

function wolven_saveEquippedMutation() : string
{
	var i: int;
	var abMgr : W3PlayerAbilityManager;
	var mutation: int;
	var toReturn : string;
	
	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
	
	toReturn += "mutation ";

	// save equipped mutation
	mutation = abMgr.GetEquippedMutationType();

	toReturn += mutation;
	toReturn += " ";

	return toReturn;
}

function wolven_saveMutationData() : string
{
	var i: int;
	var abMgr : W3PlayerAbilityManager;
	var mutation: int;
	var mutations: array<SMutation>;
	var toReturn : string;
	
	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
	
	toReturn += "mutationdata ";

	// save mutation data
	mutations = abMgr.GetMutations();
	for(i = 0; i < mutations.Size(); i += 1)
	{
		mutation = mutations[i].type;
		if(abMgr.IsMutationResearched(mutation))
		{
			toReturn += mutation;
		}
		else
		{
			toReturn += "-1";
		}
		toReturn += " ";
	}

	return toReturn;
}

function wolven_saveItems() : string
{
	var i: int;
	var items: array<SItemUniqueId>;
	var allItems: array<SItemUniqueId>;
	var itemName: string;
	var itemSlot: int;
	var toReturn : string;

	toReturn += "items ";
	
	// save items
	items = GetWitcherPlayer().GetEquippedItems();
	GetWitcherPlayer().GetInventory().GetAllItems(allItems);
	
	for(i = 0; i < items.Size(); i +=1)
	{
		itemName = GetWitcherPlayer().GetInventory().GetItemName(items[i]);
		itemSlot = GetWitcherPlayer().GetItemSlot(items[i]);

		if(itemName != "None")
		{
			toReturn += "woitem ";
			toReturn += itemName;
			toReturn += " ";
			toReturn += "woslot ";
			toReturn += itemSlot;
			toReturn += " ";
		}
	}
	
	// save horse items
	itemName = wolven_getEquippedHorseItem(26);
	toReturn += "wohorse0 ";
	toReturn += itemName;
	toReturn += " ";
	
	itemName = wolven_getEquippedHorseItem(27);
	toReturn += "wohorse1 ";
	toReturn += itemName;
	toReturn += " ";
	
	itemName = wolven_getEquippedHorseItem(28);
	toReturn += "wohorse2 ";
	toReturn += itemName;
	toReturn += " ";
	
	itemName = wolven_getEquippedHorseItem(29);
	toReturn += "wohorse3 ";
	toReturn += itemName;
	toReturn += " ";

	return toReturn;
}

function wolven_GetCharAt(input : string, index : int) : string
{
    if (index >= 0 && index < StrLen(input))
        return StrMid(input, index, 1);
    
    return "";
}

exec function wolven_loadSkills(val : string)
{
	var i: int;
	var skillLevel: int;
	var skills: array<SSkill>;
	var abMgr : W3PlayerAbilityManager;

	theGame.getWolvenTrainer().restoreOutfitInternal();
	wolven_resetCharacterMenu();
	wolven_unequipAllSlots();

	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
	skills = abMgr.GetPlayerSkills();
	
	for(i = 0; i < skills.Size(); i += 1)
	{		
		skillLevel = StringToInt(wolven_GetCharAt(val, i));

		LogChannel('skill', skillLevel);
		
		if(skillLevel == 1)
		{
			abMgr.AddSkill(skills[i].skillType, false);
		}
		else if(skillLevel == 2)
		{
			abMgr.AddSkill(skills[i].skillType, false);
			abMgr.AddSkill(skills[i].skillType, false);
		}
		else if(skillLevel == 3)
		{
			abMgr.AddSkill(skills[i].skillType, false);
			abMgr.AddSkill(skills[i].skillType, false);
			abMgr.AddSkill(skills[i].skillType, false);
		}
	}
}

exec function wolven_loadEquippedMutation(mutation : int)
{
	var abMgr : W3PlayerAbilityManager;
	
	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
	abMgr.SetEquippedMutation(mutation);
}

exec function wolven_loadSkillSlot(val : name, i : int)
{
	var abMgr : W3PlayerAbilityManager;
	var skillEnum: int;
	
	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;

	skillEnum = SkillNameToEnum(val);
	abMgr.EquipSkill(skillEnum, i);
}

exec function wolven_equipItem(val : name, slot : int)
{
	var itemId: SItemUniqueId;
	
	itemId = wolven_getFirstUnequippedItem(val);
	if(itemId != GetInvalidUniqueId())
	{
		GetWitcherPlayer().EquipItem(itemId, slot);
		return;
	}
	
	// try to retrieve from stash if no item in inv
	itemId = wolven_getStashedInventoryItem(NameToString(val));
	if(itemId != GetInvalidUniqueId())
	{
		itemId = GetWitcherPlayer().GetHorseManager().MoveItemFromHorse(itemId, 1);
		GetWitcherPlayer().EquipItem(itemId, slot);
	}
}

exec function wolven_equipHorseItem(val : name)
{
	wolven_equipHorseItemInt(NameToString(val));
}

exec function wolven_developMutation(val : int)
{
	var abMgr : W3PlayerAbilityManager;
	var mutation: int;
	
	abMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
	
	if(val != -1)
	{
		abMgr.DEBUG_DevelopAndEquipMutation(val);
	}
}

exec function wolven_alertBuildLoaded()
{
	GetWitcherPlayer().DisplayHudMessage("Build loaded!");
}

function wolven_saveTheBuild()
{	
	var factName: string;
	var toPrint : string;
	
	toPrint += wolven_saveSkills();
	toPrint += wolven_saveSkillSlots();
	toPrint += wolven_saveEquippedMutation();
	toPrint += wolven_saveMutationData();
	toPrint += wolven_saveItems();
	toPrint += "endbuild";

	LogChannel('WOLVEN TRAINER', "SAVEBUILD|" + toPrint);
}

exec function wolven_savebuild()
{
	wolven_saveTheBuild();
}

exec function wolven_resetbuild()
{
	wolven_resetCharacterMenu();
}

exec function wolven_resetMutations()
{
	GetWitcherPlayer().ResetMutationsDev();
}