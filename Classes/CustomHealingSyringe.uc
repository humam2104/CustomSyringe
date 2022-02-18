class CustomHealingSyringe extends CustomSyringeHealingBase;


defaultproperties
{
	PlayerViewOffset=(X=20.0,Y=10,Z=-8)

	// Content
	PackageKey="Healer"
	FirstPersonMeshName="WEP_1P_Healer_MESH.Wep_1stP_Healer_Rig"
	FirstPersonAnimSetNames(0)="WEP_1P_Healer_ANIM.Wep_1st_Healer_Anim"
	AttachmentArchetypeName="WEP_Healer_ARCH.Wep_Healer_3P"

	Begin Object Name=FirstPersonMesh
		Animations=AnimTree'CHR_1P_Arms_ARCH.WEP_1stP_Animtree_Healer'
	End Object

	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_MedicDart'
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_MedicDart'
	
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_Healer'
	
	//Grouping
	GroupPriority=6
	WeaponSelectTexture=Texture2D'ui_weaponselect_tex.UI_WeaponSelect_Healer'

	bCanThrow=false
	bDropOnDeath=false
	bStorePreviouslyEquipped=false
}