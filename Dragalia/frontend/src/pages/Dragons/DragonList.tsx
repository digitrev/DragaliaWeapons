/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { DragonData } from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { Dragon } from './Dragon';

interface Props {
  data: DragonData[];
}

export const DragonList: FC<Props> = ({ data }) => {
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
      {data.map((dragon) => (
        <li
          key={dragon.dragonId}
          css={css`
            border-top: 1px solid ${gray5};
            ::first-of-type {
              border-top: none;
            }
          `}
        >
          <Dragon data={dragon} />
        </li>
      ))}
    </ul>
  );
};