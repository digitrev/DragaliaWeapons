/** @jsxImportSource @emotion/react */
import { useEffect, useState } from 'react';
import { PrivateApi } from '../../api/UserData';
import { Page } from '../Page';
import { decode, encode } from 'js-base64';
import { Form, Values } from './Form';
import { Field } from './Field';
import { LoadingText } from '../Loading';
import copy from 'copy-to-clipboard';
import { SaveData } from '../../api/DataInterfaces';

export const SaveLoad = () => {
  const [saveString, setSaveString] = useState<string>();
  const [ssLoading, setSsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetData = async () => {
      const api = new PrivateApi();
      const adventurerData = api.getAdventurers();
      const dragonData = api.getDragons();
      const facilityData = api.getFacilities();
      const inventoryData = api.getInventory();
      const passiveData = api.getPassives();
      const weaponData = api.getWeapons();
      const wyrmprintData = api.getWyrmprints();
      const saveData: SaveData = {
        adventurers: adventurerData,
        dragons: dragonData,
        facilities: facilityData,
        inventory: inventoryData,
        passives: passiveData,
        weapons: weaponData,
        wyrmprints: wyrmprintData,
      };
      if (!cancelled) {
        setSaveString(encode(JSON.stringify(saveData)));
        setSsLoading(false);
      }
    };
    doGetData();

    return () => {
      cancelled = true;
    };
  }, []);

  const handleExport = async (values: Values) => {
    copy(values.saveString);

    return { success: true };
  };

  const handleImport = async (values: Values) => {
    try {
      const {
        adventurers,
        dragons,
        facilities,
        inventory,
        passives,
        weapons,
        wyrmprints,
      }: SaveData = JSON.parse(decode(values.loadString));

      const api = new PrivateApi();

      adventurers.forEach((a) => api.putAdventurer(a.adventurerId, a));
      dragons.forEach((d) => api.putDragon(d.dragonId, d));
      facilities.forEach((f) => api.putFacility(f.facilityId, f.copyNumber, f));
      inventory.forEach((i) => api.putItem(i.materialId, i));
      passives.forEach((p) => api.putPassive(p.passiveId, p));
      weapons.forEach((w) => api.putWeapon(w.weaponId, w));
      wyrmprints.forEach((w) => api.putWyrmprint(w.wyrmprintId, w));

      return { success: true };
    } catch {
      return { success: false };
    }
  };

  return (
    <Page title="Save/Load test">
      {ssLoading ? (
        <LoadingText />
      ) : (
        <Form
          onSubmit={handleExport}
          defaultValues={{ saveString: saveString }}
          submitCaption="Copy to Clipboard"
        >
          <Field name="saveString" label="Export String" type="TextArea" />
        </Form>
      )}
      <Form
        onSubmit={handleImport}
        submitCaption="Import data"
        failureMessage="Bad data"
      >
        <Field name="loadString" label="Import String" type="TextArea" />
      </Form>
    </Page>
  );
};
