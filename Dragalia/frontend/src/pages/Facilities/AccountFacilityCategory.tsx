/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { AccountFacilityCategoryData } from '../../api/DataInterfaces';
import { gray5 } from '../../Styles';
import { AccountFacility } from './AccountFacility';

interface Props {
  data: AccountFacilityCategoryData;
}

export const AccountFacilityCategory: FC<Props> = ({
  data: { category, accountFacilities },
}) => {
  return (
    <div
      css={css`
        padding: 10px 0px;
      `}
    >
      <div
        css={css`
          padding: 10px 0px;
          font-size: 19px;
        `}
      >
        {category}
      </div>
      <ul
        css={css`
          list-style: none;
          margin: 10px 0 0 0;
          padding: 0px 20px;
          background-color: #fff;
          border-bottom-left-radius: 4px;
          border-bottom-right-radius: 4px;
          box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
        `}
      >
        {accountFacilities.map((accountFacility) => (
          <li
            key={`${accountFacility.facilityId} ${accountFacility.copyNumber}`}
            css={css`
              border-top: 1px solid ${gray5};
              ::first-of-type {
                border-top: none;
              }
            `}
          >
            <AccountFacility data={accountFacility} />
          </li>
        ))}
      </ul>
    </div>
  );
};
