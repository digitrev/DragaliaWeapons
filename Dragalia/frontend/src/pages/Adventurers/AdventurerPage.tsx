/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { AdventurerData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { AdventurerList } from './AdventurerList';

export const AdventurerPage = () => {
  const [adventurers, setAdventurers] = useState<AdventurerData[] | null>(null);
  const [adventurersLoading, setAdventurersLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetAdventurers = async () => {
      const api = new PublicApi();
      const adventurerData = await api.getAdventurers();
      if (!cancelled) {
        setAdventurers(adventurerData);
        setAdventurersLoading(false);
      }
    };
    doGetAdventurers();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Adventurer List">
      {adventurersLoading ? (
        <LoadingText />
      ) : (
        <AdventurerList data={adventurers || []} />
      )}
    </Page>
  );
};
