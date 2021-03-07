import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import {
  ElementData,
  FacilityData,
  MaterialData,
  WeaponData,
  WeaponSeriesData,
  WeaponTypeData,
} from './DataInterfaces';

export class PublicApi extends HttpClient {
  public constructor() {
    super(webAPIUrl);
  }

  public getWeapons = () => this.instance.get<WeaponData[]>('/WeaponList');

  public getWeapon = (id: number) =>
    this.instance.get<WeaponData>(`/Weapons/${id}`);

  public getMaterials = () =>
    this.instance.get<MaterialData[]>('/MaterialList');

  public getMaterial = (id: string) =>
    this.instance.get<MaterialData>(`/MaterialList/${id}`);

  public getElements = () => this.instance.get<ElementData[]>('/Elements');

  public getWeaponTypes = () =>
    this.instance.get<WeaponTypeData[]>('/WeaponTypes');

  public getWeaponSeries = () =>
    this.instance.get<WeaponSeriesData[]>('/WeaponSeries');

  public getFacilities = () =>
    this.instance.get<FacilityData[]>('/FacilityList');

  public getFacility = (id: number) =>
    this.instance.get<FacilityData>(`/FacilityList/${id}`);
}
