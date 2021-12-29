/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { ChestDropData } from '../../api/DataInterfaces';

interface Props {
  data: ChestDropData[];
}

export const ChestDropList: FC<Props> = ({ data }) => {
  return (
    <table
      css={css`
        border-collapse: separate;
        border-spacing: 15px 0px;
      `}
    >
      <tbody>
        {data.map((chestDrop) => (
          <tr>
            <td>{chestDrop.material.material}</td>
            <td>{chestDrop.quantity}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};
