import { useEffect, useState } from 'react';
import { PassiveData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/GameData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { PassiveList } from './PassiveList';

export const PassivePage = () => {
  const [passives, setPassives] = useState<PassiveData[] | null>(null);
  const [passivesLoading, setPassivesLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetPassives = async () => {
      const api = new PublicApi();
      const passiveData = await api.getPassives();
      if (!cancelled) {
        setPassives(passiveData);
        setPassivesLoading(false);
      }
    };
    doGetPassives();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Passive List">
      {passivesLoading ? (
        <LoadingText />
      ) : (
        <PassiveList data={passives || []} />
      )}
    </Page>
  );
};
