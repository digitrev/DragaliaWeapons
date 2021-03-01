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
  bonus: number;
  bonusWanted: number;
  weapon?: WeaponData;
}

export interface DisplayWeaponData extends AccountWeaponData {
  display: boolean;
}

export interface WeaponData {
  weaponId: number;
  weapon: string;
  weaponSeries: string;
  weaponType: string;
  rarity: number;
  element: string;
}

export interface MaterialData {
  materialId: string;
  material: string;
  category: string;
}

export interface CategoryData {
  category: string;
  materials: MaterialData[];
}

export interface InventoryCategoryData {
  category: string;
  items: AccountInventoryData[];
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

export interface AccountInventoryData {
  materialId: string;
  quantity: number;
  material?: MaterialData;
}
