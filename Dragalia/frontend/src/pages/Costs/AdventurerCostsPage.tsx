import { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { Costs } from './Costs';

export const AdventurerCostsPage = () => {
  const [adventurerCosts, setAdventurerCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getAdventurerCosts();
      if (!cancelled) {
        setAdventurerCosts(costData);
        setCostsLoading(false);
      }
    };
    doGetCosts();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Adventurer Costs">
      {costsLoading ? <LoadingText /> : <Costs data={adventurerCosts} />}
    </Page>
  );
};
