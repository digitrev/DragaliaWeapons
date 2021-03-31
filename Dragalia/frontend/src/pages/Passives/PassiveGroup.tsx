/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import { PassiveGroupData } from '../../api/DataInterfaces';
import { gray5 } from '../../Styles';
import { Passive } from './Passive';

interface Props {
  data: PassiveGroupData;
}

export const PassiveGroup: FC<Props> = ({
  data: { element, weaponType, passives },
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
        {element} {weaponType}
      </div>
      <ul
        css={css`
          list-style: none;
          margin: 10px 0 0 0;
          padding: 0px 20px;
          background-color: #fff;
          border-bottom-left-radius: 4px;
          border-bottom-right-radius: 4px;
          box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
        `}
      >
        {passives.map((passive) => (
          <li
            key={passive.passiveId}
            css={css`
              border-top: 1px solid ${gray5};
              ::first-of-type {
                border-top: none;
              }
            `}
          >
            <Passive data={passive} />
          </li>
        ))}
      </ul>
    </div>
  );
};
