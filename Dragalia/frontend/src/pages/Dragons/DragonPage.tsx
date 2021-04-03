/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { DragonData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { DragonList } from './DragonList';

export const DragonPage = () => {
  const [dragons, setDragons] = useState<DragonData[] | null>(null);
  const [dragonsLoading, setDragonsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetDragons = async () => {
      const api = new PublicApi();
      const dragonData = await api.getDragons();
      if (!cancelled) {
        setDragons(dragonData);
        setDragonsLoading(false);
      }
    };
    doGetDragons();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Dragon List">
      {dragonsLoading ? <LoadingText /> : <DragonList data={dragons || []} />}
    </Page>
  );
};
