/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import React, { FC } from 'react';
import { DragonData } from '../../api/DataInterfaces';
import { ElementIcon, ElementString } from '../../components/ElementIcon';

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
        {dragon}{' '}
        {element !== 'None' && (
          <ElementIcon element={element as ElementString} />
        )}
      </div>
      <div>
        {rarity}⭐ {element === 'None' ? '' : element} Dragon
      </div>
    </div>
  );
};
