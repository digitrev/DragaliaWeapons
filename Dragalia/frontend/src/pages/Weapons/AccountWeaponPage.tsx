/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { Fragment, useEffect, useState } from 'react';
import { AccountWeaponData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { PrimaryButton } from '../../Styles';
import { Page } from '../Page';
import { AccountWeaponList } from './AccountWeaponList';
import { AddWeapon } from './AddWeapon';

export const AccountWeaponsPage = () => {
  const [weapons, setWeapons] = useState<AccountWeaponData[] | null>(null);
  const [weaponsLoading, setWeaponsLoading] = useState(true);
  const [addingWeapon, setAddingWeapon] = useState(false);

  const onClickWeaponButton = () => {
    setAddingWeapon(true);
  };

  useEffect(() => {
    let cancelled = false;
    const doGetWeapons = async () => {
      const api = new PrivateApi();
      const weaponData = await api.getWeapons();
      if (!cancelled) {
        setWeapons(weaponData);
        setWeaponsLoading(false);
      }
    };
    doGetWeapons();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Your Weapons">
      {weaponsLoading ? (
        <div
          css={css`
            font-size: 16px;
            font-style: italic;
          `}
        >
          Loading...
        </div>
      ) : (
        <Fragment>
          <AccountWeaponList data={weapons || []} />
          <div
            css={css`
              padding: 10px;
            `}
          ></div>
          {addingWeapon ? (
            <AddWeapon propValue="test" />
          ) : (
            <PrimaryButton type="button" onClick={onClickWeaponButton}>
              Add Weapon
            </PrimaryButton>
          )}
        </Fragment>
      )}
    </Page>
  );
};
