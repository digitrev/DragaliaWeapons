/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import {
  AccountInventoryData,
  ChestGroupData,
  SummaryTable,
} from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { Recommendation } from './Recommendation';

interface Props {
  data: ChestGroupData[];
  costs: SummaryTable[];
  items: AccountInventoryData[];
}

export const RecommendationList: FC<Props> = ({ data, costs, items }) => {
  return (
    <ul
      css={css`
        list-style: none;
        margin: 10px 0 0 0;
        padding: 0px 20px;
        background-color: #fff;
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        border-top: 3px solid ${accent2};
        box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
      `}
    >
      {data.map((cg) => (
        <li
          key={cg.chestGroupId}
          css={css`
            border-top: 1px solid ${gray5};
            ::first-of-type {
              border-top: none;
            }
          `}
        >
          <Recommendation data={cg} costs={costs} items={items} />
        </li>
      ))}
    </ul>
  );
};
