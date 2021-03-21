import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import {
  AdventurerData,
  ElementData,
  FacilityData,
  MaterialData,
  PassiveData,
  WeaponData,
  WeaponLevelLimit,
  WeaponLimit,
  WeaponSeriesData,
  WeaponTypeData,
  WeaponUnbindLimit,
} from './DataInterfaces';

export class PublicApi extends HttpClient {
  public constructor() {
    super(webAPIUrl);
  }

  //weapon api
  public getWeapons = () => this.instance.get<WeaponData[]>('/WeaponList');

  public getWeapon = (id: number) =>
    this.instance.get<WeaponData>(`/Weapons/${id}`);

  public getElements = () => this.instance.get<ElementData[]>('/Elements');

  public getWeaponTypes = () =>
    this.instance.get<WeaponTypeData[]>('/WeaponTypes');

  public getWeaponSeries = () =>
    this.instance.get<WeaponSeriesData[]>('/WeaponSeries');

  //weapon limits
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

  public getWeaponLimits = (weaponID: number) =>
    this.instance.get<WeaponLimit>(`/WeaponLimits/${weaponID}`);

  public getAllWeaponLimits = () =>
    this.instance.get<WeaponLimit[]>('/WeaponLimits');

  //passive apis
  public getPassives = () => this.instance.get<PassiveData[]>('/Passives');

  public getPassive = (passiveID: number) =>
    this.instance.get<PassiveData>(`/api/Passives/${passiveID}`);

  //material api
  public getMaterials = () =>
    this.instance.get<MaterialData[]>('/MaterialList');

  public getMaterial = (id: string) =>
    this.instance.get<MaterialData>(`/MaterialList/${id}`);

  //facility api
  public getFacilities = () =>
    this.instance.get<FacilityData[]>('/FacilityList');

  public getFacility = (id: number) =>
    this.instance.get<FacilityData>(`/FacilityList/${id}`);

  //adventurers
  public getAdventurers = () =>
    this.instance.get<AdventurerData[]>('/Adventurers');
}
