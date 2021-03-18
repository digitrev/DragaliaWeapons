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