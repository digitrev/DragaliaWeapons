/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { AdventurerData } from '../../api/DataInterfaces';

interface Props {
  data: AdventurerData;
}

export const Adventurer: FC<Props> = ({
  data: { adventurer, rarity, element, weaponType },
}) => {
  return (
    <div
      css={css`
        padding-bottom: 10px;
      `}
    >
      <div
        css={css`
          padding: 10px 0px;
          font-size: 19px;
        `}
      >
        {adventurer}
      </div>
      <div>
        {rarity}⭐ {element === 'None' ? '' : element} {weaponType}
      </div>
    </div>
  );
};
