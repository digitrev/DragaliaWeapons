/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { WyrmprintData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { WyrmprintList } from './WyrmprintList';

export const WyrmprintPage = () => {
  const [wyrmprints, setWyrmprints] = useState<WyrmprintData[] | null>(null);
  const [wyrmprintsLoading, setWyrmprintsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetWyrmprints = async () => {
      const api = new PublicApi();
      const wyrmprintData = await api.getWyrmprints();
      if (!cancelled) {
        setWyrmprints(wyrmprintData);
        setWyrmprintsLoading(false);
      }
    };
    doGetWyrmprints();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Wyrmprint List">
      {wyrmprintsLoading ? (
        <LoadingText />
      ) : (
        <WyrmprintList data={wyrmprints || []} />
      )}
    </Page>
  );
};
