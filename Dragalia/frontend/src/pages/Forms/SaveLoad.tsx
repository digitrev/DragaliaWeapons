/** @jsxImportSource @emotion/react */
import { useEffect, useState } from 'react';
import { PrivateApi } from '../../api/UserData';
import { Page } from '../Page';
import { decode, encode } from 'js-base64';
import { Form, Values } from './Form';
import { Field } from './Field';
import { LoadingText } from '../Loading';
import copy from 'copy-to-clipboard';

export const SaveLoad = () => {
  const [saveString, setSaveString] = useState<string>();
  const [ssLoading, setSsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetData = async () => {
      const api = new PrivateApi();
      const adventurerData = await api.getAdventurers();
      const dragonData = await api.getDragons();
      const facilityData = await api.getFacilities();
      const inventoryData = await api.getInventory();
      const passiveData = await api.getPassives();
      const weaponData = await api.getWeapons();
      const wyrmprintData = await api.getWyrmprints();
      if (!cancelled) {
        setSaveString(
          encode(
            JSON.stringify({
              adventurers: adventurerData,
              dragons: dragonData,
              facilities: facilityData,
              inventory: inventoryData,
              passives: passiveData,
              weapons: weaponData,
              wyrmprints: wyrmprintData,
            }),
          ),
        );
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
    return { success: true };
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
    </Page>
  );
};
