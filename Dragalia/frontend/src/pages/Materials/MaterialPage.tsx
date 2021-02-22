/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { PublicApi, MaterialData } from '../../api/PublicData';
import { Page } from '../Page';
import { MaterialList } from './MaterialList';

export const MaterialPage = () => {
  const [materials, setMaterials] = useState<MaterialData[] | null>(null);
  const [materialsLoading, setMaterialsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetMaterials = async () => {
      const api = new PublicApi();
      const materialData = await api.getMaterials();
      if (!cancelled) {
        setMaterials(materialData);
        setMaterialsLoading(false);
      }
    };
    doGetMaterials();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Material List">
      {materialsLoading ? (
        <div
          css={css`
            font-size: 16px;
            font-style: italic;
          `}
        >
          Loading...
        </div>
      ) : (
        <MaterialList data={materials || []} />
      )}
    </Page>
  );
};
