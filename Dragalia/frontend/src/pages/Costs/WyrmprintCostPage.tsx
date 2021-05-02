import { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { Costs } from './Costs';

export const WyrmprintCostsPage = () => {
  const [wyrmprintCosts, setWyrmprintCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getWyrmprintCosts();
      if (!cancelled) {
        setWyrmprintCosts(costData);
        setCostsLoading(false);
      }
    };
    doGetCosts();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Wyrmprint Costs">
      {costsLoading ? <LoadingText /> : <Costs data={wyrmprintCosts} />}
    </Page>
  );
};
