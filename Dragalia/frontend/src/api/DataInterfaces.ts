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
  owned: number;
  wanted: number;
}

//material related data
export interface MaterialData {
  materialId: string;
  material: string;
  category: string;
  sortPath: string;
}

export interface MaterialCategoryData {
  category: string;
  materials: MaterialData[];
}

export interface MaterialQuestData {
  materialId: string;
  questId: number;
  material: MaterialData;
  quest: QuestData;
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
  dragon?: DragonData;
}

//wyrmprints
export interface AbilityData {
  ability: string;
}

export interface WyrmprintData {
  wyrmprintId: number;
  wyrmprint: string;
  rarity: number;
  affinity?: string;
  abilities: AbilityData[];
}

export interface AccountWyrmprintData {
  wyrmprintId: number;
  wyrmprintLevel: number;
  wyrmprintLevelWanted: number;
  unbind: number;
  unbindWanted: number;
  copies: number;
  copiesWanted: number;
  wyrmprint?: WyrmprintData;
}

export interface WyrmprintLimit {
  rarity: number;
  level: number;
}

//quests
export interface QuestData {
  questId: number;
  quest: string;
  sortPath: string;
}

//chests
export interface ChestDropData {
  chestDropId: number;
  materialId: string;
  material?: MaterialData;
  quantity: number;
}

export interface ChestData {
  chestId: number;
  questId: number;
  quest?: QuestData;
  chestDrops: ChestDropData[];
}

export interface ChestGroupData {
  chestGroupId: number;
  chestGroup: string;
  frequency: string;
  quantity: number;
  chests: ChestData[];
}

//save/load
export interface SaveData {
  adventurers: AccountAdventurerData[];
  dragons: AccountDragonData[];
  facilities: AccountFacilityData[];
  inventory: AccountInventoryData[];
  passives: AccountPassiveData[];
  weapons: AccountWeaponData[];
  wyrmprints: AccountWyrmprintData[];
}
