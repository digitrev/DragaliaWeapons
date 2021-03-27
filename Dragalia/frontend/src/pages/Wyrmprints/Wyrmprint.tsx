/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { WyrmprintData } from '../../api/DataInterfaces';

interface Props {
  data: WyrmprintData;
}

export const Wyrmprint: FC<Props> = ({
  data: { wyrmprint, rarity, affinity, abilities },
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
        {wyrmprint}
      </div>
      <div>{rarity === 9 ? 'Dominion' : `${rarity}*`}</div>
      <div>Affinity: {affinity || 'None'}</div>
      <div>
        Skill(s):
        <ul>
          {abilities.map((a) => (
            <li>{a}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};
