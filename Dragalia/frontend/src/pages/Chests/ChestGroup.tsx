/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { ChestGroupData } from '../../api/DataInterfaces';
import { ChestList } from './ChestList';

interface Props {
  data: ChestGroupData;
}

export const ChestGroup: FC<Props> = ({
  data: { chestGroup, frequency, quantity, chests },
}) => {
  return (
    <div
      css={css`
        padding: 10px 0px;
        font-size: 19px;
      `}
    >
      {chestGroup} ({quantity} times {frequency})
      <ChestList data={chests} />
    </div>
  );
};
