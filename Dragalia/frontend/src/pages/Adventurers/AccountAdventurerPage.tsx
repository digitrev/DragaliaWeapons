/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useState, useEffect, ChangeEvent, Fragment } from 'react';
import ReactPaginate from 'react-paginate';
import { ActionMeta } from 'react-select';
import { getOptionValue, getOptionLabel } from 'react-select/src/builtins';
import Select from 'react-select';
import {
  AccountAdventurerData,
  ElementData,
  WeaponTypeData,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { PublicApi } from '../../api/PublicData';
import {
  displayLimit,
  pageRangeDisplayed,
  marginPagesDisplayed,
} from '../../AppSettings';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { AccountAdventurerList } from './AccountAdventurerList';

export const AccountAdventurerPage = () => {
  const [adventurers, setAdventurers] = useState<
    AccountAdventurerData[] | null
  >(null);
  const [adventurersLoading, setAdventurersLoading] = useState(true);

  const [displayAdventurers, setDisplayAdventurers] = useState<
    AccountAdventurerData[] | null
  >(null);

  const [elements, setElements] = useState<ElementData[]>([]);
  const [weaponTypes, setWeaponTypes] = useState<WeaponTypeData[]>([]);

  const [elementFilter, setElementFilter] = useState<ElementData | null>(null);
  const [
    weaponTypeFilter,
    setWeaponTypeFilter,
  ] = useState<WeaponTypeData | null>(null);
  const [progressFilter, setProgressFilter] = useState(false);

  const [offset, setOffset] = useState(0);
  const [pageCount, setPageCount] = useState(1);

  useEffect(() => {
    let cancelled = false;
    const doGetPublicData = async () => {
      const api = new PublicApi();
      const elementData = await api.getElements();
      const weaponTypeData = await api.getWeaponTypes();
      if (!cancelled) {
        setElements(elementData);
        setWeaponTypes(weaponTypeData);
      }
    };
    const doGetAdventurers = async () => {
      const api = new PrivateApi();
      const adventurerData = await api.getAdventurers();
      if (!cancelled) {
        setAdventurers(adventurerData);
        setAdventurersLoading(false);
      }
    };
    doGetPublicData();
    doGetAdventurers();
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    let adventurerFilter = adventurers;
    if (adventurerFilter) {
      if (elementFilter) {
        adventurerFilter = adventurerFilter.filter(
          (p) => p.adventurer?.element === elementFilter.element,
        );
      }
      if (weaponTypeFilter) {
        adventurerFilter = adventurerFilter.filter(
          (p) => p.adventurer?.weaponType === weaponTypeFilter.weaponType,
        );
      }
      if (progressFilter) {
        adventurerFilter = adventurerFilter.filter(
          (p) => p.currentLevel <= p.wantedLevel,
        );
      }
      setPageCount(Math.ceil(adventurerFilter.length / displayLimit));
      adventurerFilter = adventurerFilter?.slice(offset, offset + displayLimit);
      setDisplayAdventurers(adventurerFilter);
    }
  }, [elementFilter, offset, adventurers, progressFilter, weaponTypeFilter]);

  const handleChangeElement = (
    value: ElementData | null,
    actionMeta: ActionMeta<ElementData>,
  ) => {
    setElementFilter(value);
  };

  const handleChangeWeaponType = (
    value: WeaponTypeData | null,
    actionMeta: ActionMeta<WeaponTypeData>,
  ) => {
    setWeaponTypeFilter(value);
  };

  const handleChangeProgress = (e: ChangeEvent<HTMLInputElement>) => {
    setProgressFilter(e.currentTarget.checked);
  };

  const handlePageChange = (selectedItem: { selected: number }) => {
    setOffset(selectedItem.selected * displayLimit);
  };

  const getElementValue: getOptionValue<ElementData> = (option) =>
    option.elementId.toString();

  const getElementLabel: getOptionLabel<ElementData> = (option) =>
    option.element;

  const getWeaponTypeValue: getOptionValue<WeaponTypeData> = (option) =>
    option.weaponTypeId.toString();

  const getWeaponTypeLabel: getOptionLabel<WeaponTypeData> = (option) =>
    option.weaponType;

  return (
    <Page title="Your Adventurers">
      {adventurersLoading ? (
        <LoadingText />
      ) : (
        <Fragment>
          <div>
            <input
              type="checkbox"
              name="inProgress"
              onChange={handleChangeProgress}
            />
            <label
              htmlFor="inProgress"
              css={css`
                font-weight: bold;
              `}
            >
              In Progress?
            </label>
          </div>
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
          <AccountAdventurerList data={displayAdventurers || []} />
          <ReactPaginate
            pageCount={pageCount}
            pageRangeDisplayed={pageRangeDisplayed}
            marginPagesDisplayed={marginPagesDisplayed}
            onPageChange={handlePageChange}
            containerClassName="pagination"
            pageClassName="pages pagination"
            activeClassName="active"
            breakClassName="break-me"
          />
        </Fragment>
      )}
    </Page>
  );
};
