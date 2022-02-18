class CystomHealingSyringeDef extends KFWeaponDefinition
	abstract; // This file primarily sets the class path for the real solo syringe. This path is used at the bottom of the mutator file's default properties and is critical to its functions replacing the default syringe. You can edit the path below, but don't forget to alter the mutator file's referencing to it as well.
	
	

DefaultProperties
{

	WeaponClassPath="CustomSyringe.CustomHealingSyringe"
	
	
	BuyPrice=1700
	AmmoPricePerMag=100
	ImagePath="ui_weaponselect_tex.UI_WeaponSelect_Healer"
	
}