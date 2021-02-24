import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import { MaterialData, WeaponData } from './DataInterfaces';

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
