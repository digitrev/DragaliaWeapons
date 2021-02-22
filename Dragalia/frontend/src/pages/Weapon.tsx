/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { WeaponData } from '../api/PublicData';

interface Props {
  data: WeaponData;
}

export const Weapon: FC<Props> = ({ data }) => {
  const { weapon1, weaponSeries, weaponType, rarity, element } = data;
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
        {weapon1}
      </div>
      <div>
        {rarity}* {weaponSeries} {element === 'None' ? '' : element}{' '}
        {weaponType}
      </div>
    </div>
  );
};
