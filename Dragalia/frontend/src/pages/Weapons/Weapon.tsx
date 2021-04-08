/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { WeaponData } from '../../api/DataInterfaces';
import { ElementIcon, ElementString } from '../../components/ElementIcon';
import { WeaponIcon, WeaponString } from '../../components/WeaponIcon';

interface Props {
  data: WeaponData;
}

export const Weapon: FC<Props> = ({
  data: { weapon, weaponSeries, weaponType, rarity, element },
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
        {weapon}{' '}
        {element !== 'None' && (
          <ElementIcon element={element as ElementString} />
        )}{' '}
        {weaponType && <WeaponIcon weaponType={weaponType as WeaponString} />}
      </div>
      <div>
        {rarity}⭐ {weaponSeries} {element === 'None' ? '' : element}{' '}
        {weaponType}
      </div>
    </div>
  );
};
