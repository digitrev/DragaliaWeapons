import HttpClient from './HttpClient';
import { webAPIUrl } from '../AppSettings';
import {
  AccountAdventurerData,
  AccountDragonData,
  AccountFacilityData,
  AccountInventoryData,
  AccountPassiveData,
  AccountWeaponData,
  AccountWyrmprintData,
  MaterialCosts,
} from './DataInterfaces';
import { PublicApi } from './PublicData';
import Store from 'store';

export class PrivateApi extends HttpClient {
  public constructor(token: string) {
    super(webAPIUrl);
    this.instance.defaults.headers.common['Authorization'] = `Bearer ${token}`;
  }

  private readonly adv = 'adventurers';
  private readonly drg = 'dragons';
  private readonly fcl = 'facilities';
  private readonly inv = 'inventory';
  private readonly psv = 'passives';
  private readonly wpn = 'weapons';
  private readonly wpt = 'wyrmprints';

  //adventurers
  public getAdventurers = () => {
    const api = new PublicApi();
    return Store.get(
      this.adv,
      api.getAdventurers().map<AccountAdventurerData>((a) => ({
        adventurerId: a.adventurerId,
        currentLevel: 0,
        wantedLevel: 0,
        adventurer: a,
      })),
    ) as AccountAdventurerData[];
  };

  public putAdventurer = (
    adventurerID: number,
    adventurer: AccountAdventurerData,
  ) => {
    Store.set(
      this.adv,
      this.getAdventurers().map((a) =>
        a.adventurerId === adventurerID
          ? {
              ...a,
              wantedLevel: adventurer.wantedLevel,
              currentLevel: adventurer.currentLevel,
            }
          : a,
      ),
    );
  };

