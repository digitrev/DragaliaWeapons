import {
  AdventurerData,
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
import adventurersJson from '../data/Public/Adventurers.json';
import dragonsJson from '../data/Public/Dragons.json';
import elementsJson from '../data/Public/Elements.json';
import facilitiesJson from '../data/Public/Facilities.json';
import facilityLimitsJson from '../data/Public/FacilityLimits.json';
import materialsJson from '../data/Public/Materials.json';
import materialQuestsJson from '../data/Public/MaterialQuests.json';
import passivesJson from '../data/Public/Passives.json';
import questsJson from '../data/Public/Quests.json';
import weaponsJson from '../data/Public/Weapons.json';
import weaponLimitsJson from '../data/Public/WeaponLimits.json';
import weaponSeriesJson from '../data/Public/WeaponSeries.json';
import weaponTypesJson from '../data/Public/WeaponTypes.json';
import wyrmprintLevelLimitsJson from '../data/Public/WyrmprintLevelLimits.json';
import wyrmprintsJson from '../data/Public/Wyrmprints.json';

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
}
