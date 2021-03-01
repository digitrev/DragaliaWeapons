/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import Select, { ActionMeta } from 'react-select';
import { getOptionValue, getOptionLabel } from 'react-select/src/builtins';
import {
  ElementData,
  WeaponData,
  WeaponSeriesData,
  WeaponTypeData,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../../Loading';
import { Field, SelectOption } from '../Forms/Field';
import { Form, required, Values } from '../Forms/Form';

export const AddWeapon = () => {
  const [elements, setElements] = useState<ElementData[] | null>(null);
  const [weaponSeries, setWeaponSeries] = useState<WeaponSeriesData[] | null>(
    null,
  );
  const [weaponTypes, setWeaponTypes] = useState<WeaponTypeData[] | null>(null);
  const [weapons, setWeapons] = useState<WeaponData[] | null>(null);
  const [elementFilter, setElementFilter] = useState<ElementData | null>(null);
  const [
    weaponSeriesFilter,
    setWeaponSeriesFilter,
  ] = useState<WeaponSeriesData | null>(null);
  const [
    weaponTypeFilter,
    setWeaponTypeFilter,
  ] = useState<WeaponTypeData | null>(null);
  const [weaponOptions, setWeaponOptions] = useState<SelectOption[] | null>(
    null,
  );

  const weaponToSubmit = (wd: WeaponData): SelectOption => {
    return {
      label: `${wd.weapon}: ${wd.rarity}* ${wd.weaponSeries} ${
        wd.element === 'None' ? '' : wd.element
      } ${wd.weaponType}`,
      value: wd.weaponId.toString(),
    };
  };

  useEffect(() => {
    const doGetPublicData = async () => {
      const api = new PublicApi();
      const elementData = await api.getElements();
      const weaponSeriesData = await api.getWeaponSeries();
      const weaponTypeData = await api.getWeaponTypes();
      setElements(elementData);
      setWeaponSeries(weaponSeriesData);
      setWeaponTypes(weaponTypeData);
    };
    const doGetWeapons = async () => {
      const api = new PrivateApi();
      const weaponData = await api.getUntrackedWeapons();
      setWeapons(weaponData);
      setWeaponOptions(null);
    };
    doGetPublicData();
    doGetWeapons();
  }, []);

  useEffect(() => {
    let weaponFilter = weapons;
    if (weaponFilter) {
      if (elementFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => w.element === elementFilter.element,
        );
      }
      if (weaponSeriesFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => w.weaponSeries === weaponSeriesFilter.weaponSeries,
        );
      }
      if (weaponTypeFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => w.weaponType === weaponTypeFilter.weaponType,
        );
      }
      setWeaponOptions(weaponFilter.map((wf) => weaponToSubmit(wf)));
    }
  }, [weapons, elementFilter, weaponSeriesFilter, weaponTypeFilter]);

  const handleChangeElement = (
    value: ElementData | null,
    actionMeta: ActionMeta<ElementData>,
  ) => {
    setElementFilter(value);
  };

  const handleChangeWeaponSeries = (
    value: WeaponSeriesData | null,
    actionMeta: ActionMeta<WeaponSeriesData>,
  ) => {
    setWeaponSeriesFilter(value);
  };

  const handleChangeWeaponType = (
    value: WeaponTypeData | null,
    actionMeta: ActionMeta<WeaponTypeData>,
  ) => {
    setWeaponTypeFilter(value);
  };

  const getElementValue: getOptionValue<ElementData> = (option) =>
    option.elementId.toString();

  const getElementLabel: getOptionLabel<ElementData> = (option) =>
    option.element;

  const getWeaponSeriesValue: getOptionValue<WeaponSeriesData> = (option) =>
    option.weaponSeriesId.toString();

  const getWeaponSeriesLabel: getOptionLabel<WeaponSeriesData> = (option) =>
    option.weaponSeries;

  const getWeaponTypeValue: getOptionValue<WeaponTypeData> = (option) =>
    option.weaponTypeId.toString();

  const getWeaponTypeLabel: getOptionLabel<WeaponTypeData> = (option) =>
    option.weaponType;

  const handleSubmit = async (values: Values) => {
    const api = new PrivateApi();
    const weaponData = values.weaponIds.forEach(
      async (weaponId: number) =>
        await api.postWeapon({
          weaponId: weaponId,
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
          bonus: 0,
          bonusWanted: 0,
        }),
    );

    return { success: weaponData ? true : false };
    // return { success: true };
  };

  return (
    //Element picker
    //Weapon type picker
    //Weapon series picker
    //Rarity picker

    //show current weapons
    //Have a field with a button to track selected weapon
    <Form
      submitCaption="Track"
      onSubmit={handleSubmit}
      successMessage={'✔'}
      failureMessage={'❌'}
      validationRules={{
        weaponIds: [{ validator: required }],
      }}
    >
      <label
        htmlFor="elements"
        css={css`
          font-weight: bold;
        `}
      >
        Element
      </label>
      {elements ? (
        <Select
          name="elements"
          options={elements}
          getOptionValue={getElementValue}
          getOptionLabel={getElementLabel}
          onChange={handleChangeElement}
        />
      ) : (
        <LoadingText />
      )}
      <label
        htmlFor="weaponSeries"
        css={css`
          font-weight: bold;
        `}
      >
        Weapon Series
      </label>
      {weaponSeries ? (
        <Select
          name="weaponSeries"
          options={weaponSeries}
          getOptionValue={getWeaponSeriesValue}
          getOptionLabel={getWeaponSeriesLabel}
          onChange={handleChangeWeaponSeries}
        />
      ) : (
        <LoadingText />
      )}
      <label
        htmlFor="weaponType"
        css={css`
          font-weight: bold;
        `}
      >
        Weapon Type
      </label>
      {weaponTypes ? (
        <Select
          name="weaponType"
          options={weaponTypes}
          getOptionValue={getWeaponTypeValue}
          getOptionLabel={getWeaponTypeLabel}
          onChange={handleChangeWeaponType}
        />
      ) : (
        <LoadingText />
      )}
      <label
        htmlFor="weaponOptions"
        css={css`
          font-weight: bold;
        `}
      >
        Weapon
      </label>
      {weaponOptions ? (
        // <div>weapon picker goes here</div>
        <Field type="Select" selectOptions={weaponOptions} name="weaponIds" />
      ) : (
        //     <Select
        //       name="weaponOptions"
        //       options={weaponOptions}
        //       getOptionLabel={getWeaponLabel}
        //       getOptionValue={getWeaponValue}
        //       onChange={handleChangeWeaponOption}
        //     />
        <LoadingText />
      )}
    </Form>
  );
};
