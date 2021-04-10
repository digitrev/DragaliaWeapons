import { useEffect, useState } from 'react';
import { AccountInventoryData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../Loading';
import { useAuth } from '../Auth/Auth';
import { Page } from '../Page';
import { InventoryList } from './InventoryList';

export const InventoryPage = () => {
  const { getAccessToken } = useAuth();
  const [inventory, setInventory] = useState<AccountInventoryData[] | null>(
    null,
  );
  const [inventoryLoading, setInventoryLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetInventory = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const weaponData = await api.getInventory();
      if (!cancelled) {
        setInventory(weaponData);
        setInventoryLoading(false);
      }
    };
    doGetInventory();
    return () => {
      cancelled = true;
    };
  }, [getAccessToken]);

  return (
    <Page title="Your Inventory">
      {inventoryLoading ? (
        <LoadingText />
      ) : (
        <InventoryList data={inventory || []} />
      )}
    </Page>
  );
};
