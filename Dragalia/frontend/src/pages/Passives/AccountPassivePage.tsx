/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { ChangeEvent, Fragment, useEffect, useState } from 'react';
import { AccountPassiveData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';

import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { AccountPassiveList } from './AccountPassiveList';
import { ElementSelect } from '../../components/ElementSelect';
import { WeaponSelect } from '../../components/WeaponSelect';
import useElementFilter from '../../hooks/useElementFilter';
import { ElementString } from '../../components/ElementIcon';
import useWeaponFilter from '../../hooks/useWeaponFilter';
import { WeaponString } from '../../components/WeaponIcon';

export const AccountPassivePage = () => {
  const [passives, setPassives] = useState<AccountPassiveData[] | null>(null);
  const [passivesLoading, setPassivesLoading] = useState(true);

  const [displayPassives, setDisplayPassives] = useState<
    AccountPassiveData[] | null
  >(null);

  const {
    elementFilter: newElementFilter,
    toggleElement,
    selectNone: selectNoElements,
    selectAll: selectAllElements,
  } = useElementFilter();

  const {
    weaponFilter,
    toggleWeapon,
    selectNone: selectNoWeapons,
    selectAll: selectAllWeapons,
  } = useWeaponFilter();

  const [progressFilter, setProgressFilter] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetPassives = async () => {
      const api = new PrivateApi();
      const passiveData = await api.getPassives();
      if (!cancelled) {
        setPassives(passiveData);
        setPassivesLoading(false);
      }
    };
    doGetPassives();
    return () => {
      cancelled = true;
    };
  }, [progressFilter]);

  useEffect(() => {
    let passiveFilter = passives;
    if (passiveFilter) {
      if (newElementFilter) {
        passiveFilter = passiveFilter.filter(
          (p) => newElementFilter[p.passive?.element as ElementString],
        );
      }
      if (weaponFilter) {
        passiveFilter = passiveFilter.filter(
          (p) => weaponFilter[p.passive?.weaponType as WeaponString],
        );
      }
      if (progressFilter) {
        passiveFilter = passiveFilter.filter((p) => p.wanted && !p.owned);
      }
      setDisplayPassives(passiveFilter);
    }
  }, [newElementFilter, passives, progressFilter, weaponFilter]);

  const handleChangeProgress = (e: ChangeEvent<HTMLInputElement>) => {
    setProgressFilter(e.currentTarget.checked);
  };

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
              elementFilter={newElementFilter}
              toggleElement={toggleElement}
              selectNone={selectNoElements}
              selectAll={selectAllElements}
            />
          </div>
          <AccountPassiveList data={displayPassives || []} />
        </Fragment>
      )}
    </Page>
  );
};
