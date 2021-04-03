/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import {
  AccountPassiveData,
  AccountPassiveGroupData,
} from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { AccountPassiveGroup } from './AccountPassiveGroup';

interface Props {
  data: AccountPassiveData[];
}

export const AccountPassiveList: FC<Props> = ({ data }) => {
  const groups = data.reduce<AccountPassiveGroupData[]>((acc, cur) => {
    if (cur.passive !== undefined) {
      const ind = acc.findIndex(
        (x) =>
          x.element === cur.passive!.element &&
          x.weaponType === cur.passive!.weaponType,
      );
      if (ind >= 0) {
        acc[ind].passives.push(cur);
      } else {
        acc.push({
          element: cur.passive.element,
          weaponType: cur.passive.weaponType,
          passives: [cur],
        });
      }
    }
    return acc;
  }, []);

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
      {groups.map((group) => (
        <li
          key={`${group.element} ${group.weaponType}`}
          css={css`
            border-top: 1px solid ${gray5};
            ::first-of-type {
              border-top: none;
            }
          `}
        >
          <AccountPassiveGroup data={group} />
        </li>
      ))}
    </ul>
  );
};
