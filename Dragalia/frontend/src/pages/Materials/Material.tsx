/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { MaterialData } from '../../api/DataInterfaces';

interface Props {
  data: MaterialData;
}

export const Material: FC<Props> = ({ data: { material } }) => {
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
        {material}
      </div>
    </div>
  );
};
