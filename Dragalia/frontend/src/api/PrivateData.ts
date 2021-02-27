import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import {
  AccountInventoryData,
  AccountWeaponData,
  WeaponData,
} from './DataInterfaces';

export class PrivateApi extends HttpClient {
  public constructor() {
    super(webAPIUrl);
  }

  public getWeapons = () =>
    this.instance.get<AccountWeaponData[]>('/AccountWeapons');

  public getWeapon = (id: number) =>
    this.instance.get<AccountWeaponData>(`/AccountWeapons/${id}`);

  public getUntrackedWeapons = () =>
    this.instance.get<WeaponData[]>('/AccountWeapons/untracked');

  public postWeapon = (weapon: AccountWeaponData) =>
    this.instance.post<AccountWeaponData>(`/AccountWeapons`, weapon);

  public putWeapon = (id: number, weapon: AccountWeaponData) =>
    this.instance.put(`/AccountWeapons/${id}`, weapon);

  public getInventory = () =>
    this.instance.get<AccountInventoryData[]>('/AccountInventories');

  public getItem = (id: string) =>
    this.instance.get<AccountInventoryData>(`/AccountInventories/${id}`);

  public putItem = (id: string, item: AccountInventoryData) =>
    this.instance.put(`/AccountInventories/${id}`, item);
}
