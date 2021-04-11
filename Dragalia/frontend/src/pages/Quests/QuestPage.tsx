import { useEffect, useState } from 'react';
import { QuestData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { QuestList } from './QuestList';

export const QuestPage = () => {
  const [quests, setQuests] = useState<QuestData[] | null>(null);
  const [questsLoading, setQuestsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetQuests = async () => {
      const api = new PublicApi();
      const questData = await api.getQuests();
      if (!cancelled) {
        setQuests(questData);
        setQuestsLoading(false);
      }
    };
    doGetQuests();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Quest List">
      {questsLoading ? <LoadingText /> : <QuestList data={quests || []} />}
    </Page>
  );
};
