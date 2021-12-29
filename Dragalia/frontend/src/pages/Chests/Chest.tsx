/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { ChestData } from '../../api/DataInterfaces';
import { ChestDropList } from './ChestDropList';

interface Props {
  data: ChestData;
}

export const Chest: FC<Props> = ({
  data: {
    chestDrops,
    quest: { quest },
  },
}) => {
  return (
    <div
      css={css`
        padding: 10px 0px;
      `}
    >
      <div
        css={css`
          padding: 10px 0px;
          font-size: 19px;
        `}
      >
        {quest}
      </div>
      <ChestDropList data={chestDrops} />
    </div>
  );
};
