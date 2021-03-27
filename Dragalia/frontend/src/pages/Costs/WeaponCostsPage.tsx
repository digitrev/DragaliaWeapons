/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { Costs } from './Costs';

export const WeaponCostsPage = () => {
  const [weaponCosts, setWeaponCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getWeaponCosts();
      if (!cancelled) {
        setWeaponCosts(costData);
        setCostsLoading(false);
      }
    };
    doGetCosts();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Weapon Costs">
      {costsLoading ? <LoadingText /> : <Costs data={weaponCosts} />}
    </Page>
  );
};
