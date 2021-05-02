import { useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
import { useAuth } from '../Auth/Auth';
import { Page } from '../Page';
import { Costs } from './Costs';

export const AdventurerCostsPage = () => {
  const { getAccessToken } = useAuth();
  const [adventurerCosts, setAdventurerCosts] = useState<MaterialCosts[]>([]);
  const [costsLoading, setCostsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
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
  }, [getAccessToken]);

  return (
    <Page title="Adventurer Costs">
      {costsLoading ? <LoadingText /> : <Costs data={adventurerCosts} />}
    </Page>
  );
};