  public getAdventurerCosts = (adventurerID?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountAdventurers/costs', {
      params: {
        adventurerID: adventurerID,
      },
    });

  //dragons
  public getDragons = () => {
    const api = new PublicApi();
    return Store.get(
      this.drg,
      api.getDragons().map<AccountDragonData>((d) => ({
        dragonId: d.dragonId,
        dragon: d,
        unbind: 0,
        unbindWanted: 0,
      })),
    ) as AccountDragonData[];
  };

  public putDragon = (dragonID: number, dragon: AccountDragonData) => {
    Store.set(
      this.drg,
      this.getDragons().map((d) =>
        d.dragonId === dragonID
          ? {
              ...d,
              unbind: dragon.unbind,
              unbindWanted: dragon.unbindWanted,
            }
          : d,
      ),
    );
  };

  public getDragonCosts = (dragonID?: number) =>
    this.instance.get('/AccountDragons/costs', {
      params: {
        dragonID: dragonID,
      },
    });

  //facilities
  public getFacilities = () => {
    const api = new PublicApi();
    return Store.get(
      this.fcl,
      api.getFacilities().reduce<AccountFacilityData[]>((acc, cur) => {
        for (let i = 0; i < cur.limit; i++) {
          acc.push({
            facilityId: cur.facilityId,
            copyNumber: i + 1,
            currentLevel: 0,
            wantedLevel: 0,
            facility: cur,
          });
        }
        return acc;
      }, []),
    ) as AccountFacilityData[];
  };

  public putFacility = (
    facilityID: number,
    copyNumber: number,
    facility: AccountFacilityData,
  ) => {
    Store.set(
      this.fcl,
      this.getFacilities().map((f) =>
        f.facilityId === facilityID && f.copyNumber === copyNumber
          ? {
              ...f,
              currentLevel: facility.currentLevel,
              wantedLevel: facility.wantedLevel,
            }
          : f,
      ),
    );
  };

  public getFacilityCosts = (facilityID?: number, copyNumber?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountFacilities/costs', {
      params: {
        facilityID: facilityID,
        copyNumber: copyNumber,
      },
    });

  //Inventory
  public getInventory = () => {
    const api = new PublicApi();
    return Store.get(
      this.inv,
      api.getMaterials().map<AccountInventoryData>((m) => ({
        materialId: m.materialId,
        quantity: 0,
        material: m,
      })),
    ) as AccountInventoryData[];
  };

  public getItemFilter = (materialIDs: string[]) =>
    this.getInventory().filter((i) =>
      materialIDs.some((m) => m === i.materialId),
    );

  public putItem = (materialID: string, item: AccountInventoryData) => {
    Store.set(
      this.inv,
      this.getInventory().map((i) =>
        i.materialId === materialID
          ? {
              ...i,
              quantity: item.quantity,
            }
          : i,
      ),
    );
  };

  //Passives
  public getPassives = () => {
    const api = new PublicApi();
    return Store.get(
      this.psv,
      api.getPassives().map<AccountPassiveData>((p) => ({
        passiveId: p.passiveId,
        owned: false,
        wanted: false,
        passive: p,
      })),
    ) as AccountPassiveData[];
  };

  public putPassive = (passiveID: number, passive: AccountPassiveData) => {
    Store.set(
      this.psv,
      this.getPassives().map((p) =>
        p.passiveId === passiveID
          ? {
              ...p,
              owned: passive.owned,
              wanted: passive.wanted,
            }
          : p,
      ),
    );
  };

  public getPassiveCosts = (passiveID?: number) =>
    this.instance.get<MaterialCosts[]>('AccountPassives/costs', {
      params: {
        passiveID: passiveID,
      },
    });

  //Weapons
  public getWeapons = () => {
    const api = new PublicApi();
    return Store.get(
      this.wpn,
      api.getWeapons().map<AccountWeaponData>((w) => ({
        weaponId: w.weaponId,
        copies: 0,
        copiesWanted: 0,
        weaponLevel: 0,
        weaponLevelWanted: 0,
        unbind: 0,
        unbindWanted: 0,
        refine: 0,
        refineWanted: 0,
        slot: 0,
        slotWanted: 0,
        dominion: 0,
        dominionWanted: 0,
        bonus: 0,
        bonusWanted: 0,
        weapon: w,
      })),
    ) as AccountWeaponData[];
  };

  public putWeapon = (weaponID: number, weapon: AccountWeaponData) => {
    Store.set(
      this.wpn,
      this.getWeapons().map((w) =>
        w.weaponId === weaponID
          ? {
              ...w,
              copies: weapon.copies,
              copiesWanted: weapon.copiesWanted,
              weaponLevel: weapon.weaponLevel,
              weaponLevelWanted: weapon.weaponLevelWanted,
              unbind: weapon.unbind,
              unbindWanted: weapon.unbindWanted,
              refine: weapon.refine,
              refineWanted: weapon.refineWanted,
              slot: weapon.slot,
              slotWanted: weapon.slotWanted,
              dominion: weapon.dominion,
              dominionWanted: weapon.dominionWanted,
              bonus: weapon.bonus,
              bonusWanted: weapon.bonusWanted,
            }
          : w,
      ),
    );
  };

  public getWeaponCosts = (weaponID?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountWeapons/costs', {
      params: {
        weaponID: weaponID,
      },
    });

  //wyrmprints
  public getWyrmprints = () => {
    const api = new PublicApi();
    return Store.get(
      this.wpt,
      api.getWyrmprints().map<AccountWyrmprintData>((w) => ({
        wyrmprintId: w.wyrmprintId,
        wyrmprintLevel: 0,
        wyrmprintLevelWanted: 0,
        unbind: 0,
        unbindWanted: 0,
        copies: 0,
        copiesWanted: 0,
        wyrmprint: w,
      })),
    ) as AccountWyrmprintData[];
  };

  public putWyrmprint = (
    wyrmprintID: number,
    wyrmprint: AccountWyrmprintData,
  ) => {
    Store.set(
      this.wpt,
      this.getWyrmprints().map((w) =>
        w.wyrmprintId === wyrmprintID
          ? {
              ...w,
              wyrmprintLevel: wyrmprint.wyrmprintLevel,
              wyrmprintLevelWanted: wyrmprint.wyrmprintLevelWanted,
              unbind: wyrmprint.unbind,
              unbindWanted: wyrmprint.unbindWanted,
              copies: wyrmprint.copies,
              copiesWanted: wyrmprint.copiesWanted,
            }
          : w,
      ),
    );
  };

  public getWyrmprintCosts = (wyrmprintID?: number) =>
    this.instance.get<MaterialCosts[]>('/AccountWyrmprints/costs', {
      params: {
        wyrmprintID: wyrmprintID,
      },
    });
}
