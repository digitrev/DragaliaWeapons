import { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../Loading';
import { useAuth } from '../Auth/Auth';
import { Page } from '../Page';
import { Costs } from './Costs';

export const FacilityCostsPage = () => {
  const { getAccessToken } = useAuth();
  const [facilityCosts, setFacilityCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const costData = await api.getFacilityCosts();
      if (!cancelled) {
        setFacilityCosts(costData);
        setCostsLoading(false);
      }
    };
    doGetCosts();
    return () => {
      cancelled = true;
    };
  }, [getAccessToken]);

  return (
    <Page title="Facility Costs">
      {costsLoading ? <LoadingText /> : <Costs data={facilityCosts} />}
    </Page>
  );
};
