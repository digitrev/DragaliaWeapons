/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { ChangeEvent, Fragment, useEffect, useState } from 'react';
import Select, { ActionMeta } from 'react-select';
import { getOptionValue, getOptionLabel } from 'react-select/src/builtins';
import { AccountWyrmprintData, WyrmprintLimit } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { PublicApi } from '../../api/GameData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { AccountWyrmprintList } from './AccountWyrmprintList';
import ReactPaginate from 'react-paginate';
import {
  displayLimit,
  marginPagesDisplayed,
  pageRangeDisplayed,
} from '../../AppSettings';

export interface Rarity {
  rarity: number;
}

export const AccountWyrmprintPage = () => {
  const [wyrmprints, setWyrmprints] = useState<AccountWyrmprintData[] | null>(
    null,
  );
  const [wyrmprintsLoading, setWyrmprintsLoading] = useState(true);
  const [displayWyrmprints, setDisplayWyrmprints] = useState<
    AccountWyrmprintData[] | null
  >(null);
  const [limits, setLimits] = useState<WyrmprintLimit[] | null>(null);

  const [rarities, setRarities] = useState<Rarity[]>([]);

  const [rarityFilter, setRarityFilter] = useState<Rarity | null>(null);
  const [progressFilter, setProgressFilter] = useState(false);

  const [offset, setOffset] = useState(0);
  const [pageCount, setPageCount] = useState(1);

  useEffect(() => {
    let cancelled = false;
    const doGetPublicData = async () => {
      const api = new PublicApi();
      const limitData = await api.getWyrmprintLimits();
      if (!cancelled) {
        setLimits(limitData);
      }
    };
    const doGetWyrmprints = async () => {
      const api = new PrivateApi();
      const wyrmprintData = await api.getWyrmprints();
      if (!cancelled) {
        setWyrmprints(wyrmprintData);
        setWyrmprintsLoading(false);
        setRarities(
          wyrmprintData.reduce<Rarity[]>((acc, cur) => {
            if (!acc.find((a) => a.rarity === cur.wyrmprint?.rarity)) {
              acc.push({ rarity: cur.wyrmprint!.rarity });
            }
            return acc;
          }, []),
        );
      }
    };
    doGetPublicData();
    doGetWyrmprints();
    return () => {
      cancelled = true;
    };
  }, [progressFilter, rarityFilter, offset]);

  useEffect(() => {
    let wyrmprintFilter = wyrmprints;
    if (wyrmprintFilter) {
      if (rarityFilter) {
        wyrmprintFilter = wyrmprintFilter.filter(
          (w) => w.wyrmprint?.rarity === rarityFilter.rarity,
        );
      }
      if (progressFilter) {
        wyrmprintFilter = wyrmprintFilter.filter(
          (w) =>
            w.copiesWanted > w.copies ||
            w.unbindWanted > w.unbind ||
            w.wyrmprintLevelWanted > w.wyrmprintLevel,
        );
      }
      setPageCount(Math.ceil(wyrmprintFilter.length / displayLimit));
      wyrmprintFilter = wyrmprintFilter.slice(offset, offset + displayLimit);
      setDisplayWyrmprints(wyrmprintFilter);
    }
  }, [rarityFilter, offset, progressFilter, wyrmprints]);

  const handleChangeRarity = (
    value: Rarity | null,
    actionMeta: ActionMeta<Rarity>,
  ) => {
    setRarityFilter(value);
  };

  const handleChangeProgress = (e: ChangeEvent<HTMLInputElement>) => {
    setProgressFilter(e.currentTarget.checked);
  };

  const handlePageChange = (selectedItem: { selected: number }) => {
    setOffset(selectedItem.selected * displayLimit);
  };

  const getRarityValue: getOptionValue<Rarity> = (option) =>
    option.rarity.toString();

  const getRarityLabel: getOptionLabel<Rarity> = (option) =>
    option.rarity === 9 ? 'Dominion' : `${option.rarity}⭐`;

  return (
    <Page title="Your Wyrmprints">
      {wyrmprintsLoading ? (
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
            htmlFor="rarity"
            css={css`
              font-weight: bold;
            `}
          >
            Rarity
          </label>
          {rarities ? (
            <Select
              name="rarity"
              options={rarities}
              getOptionValue={getRarityValue}
              getOptionLabel={getRarityLabel}
              onChange={handleChangeRarity}
              isClearable={true}
            />
          ) : (
            <LoadingText />
          )}
          <AccountWyrmprintList
            data={displayWyrmprints || []}
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
