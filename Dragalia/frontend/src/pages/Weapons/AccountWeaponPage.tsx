/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { Fragment, useEffect, useState } from 'react';
import { AccountWeaponData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { accent2, PrimaryButton } from '../../Styles';
import { Page } from '../Page';
import { AccountWeaponList } from './AccountWeaponList';
import { AddWeapon } from './AddWeapon';

export const AccountWeaponPage = () => {
  const [weapons, setWeapons] = useState<AccountWeaponData[] | null>(null);
  const [weaponsLoading, setWeaponsLoading] = useState(true);
  const [addingWeapon, setAddingWeapon] = useState(false);

  const onClickWeaponButton = () => {
    setAddingWeapon(!addingWeapon);
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
    if (!addingWeapon) {
      doGetWeapons();
    }
    return () => {
      cancelled = true;
    };
  }, [addingWeapon]);

  return (
    <Page title="Your Weapons">
      {weaponsLoading ? (
        <LoadingText />
      ) : (
        <Fragment>
          <AccountWeaponList data={weapons || []} />
          {addingWeapon && (
            <div
              css={css`
                list-style: none;
                margin: 10px 0 0 0;
                padding: 0px 20px 10px 0px;
                background-color: #fff;
                border-bottom-left-radius: 4px;
                border-bottom-right-radius: 4px;
                border-top: 3px solid ${accent2};
                box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
              `}
            >
              <AddWeapon />
            </div>
          )}
          <div
            css={css`
              margin: 10px 0px 10px 0px;
              padding: 10px 0px 10px 0px;
            `}
          >
            <PrimaryButton type="button" onClick={onClickWeaponButton}>
              {addingWeapon ? 'Done' : 'Track Weapons'}
            </PrimaryButton>
          </div>
        </Fragment>
      )}
    </Page>
  );
};
