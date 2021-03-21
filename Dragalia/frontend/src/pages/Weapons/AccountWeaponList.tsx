/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import { AccountWeaponData, WeaponLimit } from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { AccountWeapon } from './AccountWeapon';

interface Props {
  data: AccountWeaponData[];
  limits: WeaponLimit[];
}

export const AccountWeaponList: FC<Props> = ({ data, limits }) => {
  const findLimit = (weaponId: number) => {
    let limit = limits.find((l) => l.weaponID === weaponId);
    if (limit === undefined) {
      limit = {
        weaponID: weaponId,
        unbind: 0,
        refinement: 0,
        bonus: 0,
        dominion: 0,
        level: 0,
        slots: 0,
      };
    }
    return limit;
  };

  return (
    <ul
      css={css`
        list-style: none;
        margin: 10px 0 0 0;
        padding: 0px 20px;
        background-color: #fff;
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        border-top: 3px solid ${accent2};
        box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
      `}
    >
      {data.map((weapon) => (
        <li
          key={weapon.weaponId}
          css={css`
            border-top: 1px solid ${gray5};
            ::first-of-type {
              border-top: none;
            }
          `}
        >
          <AccountWeapon data={weapon} limits={findLimit(weapon.weaponId)} />
        </li>
      ))}
    </ul>
  );
};
