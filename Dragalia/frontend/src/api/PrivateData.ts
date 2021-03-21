import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import {
  AccountAdventurerData,
  AccountFacilityData,
  AccountInventoryData,
  AccountPassiveData,
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

  public getWeapon = (weaponID: number) =>
    this.instance.get<AccountWeaponData>(`/AccountWeapons/${weaponID}`);

  public getUntrackedWeapons = () =>
    this.instance.get<WeaponData[]>('/AccountWeapons/untracked');

  public putWeapon = (weaponID: number, weapon: AccountWeaponData) =>
    this.instance.put(`/AccountWeapons/${weaponID}`, weapon);

  public getWeaponCosts = (weaponID?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountWeapons/costs', {
      params: {
        weaponID: weaponID,
      },
    });

  //Passives
  public getPassives = () =>
    this.instance.get<AccountPassiveData[]>('AccountPassives');

  public getPassive = (passiveID: number) =>
    this.instance.get<AccountPassiveData>(`/AccountPassives/${passiveID}`);

  public putPassive = (passiveID: number, passive: AccountPassiveData) =>
    this.instance.put(`/AccountPassives/${passiveID}`, passive);

  public getPassiveCosts = (passiveID?: number) =>
    this.instance.get<MaterialCosts[]>('AccountPassives/costs', {
      params: {
        passiveID: passiveID,
      },
    });

  //Inventory
  public getInventory = () =>
    this.instance.get<AccountInventoryData[]>('/AccountInventories');

  public getItem = (materialID: string) =>
    this.instance.get<AccountInventoryData>(
      `/AccountInventories/${materialID}`,
    );

  public getItemFilter = (materialIDs: string[]) =>
    this.instance.get<AccountInventoryData[]>(
      `/AccountInventories?materials=${materialIDs.reduce(
        (acc, cur) => `${cur},${acc}`,
        '',
      )}`,
    );

  public putItem = (materialID: string, item: AccountInventoryData) =>
    this.instance.put(`/AccountInventories/${materialID}`, item);

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

  public getFacilityCosts = (facilityID?: number, copyNumber?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountFacilities/costs', {
      params: {
        facilityID: facilityID,
        copyNumber: copyNumber,
      },
    });

  //adventurers
  public getAdventurers = () =>
    this.instance.get<AccountAdventurerData[]>('/AccountAdventurers');

  public getAdventurer = (adventurerID: number) =>
    this.instance.get<AccountAdventurerData>(
      `/AccountAdventurers/${adventurerID}`,
    );

  public putAdventurer = (
    adventurerID: number,
    adventurer: AccountAdventurerData,
  ) => this.instance.put(`/AccountAdventurers/${adventurerID}`, adventurer);

  public postAdventurer = (adventurer: AccountAdventurerData) =>
    this.instance.post('/AccountAdventurer', adventurer);

  public deleteAdventurer = (adventurerID: number) =>
    this.instance.delete(`/AccountAdventurers/${adventurerID}`);

  public getAdventurerCosts = (adventurerID?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountAdventurers/costs', {
      params: {
        adventurerID: adventurerID,
      },
    });
}
