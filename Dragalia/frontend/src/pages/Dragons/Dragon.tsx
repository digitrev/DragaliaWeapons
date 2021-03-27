/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { DragonData } from '../../api/DataInterfaces';

interface Props {
  data: DragonData;
}

export const Dragon: FC<Props> = ({ data: { dragon, rarity, element } }) => {
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
        {dragon}
      </div>
      <div>
        {rarity}⭐ {element === 'None' ? '' : element} Dragon
      </div>
    </div>
  );
};
