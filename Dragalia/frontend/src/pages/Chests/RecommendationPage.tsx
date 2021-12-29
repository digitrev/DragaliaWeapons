import { useEffect, useState } from 'react';
import {
  AccountInventoryData,
  ChestGroupData,
  MaterialCosts,
} from '../../api/DataInterfaces';
import { PublicApi } from '../../api/GameData';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { RecommendationList } from './RecommendationList';

export const RecommendationPage = () => {
  const [inventory, setInventory] = useState<AccountInventoryData[] | null>(
    null,
  );
  const [costs, setCosts] = useState<MaterialCosts[]>([]);
  const [chestGroups, setChestGroups] = useState<ChestGroupData[] | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetPrivateData = async () => {
      setLoading(true);
      const api = new PrivateApi();
      const inventoryData = await api.getInventory();
      const costData = await api.getTotalCosts();
      if (!cancelled) {
        setInventory(inventoryData);
        setCosts(costData);
        setLoading(false);
      }
    };
    const doGetPublicData = async () => {
      setLoading(true);
      const api = new PublicApi();
      const chestGroupData = await api.getChestGroups();
      if (!cancelled) {
        setChestGroups(chestGroupData);
        setLoading(false);
      }
    };
    doGetPrivateData();
    doGetPublicData();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Chest Recommendations">
      {loading ? (
        <LoadingText />
      ) : (
        <RecommendationList
          data={chestGroups || []}
          items={inventory || []}
          costs={costs || []}
        />
      )}
    </Page>
  );
};
