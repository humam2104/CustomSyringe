class CustomSyringeHealingBase extends KFWeap_HealerBase;
		

	
	var float CustomSyringeStandAloneHealAmount;
	var float CustomSyringeOthersHealAmount;
			
	var float CustomSyringeHealSelfRechargeSeconds;
	var float CustomSyringeHealOthersRechargeSeconds;
		
function GetSyringeConfig(){
		CustomSyringeStandAloneHealAmount = class'CustomSyringeMutator'.default.CustomSyringeStandAloneHealAmount;
		CustomSyringeOthersHealAmount = class'CustomSyringeMutator'.default.CustomSyringeOthersHealAmount;
		CustomSyringeHealSelfRechargeSeconds = class'CustomSyringeMutator'.default.CustomSyringeHealSelfRechargeSeconds;
		CustomSyringeHealOthersRechargeSeconds = class'CustomSyringeMutator'.default.CustomSyringeHealOthersRechargeSeconds;
}


/**
 * Initializes ammo counts, when weapon is spawned.
 * Overwriting to stop perks changing the magazine size
 * Probably have to add functionality when we add the medic perk
 */
function InitializeAmmo()
{
	GetSyringeConfig();
	// Set ammo amounts based on perk.  MagazineCapacity must be replicated, but
	// only the server needs to know the InitialSpareMags value
	MagazineCapacity[0] = default.MagazineCapacity[0];
	InitialSpareMags[0] = default.InitialSpareMags[0];

	AmmoCount[0] = MagazineCapacity[0];
	AddAmmo(InitialSpareMags[0] * MagazineCapacity[0]);
}

simulated function CustomFire() // Redeclared parent function to replace variables
{
	local float HealAmount;

	if( Role == ROLE_Authority )
	{
		// Healing a teammate
		if( CurrentFireMode == DEFAULT_FIREMODE )
		{
			HealAmount = CustomSyringeOthersHealAmount;															 
			HealTarget.HealDamage( HealAmount, Instigator.Controller, InstantHitDamageTypes[CurrentFireMode]);
			HealRechargeTime = CustomSyringeHealOthersRechargeSeconds;
		}
		// Healing Self
		else if( CurrentFireMode == ALTFIRE_FIREMODE )
		{
			if ( GetActivePlayerCount() < 2 )
			{
				HealAmount = CustomSyringeStandAloneHealAmount; 														// Replaced "StandAloneHealAmount" for solo with my own variable
			}
			else
			{
				HealAmount = CustomSyringeStandAloneHealAmount; 														// Replaced "StandAloneHealAmount" for solo with my own variable
			}
			Instigator.HealDamage(HealAmount, Instigator.Controller, InstantHitDamageTypes[CurrentFireMode]);
			HealRechargeTime = CustomSyringeHealSelfRechargeSeconds; 												// Replaced "HealSelfRechargeSeconds"
		}
	}
}

defaultproperties
{

	UIUpdateInterval=1.f
	FireTweenTime=0.3f
	HealingRangeSQ=23000.f
	StandAloneHealAmount=50
    ScreenUIClass=class'KFGFxWorld_HealerScreen'

	// Aim Assist
	AimCorrectionSize=0.f
	bTargetAdhesionEnabled=false

	// Heal Friendly
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponHealing
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Custom
	FireInterval(DEFAULT_FIREMODE)=+0.2
	InstantHitDamage(DEFAULT_FIREMODE)=20.0
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Healing'
	AmmoCost(DEFAULT_FIREMODE)=100
	HealAttemptWeakZedGrabCooldown=1.0

	// Heal Self
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponHealing
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Custom
	FireInterval(ALTFIRE_FIREMODE)=+2.0
	InstantHitDamage(ALTFIRE_FIREMODE)=20.0
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Healing'
	AmmoCost(ALTFIRE_FIREMODE)=100

	// Ammo
	MagazineCapacity[0]=100
	SpareAmmoCapacity[0]=0
	bCanBeReloaded=true
	bReloadFromMagazine=true
	bInfiniteSpareAmmo=true
	HealSelfRechargeSeconds=15
	HealOtherRechargeSeconds=7.5
	bAllowClientAmmoTracking=false

    // Inventory
	GroupPriority=6
	InventoryGroup=IG_Equipment

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_SA_Syringe.Play_WEP_SA_Syringe_3P_Fire_Single', FirstPersonCue=AkEvent'WW_WEP_SA_Syringe.Play_WEP_SA_Syringe_1P_Fire_Single')
	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_SA_Syringe.Play_WEP_SA_Syringe_3P_Fire_Single', FirstPersonCue=AkEvent'WW_WEP_SA_Syringe.Play_WEP_SA_Syringe_1P_Fire_Single')

	RechargeCompleteSound=AkEvent'WW_WEP_SA_Syringe.Play_WEP_SA_Syringe_Charged'

	AssociatedPerkClasses(0) = none

}

