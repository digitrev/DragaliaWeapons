/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { Costs } from './Costs';

export const DragonCostsPage = () => {
  const [dragonCosts, setDragonCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getDragonCosts();
      if (!cancelled) {
        setDragonCosts(costData);
        setCostsLoading(false);
      }
    };
    doGetCosts();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Dragon Costs">
      {costsLoading ? <LoadingText /> : <Costs data={dragonCosts} />}
    </Page>
  );
};
