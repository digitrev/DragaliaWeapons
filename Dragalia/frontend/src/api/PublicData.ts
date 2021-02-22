import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';

export interface WeaponData {
  weaponId: number;
  weapon1: string;
  weaponSeries: string;
  weaponType: string;
  rarity: number;
  element: string;
}

export interface MaterialData {
  materialId: string;
  material1: string;
  category: string;
  active: boolean;
}

export class PublicApi extends HttpClient {
  public constructor() {
    super(webAPIUrl);
  }

  public getWeapons = () => this.instance.get<WeaponData[]>('/Weapons');

  public getWeapon = (id: number) =>
    this.instance.get<WeaponData>(`/Weapons/${id}`);
}
