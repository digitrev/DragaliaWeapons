/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { ChangeEvent, Fragment, useEffect, useState } from 'react';
import ReactPaginate from 'react-paginate';
import Select, { ActionMeta } from 'react-select';
import { getOptionLabel, getOptionValue } from 'react-select/src/builtins';
import {
  AccountPassiveData,
  ElementData,
  WeaponTypeData,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { PublicApi } from '../../api/GameData';
import {
  displayLimit,
  marginPagesDisplayed,
  pageRangeDisplayed,
} from '../../AppSettings';
import { LoadingText } from '../Loading';
import { useAuth } from '../Auth/Auth';
import { Page } from '../Page';
import { AccountPassiveList } from './AccountPassiveList';

export const AccountPassivePage = () => {
  const { getAccessToken } = useAuth();
  const [passives, setPassives] = useState<AccountPassiveData[] | null>(null);
  const [passivesLoading, setPassivesLoading] = useState(true);

  const [displayPassives, setDisplayPassives] = useState<
    AccountPassiveData[] | null
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
    const doGetPassives = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const passiveData = await api.getPassives();
      if (!cancelled) {
        setPassives(passiveData);
        setPassivesLoading(false);
      }
    };
    doGetPublicData();
    doGetPassives();
    return () => {
      cancelled = true;
    };
  }, [getAccessToken]);

  useEffect(() => {
    let passiveFilter = passives;
    if (passiveFilter) {
      if (elementFilter) {
        passiveFilter = passiveFilter.filter(
          (p) => p.passive?.element === elementFilter.element,
        );
      }
      if (weaponTypeFilter) {
        passiveFilter = passiveFilter.filter(
          (p) => p.passive?.weaponType === weaponTypeFilter.weaponType,
        );
      }
      if (progressFilter) {
        passiveFilter = passiveFilter.filter((p) => p.wanted && !p.owned);
      }
      setPageCount(Math.ceil(passiveFilter.length / displayLimit));
      passiveFilter = passiveFilter?.slice(offset, offset + displayLimit);
      setDisplayPassives(passiveFilter);
    }
  }, [elementFilter, offset, passives, progressFilter, weaponTypeFilter]);

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
    <Page title="Your Passives">
      {passivesLoading ? (
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
          <AccountPassiveList data={displayPassives || []} />
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
