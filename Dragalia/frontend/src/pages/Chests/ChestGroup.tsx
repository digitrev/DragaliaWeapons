/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { ChestGroupData } from '../../api/DataInterfaces';

interface Props {
  data: ChestGroupData;
}

export const ChestGroup: FC<Props> = ({
  data: { chestGroup, frequency, quantity, chests },
}) => {
  return (
    <div>
      <div>Something goes here</div>
    </div>
  );
};
