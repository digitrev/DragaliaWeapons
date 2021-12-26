/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { ChestDropData } from '../../api/DataInterfaces';

interface Props {
  data: ChestDropData;
}

export const ChestDrop: FC<Props> = ({
  data: {
    material: { material },
    quantity,
  },
}) => {
  return (
    <table
      css={css`
        border-collapse: separate;
        border-spacing: 15px 0px;
      `}
    >
      <tbody>
        <tr>
          <td>{material}</td>
          <td>{quantity}</td>
        </tr>
      </tbody>
    </table>
  );
};
