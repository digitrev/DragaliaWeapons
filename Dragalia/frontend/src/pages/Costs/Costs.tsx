/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, Fragment, useEffect, useState } from 'react';
import {
  AccountInventoryData,
  FarmingTable,
  MaterialCosts,
  MaterialQuestData,
  SummaryTable,
} from '../../api/DataInterfaces';
import { needed, sumByMaterial } from '../../api/HelperFunctions';
import { PrivateApi } from '../../api/UserData';
import { PublicApi } from '../../api/GameData';
import { PrimaryButton } from '../../Styles';
import { Breakdown } from './CostTables/Breakdown';
import { Farming } from './CostTables/Farming';
import { Summary } from './CostTables/Summary';

interface Props {
  data: MaterialCosts[];
}

type DisplayType = 'Summary' | 'Breakdown' | 'Farming';

export const Costs: FC<Props> = ({ data }) => {
  const [summaryData, setSummaryData] = useState<SummaryTable[]>([]);
  const [farmingData, setFarmingData] = useState<FarmingTable[]>([]);
  const [displayType, setDisplayType] = useState<DisplayType>('Summary');
  const [items, setItems] = useState<AccountInventoryData[]>([]);
  const [quests, setQuests] = useState<MaterialQuestData[]>([]);

  const handleDisplay = (newDisplay: DisplayType) => {
    setDisplayType(newDisplay);
  };

  useEffect(() => {
    const doGetItems = async () => {
      const api = new PrivateApi();
      const itemData = await api.getItemFilter([
        ...Array.from(new Set(data.map<string>((d) => d.material.materialId))),
      ]);
      setItems(itemData);
    };
    const doGetQuests = async () => {
      const api = new PublicApi();
      const questData = await api.getMaterialQuestsFilter([
        ...Array.from(new Set(data.map<string>((d) => d.material.materialId))),
      ]);
      setQuests(questData);
    };
    doGetItems();
    doGetQuests();
    setSummaryData(sumByMaterial(data));
  }, [data]);

  useEffect(() => {
    const sumByQuest = (
      summary: SummaryTable[],
      materialQuests: MaterialQuestData[],
      inv: AccountInventoryData[],
    ): FarmingTable[] =>
      summary
        .reduce<FarmingTable[]>((acc, cur) => {
          const quests = materialQuests.filter(
            (mq) => mq.materialId === cur.material.materialId,
          );
          quests.forEach((q) => {
            const x = acc.find((mq) => mq.quest.questId === q.questId);
            const owned = items.find(
              (f) => f.materialId === cur.material.materialId,
            );
            const need = needed(cur.sum, owned?.quantity);
            if (x === undefined) {
              acc.push({
                quest: q.quest,
                sum: need,
              });
            } else {
              x.sum += need;
            }
          });
          return acc;
        }, [])
        .filter((f) => f.sum > 0)
        .sort((a, b) => b.sum - a.sum);

    setFarmingData(sumByQuest(summaryData, quests, items));
  }, [summaryData, quests, items]);

  const tableRender = () => {
    switch (displayType) {
      case 'Breakdown':
        return <Breakdown data={data} items={items} />;
      case 'Farming':
        return <Farming data={farmingData} />;
      case 'Summary':
        return <Summary data={summaryData} items={items} />;
    }
  };

  return (
    <Fragment>
      <PrimaryButton
        css={css`
          margin-left: 10px;
          margin-top: 10px;
        `}
        onClick={() => handleDisplay('Farming')}
      >
        Farming
      </PrimaryButton>
      <PrimaryButton
        css={css`
          margin-left: 10px;
          margin-top: 10px;
        `}
        onClick={() => handleDisplay('Summary')}
      >
        Summary
      </PrimaryButton>
      <PrimaryButton
        css={css`
          margin-left: 10px;
          margin-top: 10px;
        `}
        onClick={() => handleDisplay('Breakdown')}
      >
        Breakdown
      </PrimaryButton>
      {tableRender()}
    </Fragment>
  );
};
