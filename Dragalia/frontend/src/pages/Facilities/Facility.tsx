/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { FacilityData } from '../../api/DataInterfaces';

interface Props {
  data: FacilityData;
  showLimit?: boolean;
}

export const Facility: FC<Props> = ({
  data: { facility, limit },
  showLimit = true,
}) => {
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
        {facility}
      </div>
      {showLimit && <div>Max {limit}</div>}
    </div>
  );
};
