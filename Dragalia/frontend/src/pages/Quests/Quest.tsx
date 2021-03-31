/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import { QuestData } from '../../api/DataInterfaces';

interface Props {
  data: QuestData;
}

export const Quest: FC<Props> = ({ data: { quest } }) => {
  return (
    <div
      css={css`
        padding: 10px 0px;
        width: 200px;
      `}
    >
      <div
        css={css`
          padding: 10px 0px;
          font-size: 15px;
          /* font-weight: bold; */
        `}
      >
        {quest}
      </div>
    </div>
  );
};
