/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { useState, useEffect, ChangeEvent, Fragment } from 'react';
import ReactPaginate from 'react-paginate';
import { AccountAdventurerData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import {
  displayLimit,
  pageRangeDisplayed,
  marginPagesDisplayed,
} from '../../AppSettings';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { AccountAdventurerList } from './AccountAdventurerList';
import useElementFilter from '../../hooks/useElementFilter';
import useWeaponFilter from '../../hooks/useWeaponFilter';
import { WeaponString } from '../../components/WeaponIcon';
import { ElementSelect, FilterElement } from '../../components/ElementSelect';
import { WeaponSelect } from '../../components/WeaponSelect';

export const AccountAdventurerPage = () => {
  const [adventurers, setAdventurers] = useState<
    AccountAdventurerData[] | null
  >(null);
  const [adventurersLoading, setAdventurersLoading] = useState(true);

  const [displayAdventurers, setDisplayAdventurers] = useState<
    AccountAdventurerData[] | null
  >(null);

  const {
    elementFilter,
    toggleElement,
    selectAll: selectAllElements,
    selectNone: selectNoElements,
  } = useElementFilter();

  const {
    weaponFilter,
    toggleWeapon,
    selectNone: selectNoWeapons,
    selectAll: selectAllWeapons,
  } = useWeaponFilter();

  const [progressFilter, setProgressFilter] = useState(false);

  const [offset, setOffset] = useState(0);
  const [pageCount, setPageCount] = useState(1);

  useEffect(() => {
    let cancelled = false;

    const doGetAdventurers = async () => {
      const api = new PrivateApi();
      const adventurerData = await api.getAdventurers();
      if (!cancelled) {
        setAdventurers(adventurerData);
        setAdventurersLoading(false);
      }
    };
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
          (p) => elementFilter[p.adventurer?.element as FilterElement],
        );
      }
      if (weaponFilter) {
        adventurerFilter = adventurerFilter.filter(
          (p) => weaponFilter[p.adventurer?.weaponType as WeaponString],
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
  }, [elementFilter, offset, adventurers, progressFilter, weaponFilter]);

  const handleChangeProgress = (e: ChangeEvent<HTMLInputElement>) => {
    setProgressFilter(e.currentTarget.checked);
  };

  const handlePageChange = (selectedItem: { selected: number }) => {
    setOffset(selectedItem.selected * displayLimit);
  };

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
          <div>
            <WeaponSelect
              weaponFilter={weaponFilter}
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
