/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import {
  AccountInventoryData,
  ChestData,
  ChestGroupData,
  MaterialCosts,
} from '../../api/DataInterfaces';
import { needed } from '../../api/HelperFunctions';

interface Props {
  data: ChestGroupData;
  costs: MaterialCosts[];
  items: AccountInventoryData[];
}

export const Recommendation: FC<Props> = ({ data, costs, items }) => {
  const chestNeeds = (c: ChestData) =>
    c.chestDrops.reduce((acc, cur) => {
      acc +=
        cur.quantity *
        needed(
          costs.find((i) => i.material.materialId === cur.materialId)?.quantity,
          items.find((i) => i.materialId === cur.materialId)?.quantity,
        );
      return acc;
    }, 0);

  return (
    <div>
      <div
        css={css`
          padding: 10px 0px;
          font-size: 19px;
        `}
      >
        {data?.chestGroup}
      </div>
      <ol>
        {data?.chests
          .sort((a, b) => chestNeeds(b) - chestNeeds(a))
          .map((c) => (
            <li key={c.chestId}>
              {c.quest.quest} (
              {c.chestDrops.reduce((acc, cur) => {
                acc +=
                  cur.quantity *
                  needed(
                    costs.find((i) => i.material.materialId === cur.materialId)
                      ?.quantity,
                    items.find((i) => i.materialId === cur.materialId)
                      ?.quantity,
                  );
                return acc;
              }, 0)}
              )
            </li>
          ))}
      </ol>
    </div>
  );
};
