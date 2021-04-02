/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { getAccessToken } from '../Auth/Auth';
import { Page } from '../Page';
import { Costs } from './Costs';

export const PassiveCostsPage = () => {
  const [passiveCosts, setPassiveCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const costData = await api.getPassiveCosts();
      if (!cancelled) {
        setPassiveCosts(costData);
        setCostsLoading(false);
      }
    };
    doGetCosts();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Passive Costs">
      {costsLoading ? <LoadingText /> : <Costs data={passiveCosts} />}
    </Page>
  );
};
