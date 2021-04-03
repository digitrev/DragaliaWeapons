/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../Loading';
import { useAuth } from '../Auth/Auth';
import { Page } from '../Page';
import { Costs } from './Costs';

export const TotalCostsPage = () => {
  const { getAccessToken } = useAuth();
  const [totalCosts, setTotalCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const adventurerCosts = await api.getAdventurerCosts();
      const dragonCosts = await api.getDragonCosts();
      const facilityCosts = await api.getFacilityCosts();
      const passiveCosts = await api.getPassiveCosts();
      const weaponCosts = await api.getWeaponCosts();
      const wyrmprintCosts = await api.getWyrmprintCosts();
      const costData = adventurerCosts
        .concat(dragonCosts)
        .concat(facilityCosts)
        .concat(passiveCosts)
        .concat(weaponCosts)
        .concat(wyrmprintCosts);
      if (!cancelled) {
        setTotalCosts(costData);
        setCostsLoading(false);
      }
    };
    doGetCosts();
    return () => {
      cancelled = true;
    };
  }, [getAccessToken]);

  return (
    <Page title="Total Costs">
      {costsLoading ? <LoadingText /> : <Costs data={totalCosts} />}
    </Page>
  );
};
