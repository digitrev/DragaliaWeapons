//weapon related data
export interface AccountWeaponData {
  weaponId: number;
  copies: number;
  copiesWanted: number;
  weaponLevel: number;
  weaponLevelWanted: number;
  unbind: number;
  unbindWanted: number;
  refine: number;
  refineWanted: number;
  slot: number;
  slotWanted: number;
  dominion: number;
  dominionWanted: number;
  bonus: number;
  bonusWanted: number;
  weapon?: WeaponData;
}

export interface WeaponData {
  weaponId: number;
  weapon: string;
  weaponSeries: string;
  weaponType: string;
  rarity: number;
  element: string;
}

export interface ElementData {
  elementId: number;
  element: string;
}

export interface WeaponTypeData {
  weaponTypeId: number;
  weaponType: string;
}

export interface WeaponSeriesData {
  weaponSeriesId: number;
  weaponSeries: string;
}

//weapon limits
export interface WeaponUnbindLimit {
  weaponRarity: number;
  refinementLevel: number;
  maxUnbindLevel: number;
}

export interface WeaponLevelLimit {
  weaponRarity: number;
  unbindLevel: number;
  maxWeaponLevel: number;
}

export interface WeaponLimit {
  weaponID: number;
  level: number;
  unbind: number;
  refinement: number;
  slots: number;
  dominion: number;
  bonus: number;
}

//Passives
export interface PassiveData {
  passiveId: number;
  abilityNumber: number;
  ability: string;
  element: string;
  weaponType: string;
}

export interface PassiveGroupData {
  element: string;
  weaponType: string;
  passives: PassiveData[];
}

export interface AccountPassiveData {
  passiveId: number;
  owned: boolean;
  wanted: boolean;
  passive?: PassiveData;
}

export interface AccountPassiveGroupData {
  element: string;
  weaponType: string;
  passives: AccountPassiveData[];
}

//material related data
export interface MaterialData {
  materialId: string;
  material: string;
  category: string;
}

export interface MaterialCategoryData {
  category: string;
  materials: MaterialData[];
}

export interface AccountInventoryData {
  materialId: string;
  quantity: number;
  material?: MaterialData;
}

export interface InventoryCategoryData {
  category: string;
  items: AccountInventoryData[];
}

export interface MaterialCosts {
  product: string;
  material: MaterialData;
  quantity: number;
}

//facility related data
export interface FacilityData {
  facilityId: number;
  facility: string;
  limit: number;
  category: string;
}

export interface FacilityCategoryData {
  category: string;
  facilities: FacilityData[];
}

export interface AccountFacilityCategoryData {
  category: string;
  accountFacilities: AccountFacilityData[];
}

export interface AccountFacilityData {
  facilityId: number;
  copyNumber: number;
  currentLevel: number;
  wantedLevel: number;
  facility?: FacilityData;
}

export interface FacilityLimit {
  facilityID: number;
  maxLevel: number;
}

//Adventurers
export interface AdventurerData {
  adventurerId: number;
  adventurer: string;
  rarity: number;
  element: string;
  weaponType: string;
  mcLimit: number;
}

export interface AccountAdventurerData {
  adventurerId: number;
  currentLevel: number;
  wantedLevel: number;
  adventurer?: AdventurerData;
}

//dragons
export interface DragonData {
  dragonId: number;
  dragon: string;
  rarity: number;
  element: string;
}

export interface AccountDragonData {
  dragonId: number;
  unbind: number;
  unbindWanted: number;
  dragon: DragonData;
}

//wyrmprints
export interface WyrmprintData {
  wyrmprintId: number;
  wyrmprint: string;
  rarity: number;
  affinity: string;
  abilities: string[];
}

export interface AccountWyrmprintData {
  wyrmprintId: number;
  wyrmprintLevel: number;
  wyrmprintLevelWanted: number;
  unbind: number;
  unbindWanted: number;
  copies: number;
  copiesWanted: number;
  wyrmprint: WyrmprintData;
}
