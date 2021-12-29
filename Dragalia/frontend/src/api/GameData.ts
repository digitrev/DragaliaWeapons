import {
  AdventurerData,
  ChestGroupData,
  DragonData,
  ElementData,
  FacilityData,
  FacilityLimit,
  MaterialData,
  MaterialQuestData,
  PassiveData,
  QuestData,
  WeaponData,
  WeaponLimit,
  WeaponSeriesData,
  WeaponTypeData,
  WyrmprintData,
  WyrmprintLimit,
} from './DataInterfaces';
import adventurersJson from '../data/Game/Adventurers.json';
import chestGroupJson from '../data/Game/ChestGroups.json';
import dragonsJson from '../data/Game/Dragons.json';
import elementsJson from '../data/Game/Elements.json';
import facilitiesJson from '../data/Game/Facilities.json';
import facilityLimitsJson from '../data/Game/FacilityLimits.json';
import materialsJson from '../data/Game/Materials.json';
import materialQuestsJson from '../data/Game/MaterialQuests.json';
import passivesJson from '../data/Game/Passives.json';
import questsJson from '../data/Game/Quests.json';
import weaponsJson from '../data/Game/Weapons.json';
import weaponLimitsJson from '../data/Game/WeaponLimits.json';
import weaponSeriesJson from '../data/Game/WeaponSeries.json';
import weaponTypesJson from '../data/Game/WeaponTypes.json';
import wyrmprintLevelLimitsJson from '../data/Game/WyrmprintLevelLimits.json';
import wyrmprintsJson from '../data/Game/Wyrmprints.json';
import { ensure } from './HelperFunctions';

export class PublicApi {
  //adventurers
  public getAdventurers = (): AdventurerData[] => adventurersJson;

  //dragons
  public getDragons = (): DragonData[] => dragonsJson;

  //elements
  public getElements = (): ElementData[] => elementsJson;

  //facilities
  public getFacilities = (): FacilityData[] => facilitiesJson;

  //facility limits
  public getAllFacilityLimits = (): FacilityLimit[] => facilityLimitsJson;

  //materials
  public getMaterials = (): MaterialData[] => materialsJson;

  public getMaterial = (materialID: string): MaterialData =>
    ensure(materialsJson.find((m) => m.materialId === materialID));

  public getMaterialQuests = (): MaterialQuestData[] => materialQuestsJson;

  public getMaterialQuestsFilter = (materialIDs: string[]) =>
    this.getMaterialQuests().filter((mq) =>
      materialIDs.some((m) => m === mq.materialId),
    );

  //passive apis
  public getPassives = (): PassiveData[] => passivesJson;

  //quests
  public getQuests = (): QuestData[] => questsJson;

  //weapon limits
  public getAllWeaponLimits = (): WeaponLimit[] => weaponLimitsJson;

  //weapons
  public getWeapons = (): WeaponData[] => weaponsJson;

  //weapon series
  public getWeaponSeries = (): WeaponSeriesData[] => weaponSeriesJson;

  //weapon types
  public getWeaponTypes = (): WeaponTypeData[] => weaponTypesJson;

  //wyrmprints
  public getWyrmprints = (): WyrmprintData[] => wyrmprintsJson;

  public getWyrmprintLimits = (): WyrmprintLimit[] => wyrmprintLevelLimitsJson;

  //chests
  public getChestGroups = (): ChestGroupData[] => chestGroupJson;
}
