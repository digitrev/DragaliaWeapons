/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { PassiveData } from '../../api/DataInterfaces';

interface Props {
  data: PassiveData;
}

export const Passive: FC<Props> = ({
  data: { passiveID, abilityNumber, ability, element, weaponType },
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
        `}
      >
        {ability}
      </div>
    </div>
  );
};
