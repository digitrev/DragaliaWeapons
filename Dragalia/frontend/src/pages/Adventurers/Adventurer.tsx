/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import React, { FC } from 'react';
import { AdventurerData } from '../../api/DataInterfaces';
import { ElementIcon, ElementString } from '../../components/ElementIcon';
import { WeaponIcon, WeaponString } from '../../components/WeaponIcon';

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
        {adventurer}{' '}
        {element !== 'None' && (
          <ElementIcon element={element as ElementString} />
        )}{' '}
        {weaponType && <WeaponIcon weaponType={weaponType as WeaponString} />}
      </div>
      <div>
        {rarity}⭐ {element === 'None' ? '' : element} {weaponType}
      </div>
    </div>
  );
};
