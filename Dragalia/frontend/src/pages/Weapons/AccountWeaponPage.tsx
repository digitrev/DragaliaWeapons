/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { Fragment, useEffect, useState } from 'react';
import Select, { ActionMeta } from 'react-select';
import { getOptionValue, getOptionLabel } from 'react-select/src/builtins';
import {
  AccountWeaponData,
  DisplayWeaponData,
  ElementData,
  WeaponSeriesData,
  WeaponTypeData,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { AccountWeaponList } from './AccountWeaponList';
// import ReactPaginate from 'react-paginate';

export const AccountWeaponPage = () => {
  const [weapons, setWeapons] = useState<AccountWeaponData[] | null>(null);
  const [weaponsLoading, setWeaponsLoading] = useState(true);
  const [displayWeapons, setDisplayWeapons] = useState<
    DisplayWeaponData[] | null
  >(null);

  const [elements, setElements] = useState<ElementData[]>([]);
  const [weaponSeries, setWeaponSeries] = useState<WeaponSeriesData[]>([]);
  const [weaponTypes, setWeaponTypes] = useState<WeaponTypeData[]>([]);

  const [elementFilter, setElementFilter] = useState<ElementData | null>(null);
  const [
    weaponSeriesFilter,
    setWeaponSeriesFilter,
  ] = useState<WeaponSeriesData | null>(null);
  const [
    weaponTypeFilter,
    setWeaponTypeFilter,
  ] = useState<WeaponTypeData | null>(null);

  const weaponToDisplay = (weapon: AccountWeaponData): DisplayWeaponData => {
    return { ...weapon, display: true };
  };

  useEffect(() => {
    console.log('useEffect');
    let cancelled = false;
    const doGetPublicData = async () => {
      const api = new PublicApi();
      const elementData = await api.getElements();
      const weaponSeriesData = await api.getWeaponSeries();
      const weaponTypeData = await api.getWeaponTypes();
      if (!cancelled) {
        setElements(elementData);
        setWeaponSeries(weaponSeriesData);
        setWeaponTypes(weaponTypeData);
      }
    };
    const doGetWeapons = async () => {
      const api = new PrivateApi();
      const weaponData = await api.getWeapons();
      if (!cancelled) {
        setWeapons(weaponData);
        setWeaponsLoading(false);
      }
    };
    doGetPublicData();
    doGetWeapons();
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    let weaponFilter = weapons;
    if (weaponFilter) {
      if (elementFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => w.weapon?.element === elementFilter.element,
        );
      }
      if (weaponSeriesFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => w.weapon?.weaponSeries === weaponSeriesFilter.weaponSeries,
        );
      }
      if (weaponTypeFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => w.weapon?.weaponType === weaponTypeFilter.weaponType,
        );
      }
      if (weaponFilter.length > 20) {
        weaponFilter = weaponFilter.slice(0, 20);
      }
      console.log('wf length', weaponFilter.length);
      setDisplayWeapons(weaponFilter.map((w) => weaponToDisplay(w)));
    }
  }, [elementFilter, weaponSeriesFilter, weaponTypeFilter, weapons]);

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

  return (
    <Page title="Your Weapons">
      {weaponsLoading ? (
        <LoadingText />
      ) : (
        <Fragment>
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
              isClearable={true}
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
              isClearable={true}
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
              isClearable={true}
            />
          ) : (
            <LoadingText />
          )}
          <AccountWeaponList data={displayWeapons || []} />
        </Fragment>
      )}
    </Page>
  );
};
