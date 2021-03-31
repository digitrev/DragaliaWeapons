/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { MaterialData } from '../api/DataInterfaces';
import { materialComparator } from '../api/HelperFunctions';
import { Page } from './Page';

export const Example = () => {
  const [arr, setArr] = useState<MaterialData[]>([]);

  useEffect(() => {
    const m1: MaterialData = {
      material: 'test',
      materialId: '0',
      sortPath: '/1.1.3/1/',
      category: '',
    };
    const m2: MaterialData = {
      material: 'test2',
      materialId: '0',
      sortPath: '/1.2/',
      category: '',
    };
    const m3: MaterialData = {
      material: 'test3',
      materialId: '0',
      sortPath: '/',
      category: '',
    };

    setArr([m1, m2, m3].sort(materialComparator));
  }, []);

  return (
    <Page title="whatever">
      <ul>
        {arr.map((a) => (
          <li>
            {a.material} {a.sortPath}
          </li>
        ))}
      </ul>
    </Page>
  );
};
