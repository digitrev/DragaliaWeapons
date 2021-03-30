/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import { QuestData } from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { Quest } from './Quest';

interface Props {
  data: QuestData[];
}

export const QuestList: FC<Props> = ({ data }) => {
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
      {data.map((quest) => (
        <li
          key={quest.questId}
          css={css`
            border-top: 1px solid ${gray5};
            ::first-of-type {
              border-top: none;
            }
          `}
        >
          <Quest data={quest} />
        </li>
      ))}
    </ul>
  );
};
