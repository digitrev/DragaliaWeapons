/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { ChangeEvent, Fragment, useEffect, useState } from 'react';
import Select, { ActionMeta } from 'react-select';
import { getOptionValue, getOptionLabel } from 'react-select/src/builtins';
import {
  AccountWeaponData,
  WeaponLimit,
  WeaponSeriesData,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { PublicApi } from '../../api/GameData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { AccountWeaponList } from './AccountWeaponList';
import ReactPaginate from 'react-paginate';
import {
  displayLimit,
  marginPagesDisplayed,
  pageRangeDisplayed,
} from '../../AppSettings';
import useElementFilter from '../../hooks/useElementFilter';
import useWeaponFilter from '../../hooks/useWeaponFilter';
import { WeaponString } from '../../components/WeaponIcon';
import { FilterElement, ElementSelect } from '../../components/ElementSelect';
import { WeaponSelect } from '../../components/WeaponSelect';

export const AccountWeaponPage = () => {
  const [weapons, setWeapons] = useState<AccountWeaponData[] | null>(null);
  const [weaponsLoading, setWeaponsLoading] = useState(true);
  const [displayWeapons, setDisplayWeapons] = useState<
    AccountWeaponData[] | null
  >(null);
  const [limits, setLimits] = useState<WeaponLimit[] | null>(null);

  const [weaponSeries, setWeaponSeries] = useState<WeaponSeriesData[]>([]);

  const [
    weaponSeriesFilter,
    setWeaponSeriesFilter,
  ] = useState<WeaponSeriesData | null>(null);

  const {
    elementFilter,
    toggleElement,
    selectAll: selectAllElements,
    selectNone: selectNoElements,
  } = useElementFilter();

  const {
    weaponFilter: weaponTypeFilter,
    toggleWeapon,
    selectNone: selectNoWeapons,
    selectAll: selectAllWeapons,
  } = useWeaponFilter();

  const [progressFilter, setProgressFilter] = useState(false);

  const [offset, setOffset] = useState(0);
  const [pageCount, setPageCount] = useState(1);

  useEffect(() => {
    let cancelled = false;
    const doGetPublicData = async () => {
      const api = new PublicApi();
      const weaponSeriesData = await api.getWeaponSeries();
      const limitData = await api.getAllWeaponLimits();
      if (!cancelled) {
        setWeaponSeries(weaponSeriesData);
        setLimits(limitData);
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
          (w) => elementFilter[w.weapon?.element as FilterElement],
        );
      }
      if (weaponSeriesFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => w.weapon?.weaponSeries === weaponSeriesFilter.weaponSeries,
        );
      }
      if (weaponTypeFilter) {
        weaponFilter = weaponFilter.filter(
          (w) => weaponTypeFilter[w.weapon?.weaponType as WeaponString],
        );
      }
      if (progressFilter) {
        weaponFilter = weaponFilter.filter(
          (w) =>
            w.bonusWanted > w.bonus ||
            w.copiesWanted > w.copies ||
            w.refineWanted > w.refine ||
            w.slotWanted > w.slot ||
            w.unbindWanted > w.unbind ||
            w.dominionWanted > w.dominion ||
            w.weaponLevelWanted > w.weaponLevel,
        );
      }
      setPageCount(Math.ceil(weaponFilter.length / displayLimit));
      weaponFilter = weaponFilter.slice(offset, offset + displayLimit);
      setDisplayWeapons(weaponFilter);
    }
  }, [
    elementFilter,
    offset,
    progressFilter,
    weaponSeriesFilter,
    weaponTypeFilter,
    weapons,
  ]);

  const handleChangeWeaponSeries = (
    value: WeaponSeriesData | null,
    actionMeta: ActionMeta<WeaponSeriesData>,
  ) => {
    setWeaponSeriesFilter(value);
  };

  const handleChangeProgress = (e: ChangeEvent<HTMLInputElement>) => {
    setProgressFilter(e.currentTarget.checked);
  };

  const handlePageChange = (selectedItem: { selected: number }) => {
    setOffset(selectedItem.selected * displayLimit);
  };

  const getWeaponSeriesValue: getOptionValue<WeaponSeriesData> = (option) =>
    option.weaponSeriesId.toString();

  const getWeaponSeriesLabel: getOptionLabel<WeaponSeriesData> = (option) =>
    option.weaponSeries;

  return (
    <Page title="Your Weapons">
      {weaponsLoading ? (
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
          <div>
            <WeaponSelect
              weaponFilter={weaponTypeFilter}
              toggleWeapon={toggleWeapon}
              selectNone={selectNoWeapons}
              selectAll={selectAllWeapons}
            />
          </div>
          <label
            htmlFor="elements"
            css={css`
              font-weight: bold;
            `}
          >
            Element
          </label>
          <div
            css={css`
              padding-bottom: 10px;
            `}
          >
            <ElementSelect
              elementFilter={elementFilter}
              toggleElement={toggleElement}
              selectNone={selectNoElements}
              selectAll={selectAllElements}
            />
          </div>
          <AccountWeaponList
            data={displayWeapons || []}
            limits={limits || []}
          />
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
