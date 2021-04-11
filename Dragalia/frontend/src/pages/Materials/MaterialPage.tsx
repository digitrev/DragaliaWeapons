import { useEffect, useState } from 'react';
import { MaterialData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../Loading';
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
        <LoadingText />
      ) : (
        <MaterialList data={materials || []} />
      )}
    </Page>
  );
};
