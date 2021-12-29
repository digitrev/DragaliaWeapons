import { useEffect, useState } from 'react';
import { ChestGroupData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/GameData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { ChestGroupList } from './ChestGroupList';

export const ChestGroupPage = () => {
  const [chestGroups, setChestGroups] = useState<ChestGroupData[] | null>(null);
  const [chestGroupsLoading, setChestGroupsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetChestGroups = async () => {
      const api = new PublicApi();
      const chestGroupData = await api.getChestGroups();
      if (!cancelled) {
        setChestGroups(chestGroupData);
        setChestGroupsLoading(false);
      }
    };
    doGetChestGroups();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Chest Group List">
      {chestGroupsLoading ? (
        <LoadingText />
      ) : (
        <ChestGroupList data={chestGroups || []} />
      )}
    </Page>
  );
};
