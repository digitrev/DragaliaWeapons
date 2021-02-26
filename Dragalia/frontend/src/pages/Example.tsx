/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { Page } from './Page';
import Select, { ActionMeta } from 'react-select';
import {
  ElementData,
  WeaponData,
  WeaponSeriesData,
  WeaponTypeData,
} from '../api/DataInterfaces';
import { PublicApi } from '../api/PublicData';
import { getOptionLabel, getOptionValue } from 'react-select/src/builtins';
import { LoadingText } from '../Loading';
import { PrivateApi } from '../api/PrivateData';

export const Example = () => {
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
  const [weaponOptions, setWeaponOptions] = useState<WeaponData[] | null>(null);

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
      setWeaponOptions(weaponData);
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
    }
    setWeaponOptions(weaponFilter);
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

  const getWeaponValue: getOptionValue<WeaponData> = (option) =>
    option.weaponId.toString();

  const getWeaponLabel: getOptionLabel<WeaponData> = (option) =>
    `${option.weapon}: ${option.rarity}* ${option.weaponSeries} ${
      option.element === 'None' ? '' : option.element
    } ${option.weaponType}`;

  return (
    <Page title="Example">
      <label
        htmlFor="elements"
        css={css`
          font-weight: bold;
        `}
      >
        Elements
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
        Weapons
      </label>
      {weaponOptions ? (
        <Select
          name="weaponOptions"
          options={weaponOptions}
          getOptionLabel={getWeaponLabel}
          getOptionValue={getWeaponValue}
        />
      ) : (
        <LoadingText />
      )}
    </Page>
  );
};
