/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { AccountInventoryData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { InventoryList } from './InventoryList';

export const InventoryPage = () => {
  const [inventory, setInventory] = useState<AccountInventoryData[] | null>(
    null,
  );
  const [inventoryLoading, setInventoryLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetInventory = async () => {
      const api = new PrivateApi();
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
  }, []);

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
