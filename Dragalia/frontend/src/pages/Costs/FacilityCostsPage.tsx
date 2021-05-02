import { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { Costs } from './Costs';

export const FacilityCostsPage = () => {
  const [facilityCosts, setFacilityCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
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
  }, []);

  return (
    <Page title="Facility Costs">
      {costsLoading ? <LoadingText /> : <Costs data={facilityCosts} />}
    </Page>
  );
};
