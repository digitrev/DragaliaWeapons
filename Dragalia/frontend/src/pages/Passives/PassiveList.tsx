/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { PassiveData, PassiveGroupData } from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { PassiveGroup } from './PassiveGroup';

interface Props {
  data: PassiveData[];
}

export const PassiveList: FC<Props> = ({ data }) => {
  const groups = data.reduce<PassiveGroupData[]>((acc, cur) => {
    const ind = acc.findIndex(
      (x) => x.element === cur.element && x.weaponType === cur.weaponType,
    );
    if (ind >= 0) {
      acc[ind].passives.push(cur);
    } else {
      acc.push({
        element: cur.element,
        weaponType: cur.weaponType,
        passives: [cur],
      });
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
          <PassiveGroup data={group} />
        </li>
      ))}
    </ul>
  );
};
