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
import manaCircleJson from '../data/Upgrade/ManaCircles.json';
import dragonUnbindJson from '../data/Upgrade/DragonUnbind.json';
import facilityUpgradeJson from '../data/Upgrade/FacilityUpgrade.json';
import passiveCraftingJson from '../data/Upgrade/PassiveCrafting,.json';
import weaponCraftingJson from '../data/Upgrade/WeaponCrafting.json';
import weaponUpgradeJson from '../data/Upgrade/WeaponUpgrade.json';
import weaponLevelJson from '../data/Upgrade/WeaponLevel.json';
import wyrmprintUpgradeJson from '../data/Upgrade/WyrmprintUpgrade.json';
import wyrmprintLevelJson from '../data/Upgrade/WyrmprintLevel.json';

export class PrivateApi {
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
    const allAdv = this.api
      .getAdventurers()
      .map<AccountAdventurerData>((a) => ({
        adventurerId: a.adventurerId,
        currentLevel: 0,
        wantedLevel: 0,
        adventurer: a,
      }));
    const storedAdv = Store.get(this.adv) as AccountAdventurerData[];
    if (storedAdv) {
      storedAdv.forEach((sa) => {
        let i = allAdv.findIndex((aa) => aa.adventurerId === sa.adventurerId);
        allAdv[i] = {
          ...allAdv[i],
          currentLevel: sa.currentLevel,
          wantedLevel: sa.wantedLevel,
        };
      });
    }

