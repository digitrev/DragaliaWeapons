import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import {
  AccountFacilityData,
  AccountInventoryData,
  AccountWeaponData,
  MaterialCosts,
  WeaponData,
} from './DataInterfaces';

export class PrivateApi extends HttpClient {
  public constructor() {
    super(webAPIUrl);
  }

  //Weapons
  public getWeapons = () =>
    this.instance.get<AccountWeaponData[]>('/AccountWeapons');

  public getWeapon = (id: number) =>
    this.instance.get<AccountWeaponData>(`/AccountWeapons/${id}`);

  public getUntrackedWeapons = () =>
    this.instance.get<WeaponData[]>('/AccountWeapons/untracked');

  public postWeapon = (weapon: AccountWeaponData) =>
    this.instance.post<AccountWeaponData>(`/AccountWeapons`, weapon);

  public deleteWeapon = (id: number) =>
    this.instance.delete(`/AccountWeapons/${id}`);

  public putWeapon = (id: number, weapon: AccountWeaponData) =>
    this.instance.put(`/AccountWeapons/${id}`, weapon);

  // public getAllWeaponCosts = () => this.instance.get('/AccountWeapons/costs');

  public getWeaponCosts = (id?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountWeapons/costs', {
      params: {
        weaponId: id,
      },
    });

  //Inventory
  public getInventory = () =>
    this.instance.get<AccountInventoryData[]>('/AccountInventories');

  public getItem = (id: string) =>
    this.instance.get<AccountInventoryData>(`/AccountInventories/${id}`);

  public getItemFilter = (ids: string[]) =>
    this.instance.get<AccountInventoryData[]>(
      `/AccountInventories?materials=${ids.reduce(
        (acc, cur) => `${cur},${acc}`,
        '',
      )}`,
    );

  public putItem = (id: string, item: AccountInventoryData) =>
    this.instance.put(`/AccountInventories/${id}`, item);

  //Facilities
  public getFacilities = () =>
    this.instance.get<AccountFacilityData[]>('/AccountFacilities');

  public getFacility = (facilityID: number, copyNumber: number) =>
    this.instance.get<AccountFacilityData>(
      `/AccountFacilities/${facilityID}/${copyNumber}`,
    );

  public putFacility = (
    facilityID: number,
    copyNumber: number,
    facility: AccountFacilityData,
  ) =>
    this.instance.put(
      `/AccountFacilities/${facilityID}/${copyNumber}`,
      facility,
    );

  public getAllFacilityCosts = () =>
    this.instance.get<MaterialCosts[]>('/AccountFacilities/costs');

  public getFacilityCosts = (facilityID: number, copyNumber: number) =>
    this.instance.get<MaterialCosts[]>(
      `/AccountFacilities/costs/${facilityID}/${copyNumber}`,
    );
}
