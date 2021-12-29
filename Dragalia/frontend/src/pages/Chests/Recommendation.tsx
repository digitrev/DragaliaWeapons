/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import {
  AccountInventoryData,
  ChestData,
  ChestGroupData,
  SummaryTable,
} from '../../api/DataInterfaces';
import { needed } from '../../api/HelperFunctions';
import { accent2, gray5 } from '../../Styles';

interface Props {
  data: ChestGroupData;
  costs: SummaryTable[];
  items: AccountInventoryData[];
}

export const Recommendation: FC<Props> = ({
  data: { chestGroup, quantity, frequency, chests },
  costs,
  items,
}) => {
  const chestNeeds = (c: ChestData) =>
    c.chestDrops.reduce((acc, cur) => {
      acc +=
        cur.quantity *
        needed(
          costs.find((i) => i.material.materialId === cur.materialId)?.sum,
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
        {chestGroup} ({quantity} time{quantity === 1 ? '' : 's'}{' '}
        {frequency.toLowerCase()})
      </div>
      <ol
        css={css`
          margin: 10px 0 0 0;
          padding: 0px 20px;
          background-color: #fff;
          border-bottom-left-radius: 4px;
          border-bottom-right-radius: 4px;
          border-top: 3px solid ${accent2};
          box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
        `}
      >
        {chests
          .sort((a, b) => chestNeeds(b) - chestNeeds(a))
          .map((c) => (
            <li
              key={c.chestId}
              css={css`
                border-top: 1px solid ${gray5};
                ::first-of-type {
                  border-top: none;
                }
              `}
            >
              {c.quest.quest} ({chestNeeds(c)})
            </li>
          ))}
      </ol>
    </div>
  );
};
