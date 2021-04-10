/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import NumberFormat from 'react-number-format';
import { FarmingTable } from '../Costs';

interface Props {
  data: FarmingTable[];
}

export const Farming: FC<Props> = ({ data }) => {
  return (
    <table
      css={css`
        border-collapse: separate;
        border-spacing: 15px 0px;
      `}
    >
      <tbody>
        <tr>
          <th>Quest</th>
          <th>Needed</th>
        </tr>
        {data.map((fd) => (
          <tr key={fd.quest.questId}>
            <td>{fd.quest.quest}</td>
            <td>
              <NumberFormat
                displayType="text"
                thousandSeparator={true}
                isNumericString={true}
                value={fd.sum}
              />
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};