    return allAdv;
  };

  public putAdventurer = (
    adventurerID: number,
    adventurer: AccountAdventurerData,
  ) => {
    const toSave = this.getAdventurers().reduce<AccountAdventurerData[]>(
      (acc, cur) => {
        if (
          cur.adventurerId === adventurerID &&
          (adventurer.currentLevel > 0 || adventurer.wantedLevel > 0)
        )
          acc.push({
            adventurerId: cur.adventurerId,
            currentLevel: adventurer.currentLevel,
            wantedLevel: adventurer.wantedLevel,
          });
        else if (
          cur.adventurerId !== adventurerID &&
          (cur.currentLevel > 0 || cur.wantedLevel > 0)
        ) {
          acc.push({ ...cur, adventurer: undefined });
        }
        return acc;
      },
      [],
    );
    if (toSave.length > 0) {
      Store.set(this.adv, toSave);
    } else {
      Store.remove(this.adv);
    }
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
    const allDrg = this.api.getDragons().map<AccountDragonData>((d) => ({
      dragonId: d.dragonId,
      dragon: d,
      unbind: 0,
      unbindWanted: 0,
    }));
    const storedDrg = Store.get(this.drg) as AccountDragonData[];
    if (storedDrg) {
      storedDrg.forEach((sd) => {
        let i = allDrg.findIndex((ad) => ad.dragonId === sd.dragonId);
        allDrg[i] = {
          ...allDrg[i],
          unbind: sd.unbind,
          unbindWanted: sd.unbindWanted,
        };
      });
    }

    return allDrg;
  };

  public putDragon = (dragonID: number, dragon: AccountDragonData) => {
    const toSave = this.getDragons().reduce<AccountDragonData[]>((acc, cur) => {
      if (
        cur.dragonId === dragonID &&
        (dragon.unbind > 0 || dragon.unbindWanted > 0)
      ) {
        acc.push({
          dragonId: cur.dragonId,
          unbind: dragon.unbind,
          unbindWanted: dragon.unbindWanted,
        });
      } else if (
        cur.dragonId !== dragonID &&
        (cur.unbind > 0 || cur.unbindWanted > 0)
      ) {
        acc.push({ ...cur, dragon: undefined });
      }
      return acc;
    }, []);
    if (toSave.length > 0) {
      Store.set(this.drg, toSave);
    } else {
      Store.remove(this.drg);
    }
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
    const allFcl = this.api
      .getFacilities()
      .reduce<AccountFacilityData[]>((acc, cur) => {
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
      }, []);
    const storedFcl = Store.get(this.fcl) as AccountFacilityData[];
    if (storedFcl) {
      storedFcl.forEach((sf) => {
        let i = allFcl.findIndex(
          (af) =>
            af.facilityId === sf.facilityId && af.copyNumber === sf.copyNumber,
        );
        allFcl[i] = {
          ...allFcl[i],
          currentLevel: sf.currentLevel,
          wantedLevel: sf.wantedLevel,
        };
      });
    }

    return allFcl;
  };

  public putFacility = (
    facilityID: number,
    copyNumber: number,
    facility: AccountFacilityData,
  ) => {
    const toSave = this.getFacilities().reduce<AccountFacilityData[]>(
      (acc, cur) => {
        if (
          cur.facilityId === facilityID &&
          cur.copyNumber === copyNumber &&
          (facility.currentLevel > 0 || facility.wantedLevel > 0)
        ) {
          acc.push({
            ...cur,
            currentLevel: facility.currentLevel,
            wantedLevel: facility.wantedLevel,
            facility: undefined,
          });
        } else if (
          (cur.facilityId !== facilityID || cur.copyNumber !== copyNumber) &&
          (cur.currentLevel > 0 || cur.wantedLevel > 0)
        ) {
          acc.push({ ...cur, facility: undefined });
        }
        return acc;
      },
      [],
    );
    if (toSave.length > 0) {
      Store.set(this.fcl, toSave);
    } else {
      Store.remove(this.fcl);
    }
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
    const allInv = this.api.getMaterials().map<AccountInventoryData>((m) => ({
      materialId: m.materialId,
      quantity: 0,
      material: m,
    }));
    const storedInv = Store.get(this.inv) as AccountInventoryData[];
    if (storedInv) {
      storedInv.forEach((si) => {
        let i = allInv.findIndex((ai) => ai.materialId === si.materialId);
        allInv[i] = { ...allInv[i], quantity: si.quantity };
      });
    }

    return allInv;
  };

  public getItemFilter = (materialIDs: string[]) =>
    this.getInventory().filter((i) =>
      materialIDs.some((m) => m === i.materialId),
    );

  public putItem = (materialID: string, item: AccountInventoryData) => {
    const toSave = this.getInventory().reduce<AccountInventoryData[]>(
      (acc, cur) => {
        if (cur.materialId === materialID && item.quantity > 0) {
          acc.push({
            materialId: cur.materialId,
            quantity: item.quantity,
          });
        } else if (cur.materialId !== materialID && cur.quantity > 0) {
          acc.push({ ...cur, material: undefined });
        }
        return acc;
      },
      [],
    );
    if (toSave.length > 0) {
      Store.set(this.inv, toSave);
    } else {
      Store.remove(this.inv);
    }
  };

  //Passives
  public getPassives = () => {
    const allPsv = this.api.getPassives().map<AccountPassiveData>((p) => ({
      passiveId: p.passiveId,
      owned: false,
      wanted: false,
      passive: p,
    }));
    const storedPsv = Store.get(this.psv) as AccountPassiveData[];
    if (storedPsv) {
      storedPsv.forEach((sp) => {
        let i = allPsv.findIndex((ap) => ap.passiveId === sp.passiveId);
        allPsv[i] = {
          ...allPsv[i],
          owned: sp.owned,
          wanted: sp.wanted,
        };
      });
    }

    return allPsv;
  };

  public putPassive = (passiveID: number, passive: AccountPassiveData) => {
    const toSave = this.getPassives().reduce<AccountPassiveData[]>(
      (acc, cur) => {
        if (cur.passiveId === passiveID && (passive.owned || passive.wanted)) {
          acc.push({
            passiveId: cur.passiveId,
            wanted: cur.wanted,
            owned: cur.owned,
          });
        } else if (cur.passiveId !== passiveID && (cur.owned || cur.wanted)) {
          acc.push({ ...cur, passive: undefined });
        }
        return acc;
      },
      [],
    );
    if (toSave.length > 0) {
      Store.set(this.psv, toSave);
    } else {
      Store.remove(this.psv);
    }
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
    const allWpn = this.api.getWeapons().map<AccountWeaponData>((w) => ({
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
    }));
    const storedWpn = Store.get(this.wpn) as AccountWeaponData[];
    if (storedWpn) {
      storedWpn.forEach((sw) => {
        let i = allWpn.findIndex((aw) => aw.weaponId === sw.weaponId);
        allWpn[i] = {
          ...allWpn[i],
          copies: sw.copies,
          copiesWanted: sw.copiesWanted,
          weaponLevel: sw.weaponLevel,
          weaponLevelWanted: sw.weaponLevelWanted,
          unbind: sw.unbind,
          unbindWanted: sw.unbindWanted,
          refine: sw.refine,
          refineWanted: sw.refineWanted,
          slot: sw.slot,
          slotWanted: sw.slotWanted,
          dominion: sw.dominion,
          dominionWanted: sw.dominionWanted,
          bonus: sw.bonus,
          bonusWanted: sw.bonusWanted,
        };
      });
    }

    return allWpn;
  };

  public putWeapon = (weaponID: number, weapon: AccountWeaponData) => {
    const toSave = this.getWeapons().reduce<AccountWeaponData[]>((acc, cur) => {
      if (
        cur.weaponId === weaponID &&
        (weapon.copies > 0 ||
          weapon.copiesWanted > 0 ||
          weapon.weaponLevel > 0 ||
          weapon.weaponLevelWanted > 0 ||
          weapon.unbind > 0 ||
          weapon.unbindWanted > 0 ||
          weapon.refine > 0 ||
          weapon.refineWanted > 0 ||
          weapon.slot > 0 ||
          weapon.slotWanted > 0 ||
          weapon.dominion > 0 ||
          weapon.dominionWanted > 0 ||
          weapon.bonus > 0 ||
          weapon.bonusWanted > 0)
      ) {
        acc.push({
          weaponId: cur.weaponId,
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
        });
      } else if (
        cur.weaponId !== weaponID &&
        (cur.copies > 0 ||
          cur.copiesWanted > 0 ||
          cur.weaponLevel > 0 ||
          cur.weaponLevelWanted > 0 ||
          cur.unbind > 0 ||
          cur.unbindWanted > 0 ||
          cur.refine > 0 ||
          cur.refineWanted > 0 ||
          cur.slot > 0 ||
          cur.slotWanted > 0 ||
          cur.dominion > 0 ||
          cur.dominionWanted > 0 ||
          cur.bonus > 0 ||
          cur.bonusWanted > 0)
      ) {
        acc.push({ ...cur, weapon: undefined });
      }
      return acc;
    }, []);
    if (toSave.length > 0) {
      Store.set(this.wpn, toSave);
    } else {
      Store.remove(this.wpn);
    }
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
    const allWpt = this.api.getWyrmprints().map<AccountWyrmprintData>((w) => ({
      wyrmprintId: w.wyrmprintId,
      wyrmprintLevel: 0,
      wyrmprintLevelWanted: 0,
      unbind: 0,
      unbindWanted: 0,
      copies: 0,
      copiesWanted: 0,
      wyrmprint: w,
    }));
    const storedWpt = Store.get(this.wpt) as AccountWyrmprintData[];
    if (storedWpt) {
      storedWpt.forEach((sw) => {
        let i = allWpt.findIndex((aw) => aw.wyrmprintId === sw.wyrmprintId);
        allWpt[i] = {
          ...allWpt[i],
          wyrmprintLevel: sw.wyrmprintLevel,
          wyrmprintLevelWanted: sw.wyrmprintLevelWanted,
          unbind: sw.unbind,
          unbindWanted: sw.unbindWanted,
          copies: sw.copies,
          copiesWanted: sw.copiesWanted,
        };
      });
    }

    return allWpt;
  };

  public putWyrmprint = (
    wyrmprintID: number,
    wyrmprint: AccountWyrmprintData,
  ) => {
    const toSave = this.getWyrmprints().reduce<AccountWyrmprintData[]>(
      (acc, cur) => {
        if (
          cur.wyrmprintId === wyrmprintID &&
          (wyrmprint.wyrmprintLevel > 0 ||
            wyrmprint.wyrmprintLevelWanted > 0 ||
            wyrmprint.unbind > 0 ||
            wyrmprint.unbindWanted > 0 ||
            wyrmprint.copies > 0 ||
            wyrmprint.copiesWanted > 0)
        ) {
          acc.push({
            wyrmprintId: cur.wyrmprintId,
            wyrmprintLevel: wyrmprint.wyrmprintLevel,
            wyrmprintLevelWanted: wyrmprint.wyrmprintLevelWanted,
            unbind: wyrmprint.unbind,
            unbindWanted: wyrmprint.unbindWanted,
            copies: wyrmprint.copies,
            copiesWanted: wyrmprint.copiesWanted,
          });
        } else if (
          cur.wyrmprintId !== wyrmprintID &&
          (cur.wyrmprintLevel > 0 ||
            cur.wyrmprintLevelWanted > 0 ||
            cur.unbind > 0 ||
            cur.unbindWanted > 0 ||
            cur.copies > 0 ||
            cur.copiesWanted > 0)
        ) {
          acc.push({ ...cur, wyrmprint: undefined });
        }
        return acc;
      },
      [],
    );
    if (toSave.length > 0) {
      Store.set(this.wpt, toSave);
    } else {
      Store.remove(this.wpt);
    }
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
