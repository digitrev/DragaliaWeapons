import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import { AccountWeaponData } from './DataInterfaces';

export class PrivateApi extends HttpClient {
  public constructor() {
    super(webAPIUrl);
  }

  public getWeapons = () =>
    this.instance.get<AccountWeaponData[]>('/AccountWeapons');

  public getWeapon = (id: number) =>
    this.instance.get<AccountWeaponData>(`/AccountWeapons/${id}`);

  public postWeapon = (weapon: AccountWeaponData) =>
    this.instance.post<AccountWeaponData>(`/AccountWeapons`);

  public putWeapon = (id: number, weapon: AccountWeaponData) =>
    this.instance.put(`/AccountWeapons/${id}`, weapon);
}
