import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
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
  WeaponLevelLimit,
  WeaponLimit,
  WeaponSeriesData,
  WeaponTypeData,
  WeaponUnbindLimit,
  WyrmprintData,
  WyrmprintLimit,
} from './DataInterfaces';

export class PublicApi extends HttpClient {
  public constructor() {
    super(webAPIUrl);
  }

  //adventurers
  public getAdventurers = () =>
    this.instance.get<AdventurerData[]>('/Adventurers');

  public getAdventurer = (adventurerID: number) =>
    this.instance.get<AdventurerData>(`/Adventurers/${adventurerID}`);

  //dragons
  public getDragons = () => this.instance.get<DragonData[]>('/Dragons');

  public getDragon = (dragonID: number) =>
    this.instance.get<DragonData>(`/Dragons/${dragonID}`);

  //elements
  public getElements = () => this.instance.get<ElementData[]>('/Elements');

  //facilities
  public getFacilities = () =>
    this.instance.get<FacilityData[]>('/FacilityList');

  public getFacility = (facilityID: number) =>
    this.instance.get<FacilityData>(`/FacilityList/${facilityID}`);

  //facility limits
  public getAllFacilityLimits = () =>
    this.instance.get<FacilityLimit[]>('/FacilityLimits');

  public getFacilityLimits = (facilityID: number) =>
    this.instance.get<FacilityLimit>(`/FacilityLimits/${facilityID}`);

  //materials
  public getMaterials = () =>
    this.instance.get<MaterialData[]>('/MaterialList');

  public getMaterial = (materialID: string) =>
    this.instance.get<MaterialData>(`/MaterialList/${materialID}`);

  public getMaterialQuests = (materialID?: string) =>
    this.instance.get<MaterialQuestData[]>('/MaterialList/quests', {
      params: {
        materialID: materialID,
      },
    });

  //passive apis
  public getPassives = () => this.instance.get<PassiveData[]>('/Passives');

  public getPassive = (passiveID: number) =>
    this.instance.get<PassiveData>(`/Passives/${passiveID}`);

  //quests
  public getQuests = () => this.instance.get<QuestData[]>('/Quests');

  public getQuest = (questID: number) =>
    this.instance.get<QuestData>(`/Quests/${questID}`);

  //weapon limits
  public getAllWeaponLimits = () =>
    this.instance.get<WeaponLimit[]>('/WeaponLimits');

  public getWeaponLimits = (weaponID: number) =>
    this.instance.get<WeaponLimit>(`/WeaponLimits/${weaponID}`);

  public getWeaponUnbindLimits = (rarity?: number) =>
    this.instance.get<WeaponUnbindLimit[]>('/WeaponLimits/unbind', {
      params: {
        rarity: rarity,
      },
    });

  public getWeaponLevelLimits = (rarity?: number) =>
    this.instance.get<WeaponLevelLimit[]>('/WeaponLimits/level', {
      params: {
        rarity: rarity,
      },
    });

  //weapons
  public getWeapons = () => this.instance.get<WeaponData[]>('/WeaponList');

  public getWeapon = (id: number) =>
    this.instance.get<WeaponData>(`/WeaponList/${id}`);

  //weapon series
  public getWeaponSeries = () =>
    this.instance.get<WeaponSeriesData[]>('/WeaponSeries');

  //weapon types
  public getWeaponTypes = () =>
    this.instance.get<WeaponTypeData[]>('/WeaponTypes');

  //wyrmprints
  public getWyrmprints = () =>
    this.instance.get<WyrmprintData[]>('/Wyrmprints');

  public getWyrmprint = (wyrmprintID: number) =>
    this.instance.get<WyrmprintData>(`/Wyrmprints/${wyrmprintID}`);

  public getWyrmprintLimits = () =>
    this.instance.get<WyrmprintLimit[]>('/WyrmprintLevelLimits');

  public getWyrmprintLimitByRarity = (rarity: number) =>
    this.instance.get<WyrmprintLimit[]>(`/WyrmprintLevelLimits/${rarity}`);
}
