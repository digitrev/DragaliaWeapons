/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { MaterialData } from '../../api/PublicData';

interface Props {
  data: MaterialData;
}

export const Material: FC<Props> = ({ data }) => {
  const { material } = data;
  return (
    <div
      css={css`
        padding: 10px 0px;
      `}
    >
      <div
        css={css`
          padding: 10px 0px;
          font-size: 14px;
        `}
      >
        {material}
      </div>
    </div>
  );
};
