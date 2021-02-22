import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';

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
}
