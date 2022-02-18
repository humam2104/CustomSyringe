class CustomSyringeMutator extends KFMutator
		config(CustomSyringe);
	var class<KFWeapon> CustomHealingSyringe;
	var config bool bConfigsInit;

	//Healing Vars
	var config float CustomSyringeStandAloneHealAmount;
	var config float CustomSyringeOthersHealAmount;

	//Recharge Vars
	var config float CustomSyringeHealSelfRechargeSeconds;
	var config float CustomSyringeHealOthersRechargeSeconds;

function ConfigCheck()
	{
		if (bConfigsInit == false)
		{
			bConfigsInit = true;
			CustomSyringeStandAloneHealAmount = 35;
			CustomSyringeOthersHealAmount = 35;
			CustomSyringeHealSelfRechargeSeconds = 10;
			CustomSyringeHealOthersRechargeSeconds = 10;
			saveconfig();
			`log("CustomSyringe:- Config Saved Succesfully!");
		}
		else if (bConfigsInit)
		{
			`log("CustomSyringe:- Config File Found!");			
		}
	}

function InitMutator(string Options, out string ErrorMessage)
{

	super.InitMutator( Options, ErrorMessage );
	`log("Custom Syringe mutator initialized");
	
	ConfigCheck();
	
}

function PostBeginPlay()
{
		Super.PostBeginPlay();
		
		if (WorldInfo.Game.BaseMutator == None)
			WorldInfo.Game.BaseMutator = Self;
		else
			WorldInfo.Game.BaseMutator.AddMutator(Self);

}

function AddMutator(Mutator M)
{
	if (M != Self)
	{
		if (M.Class == Class)
			M.Destroy();
		else
			Super.AddMutator(M);
	}
} 
	
	function ReplaceSyringe(Pawn P)
	{
		local KFInventoryManager KFIM;
		local KFWeapon OriginalSyringe;
		
		KFIM = KFInventoryManager(KFPawn(P).InvManager);
		
		if (KFIM != none)
		{
				KFIM.GetWeaponFromClass(OriginalSyringe, 'KFWeap_Healer_Syringe'); 					// Assigns the "BabySyringe" name to the original syringe.

				if (CustomHealingSyringe != none) 
				{
					KFIM.CreateInventory(CustomHealingSyringe /*, false*/);
					LogInternal("=== CustomSyringe === Added the real syringe");
				} 																				// If the real solo syringe doesn't exist, then create it

				if (OriginalSyringe != none)
				{
					KFIM.ServerRemoveFromInventory(OriginalSyringe);
					LogInternal("=== CustomSyringe === Removed Original syringe");
				}

		}
	}
	

// APPLY SYRINGE REPLACEMENT FUNCTION TO PLAYER

	function ModifyPlayer(Pawn P) 															 	// Function to modify the player
	{
		Super.ModifyPlayer(P);
		
		if (P != none)
			ReplaceSyringe(P); 																	// This calls the ReplaceSyringe function defined just above if a player exists.
	}
	

	
	
	defaultproperties
	{
		CustomHealingSyringe = class'CustomSyringe.CustomHealingSyringe'
	}

	


