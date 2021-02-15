/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { WeaponApi, WeaponData } from '../data/WeaponData';
import { Page } from './Page';
import { WeaponList } from './WeaponList';

export const WeaponsPage = () => {
  const [weapons, setWeapons] = useState<WeaponData[] | null>(null);
  const [weaponsLoading, setWeaponsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetWeapons = async () => {
      const api = new WeaponApi();
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
    <Page title="Weapon List">
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
        <WeaponList data={weapons || []} />
      )}
    </Page>
  );
};
