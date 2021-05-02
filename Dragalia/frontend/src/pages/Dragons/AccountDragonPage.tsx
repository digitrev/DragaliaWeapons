/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { useState, useEffect, ChangeEvent, Fragment } from 'react';
import ReactPaginate from 'react-paginate';
import { ActionMeta } from 'react-select';
import { getOptionValue, getOptionLabel } from 'react-select/src/builtins';
import Select from 'react-select';
import { AccountDragonData, ElementData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { PublicApi } from '../../api/GameData';
import {
  displayLimit,
  pageRangeDisplayed,
  marginPagesDisplayed,
} from '../../AppSettings';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { AccountDragonList } from './AccountDragonList';
import { useAuth } from '../Auth/Auth';

export const AccountDragonPage = () => {
  const { getAccessToken } = useAuth();
  const [dragons, setDragons] = useState<AccountDragonData[] | null>(null);
  const [dragonsLoading, setDragonsLoading] = useState(true);

  const [displayDragons, setDisplayDragons] = useState<
    AccountDragonData[] | null
  >(null);

  const [elements, setElements] = useState<ElementData[]>([]);

  const [elementFilter, setElementFilter] = useState<ElementData | null>(null);
  const [progressFilter, setProgressFilter] = useState(false);

  const [offset, setOffset] = useState(0);
  const [pageCount, setPageCount] = useState(1);

  useEffect(() => {
    let cancelled = false;
    const doGetPublicData = async () => {
      const api = new PublicApi();
      const elementData = await api.getElements();
      if (!cancelled) {
        setElements(elementData);
      }
    };
    const doGetDragons = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const dragonData = await api.getDragons();
      if (!cancelled) {
        setDragons(dragonData);
        setDragonsLoading(false);
      }
    };
    doGetPublicData();
    doGetDragons();
    return () => {
      cancelled = true;
    };
  }, [getAccessToken]);

  useEffect(() => {
    let dragonFilter = dragons;
    if (dragonFilter) {
      if (elementFilter) {
        dragonFilter = dragonFilter.filter(
          (p) => p.dragon?.element === elementFilter.element,
        );
      }
      if (progressFilter) {
        dragonFilter = dragonFilter.filter((p) => p.unbind <= p.unbindWanted);
      }
      setPageCount(Math.ceil(dragonFilter.length / displayLimit));
      dragonFilter = dragonFilter?.slice(offset, offset + displayLimit);
      setDisplayDragons(dragonFilter);
    }
  }, [elementFilter, offset, dragons, progressFilter]);

  const handleChangeElement = (
    value: ElementData | null,
    actionMeta: ActionMeta<ElementData>,
  ) => {
    setElementFilter(value);
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

  return (
    <Page title="Your Dragons">
      {dragonsLoading ? (
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
          <AccountDragonList data={displayDragons || []} />
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
