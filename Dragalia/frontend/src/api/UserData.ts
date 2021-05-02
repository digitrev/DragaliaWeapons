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
import { PublicApi } from './GameData';
import Store from 'store';
import manaCircleJson from '../data/Private/ManaCircles.json';
import dragonUnbindJson from '../data/Private/DragonUnbind.json';
import facilityUpgradeJson from '../data/Private/FacilityUpgrade.json';
import passiveCraftingJson from '../data/Private/PassiveCrafting,.json';
import weaponCraftingJson from '../data/Private/WeaponCrafting.json';
import weaponUpgradeJson from '../data/Private/WeaponUpgrade.json';
import weaponLevelJson from '../data/Private/WeaponLevel.json';
import wyrmprintUpgradeJson from '../data/Private/WyrmprintUpgrade.json';
import wyrmprintLevelJson from '../data/Private/WyrmprintLevel.json';

export class PrivateApi {
  public constructor(token: string) {}

  private readonly adv = 'adventurers';
  private readonly drg = 'dragons';
  private readonly fcl = 'facilities';
  private readonly inv = 'inventory';
  private readonly psv = 'passives';
  private readonly wpn = 'weapons';
  private readonly wpt = 'wyrmprints';
  private readonly api = new PublicApi();

  //adventurers
  public getAdventurers = () => {
    return Store.get(
      this.adv,
      this.api.getAdventurers().map<AccountAdventurerData>((a) => ({
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

  public getAdventurerCosts = (adventurerID?: number) => {
    const costs: MaterialCosts[] = [];
    const adv = this.getAdventurers().filter(
      (a) =>
        (adventurerID === undefined || a.adventurerId === adventurerID) &&
        a.wantedLevel > a.currentLevel,
    );
    const mc = manaCircleJson.filter(
      (mc) => adventurerID === undefined || mc.AdventurerID === adventurerID,
    );
    adv.forEach((a) => {
      mc.forEach((mc) => {
        if (
          mc.AdventurerID === a.adventurerId &&
          a.currentLevel < mc.ManaNode &&
          mc.ManaNode <= a.wantedLevel
        )
          costs.push({
            product: `${a.adventurer?.adventurer} MC #${mc.ManaNode}`,
            material: this.api.getMaterial(mc.MaterialID),
            quantity: mc.Quantity,
          });
      });
    });
    return costs;
  };

  //dragons
  public getDragons = () => {
    return Store.get(
      this.drg,
      this.api.getDragons().map<AccountDragonData>((d) => ({
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

  public getDragonCosts = (dragonID?: number) => {
    const costs: MaterialCosts[] = [];
    const drg = this.getDragons().filter(
      (d) =>
        (dragonID === undefined || d.dragonId === dragonID) &&
        d.unbindWanted > d.unbind,
    );
    const du = dragonUnbindJson.filter(
      (du) => dragonID === undefined || du.DragonID === dragonID,
    );
    drg.forEach((d) => {
      du.forEach((du) => {
        if (du.DragonID === d.dragonId)
          costs.push({
            product: `${d.dragon?.dragon} Unbinds`,
            material: this.api.getMaterial(du.MaterialID),
            quantity: du.Quantity * (d.unbindWanted - d.unbind),
          });
      });
    });
    return costs;
  };

  //facilities
  public getFacilities = () => {
    return Store.get(
      this.fcl,
      this.api.getFacilities().reduce<AccountFacilityData[]>((acc, cur) => {
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

  public getFacilityCosts = (facilityID?: number, copyNumber?: number) => {
    const costs: MaterialCosts[] = [];
    const fac = this.getFacilities().filter(
      (f) =>
        (facilityID === undefined ||
          copyNumber === undefined ||
          (f.facilityId === facilityID && f.copyNumber === copyNumber)) &&
        f.wantedLevel > f.currentLevel,
    );
    const fu = facilityUpgradeJson.filter(
      (fu) =>
        facilityID === undefined ||
        copyNumber === undefined ||
        fu.FacilityID === facilityID,
    );
    fac.forEach((f) => {
      fu.forEach((fu) => {
        if (
          fu.FacilityID === f.facilityId &&
          f.currentLevel < fu.FacilityLevel &&
          fu.FacilityLevel <= f.wantedLevel
        )
          costs.push({
            product: `${f.facility?.facility} ${
              f.facility && f.facility.limit > 1 ? `#${f.copyNumber}` : ''
            }Level ${fu.FacilityLevel}`,
            material: this.api.getMaterial(fu.MaterialID),
            quantity: fu.Quantity,
          });
      });
    });
    return costs;
  };

  //Inventory
  public getInventory = () => {
    return Store.get(
      this.inv,
      this.api.getMaterials().map<AccountInventoryData>((m) => ({
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
    return Store.get(
      this.psv,
      this.api.getPassives().map<AccountPassiveData>((p) => ({
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

  public getPassiveCosts = (passiveID?: number) => {
    const costs: MaterialCosts[] = [];
    const psv = this.getPassives().filter(
      (p) =>
        (passiveID === undefined || p.passiveId === passiveID) &&
        p.wanted &&
        !p.owned,
    );
    const pc = passiveCraftingJson.filter(
      (pc) => passiveID === undefined || pc.PassiveID === passiveID,
    );
    psv.forEach((p) => {
      pc.forEach((pc) => {
        if (pc.PassiveID === p.passiveId)
          costs.push({
            product: `${p.passive?.weaponType} ${p.passive?.ability}`,
            material: this.api.getMaterial(pc.MaterialID),
            quantity: pc.Quantity,
          });
      });
    });
    return costs;
  };

  //Weapons
  public getWeapons = () => {
    return Store.get(
      this.wpn,
      this.api.getWeapons().map<AccountWeaponData>((w) => ({
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

  public getWeaponCosts = (weaponID?: number) => {
    const costs: MaterialCosts[] = [];
    const wpn = this.getWeapons().filter(
      (w) =>
        (weaponID === undefined || w.weaponId === weaponID) &&
        (w.copiesWanted >= w.copies ||
          w.weaponLevelWanted > w.weaponLevel ||
          w.unbindWanted > w.unbind ||
          w.refineWanted > w.refine ||
          w.slotWanted > w.slot ||
          w.dominionWanted > w.dominion ||
          w.bonusWanted > w.bonus),
    );

    //weapon crafting
    const wc = weaponCraftingJson.filter(
      (wc) => weaponID === undefined || wc.WeaponID === weaponID,
    );
    const wu = weaponUpgradeJson.filter(
      (wu) => weaponID === undefined || wu.WeaponID === weaponID,
    );
    wpn.forEach((w) => {
      if (w.copies === 0 && w.copiesWanted > 0) {
        wc.forEach((wc) => {
          if (wc.WeaponID === w.weaponId)
            costs.push({
              product: `${w.weapon?.weapon}: Craft`,
              material: this.api.getMaterial(wc.MaterialID),
              quantity: wc.Quantity,
            });
        });
      }

      //weapon upgrading
      wu.forEach((wu) => {
        if (
          wu.WeaponID === w.weaponId &&
          ((wu.UpgradeType === 'Unbind' &&
            w.unbind < wu.Step &&
            wu.Step <= w.unbindWanted) ||
            (wu.UpgradeType === 'Refinement' &&
              w.refine < wu.Step &&
              wu.Step <= w.refineWanted) ||
            (wu.UpgradeType === 'Copies' &&
              w.copies < wu.Step &&
              wu.Step <= w.copiesWanted) ||
            (wu.UpgradeType === 'Slots' &&
              w.slot < wu.Step &&
              wu.Step <= w.slotWanted) ||
            (wu.UpgradeType === 'Dominion' &&
              w.dominion < wu.Step &&
              wu.Step <= w.dominionWanted) ||
            (wu.UpgradeType === 'Weapon Bonus' &&
              w.bonus < wu.Step &&
              wu.Step <= w.bonusWanted))
        )
          costs.push({
            product: `${w.weapon?.weapon}: ${wu.UpgradeType} ${wu.Step}`,
            material: this.api.getMaterial(wu.MaterialID),
            quantity: wu.Quantity,
          });
      });

      //weapon levels
      const wl = weaponLevelJson.filter((wl) => wl.Rarity === w.weapon?.rarity);
      wl.forEach((wl) => {
        if (
          w.weaponLevel < wl.WeaponLevel &&
          wl.WeaponLevel <= w.weaponLevelWanted
        ) {
          costs.push({
            product: `${w.weapon?.weapon}: Level ${wl.WeaponLevel}`,
            material: this.api.getMaterial(wl.MaterialID),
            quantity: wl.Quantity,
          });
        }
      });
    });
    return costs;
  };

  //wyrmprints
  public getWyrmprints = () => {
    return Store.get(
      this.wpt,
      this.api.getWyrmprints().map<AccountWyrmprintData>((w) => ({
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

  public getWyrmprintCosts = (wyrmprintID?: number) => {
    const costs: MaterialCosts[] = [];
    const wpt = this.getWyrmprints().filter(
      (w) =>
        (wyrmprintID === undefined || w.wyrmprintId === wyrmprintID) &&
        (w.copiesWanted >= w.copies ||
          w.wyrmprintLevelWanted > w.wyrmprintLevel ||
          w.unbindWanted > w.unbind),
    );

    const wu = wyrmprintUpgradeJson.filter(
      (wu) => wyrmprintID === undefined || wu.WyrmprintID === wyrmprintID,
    );
    const wl = wyrmprintLevelJson.filter(
      (wl) => wyrmprintID === undefined || wl.WyrmprintID === wyrmprintID,
    );

    wpt.forEach((w) => {
      //wyrmprint upgrading
      wu.forEach((wu) => {
        if (
          wu.WyrmprintID === w.wyrmprintId &&
          ((wu.UpgradeType === 'Unbind' &&
            w.unbind < wu.Step &&
            wu.Step <= w.unbindWanted) ||
            (wu.UpgradeType === 'Copies' &&
              w.copies < wu.Step &&
              wu.Step <= w.copiesWanted))
        )
          costs.push({
            product: `${w.wyrmprint?.wyrmprint}: ${wu.UpgradeType} ${wu.Step}`,
            material: this.api.getMaterial(wu.MaterialID),
            quantity: wu.Quantity,
          });
      });

      //wyrmprint levels
      wl.forEach((wl) => {
        if (
          w.wyrmprintLevel < wl.WyrmprintLevel &&
          wl.WyrmprintLevel <= w.wyrmprintLevelWanted
        ) {
          costs.push({
            product: `${w.wyrmprint?.wyrmprint}: Level ${wl.WyrmprintLevel}`,
            material: this.api.getMaterial(wl.MaterialID),
            quantity: wl.Quantity,
          });
        }
      });
    });
    return costs;
  };
}
