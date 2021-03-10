/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { AccountInventoryData } from '../api/DataInterfaces';
import { PrivateApi } from '../api/PrivateData';

export const Example = () => {
  const [data, setData] = useState<AccountInventoryData[]>([]);

  useEffect(() => {
    const doGetFilters = async () => {
      const api = new PrivateApi();
      const itemData = await api.getItemFilter([
        '101001001',
        '101001002',
        '101001003',
      ]);
      setData(itemData);
      console.log(itemData);
    };
    doGetFilters();
  }, []);

  return <div>blank</div>;
};
