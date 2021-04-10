/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import {
  AccountFacilityCategoryData,
  AccountFacilityData,
  FacilityLimit,
} from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { AccountFacilityCategory } from './AccountFacilityCategory';

interface Props {
  data: AccountFacilityData[];
  limits: FacilityLimit[];
}

export const AccountFacilityList: FC<Props> = ({ data, limits }) => {
  const categories: AccountFacilityCategoryData[] = [];
  [
    ...Array.from(
      new Set(
        data
          .filter((accountFacility) => accountFacility.facility !== undefined)
          .map((accountFacility) => accountFacility.facility!.category),
      ),
    ),
  ].forEach((cat) =>
    categories.push({
      category: cat,
      accountFacilities: data.filter(
        (accountFacility) => accountFacility.facility!.category === cat,
      ),
    }),
  );

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
      {categories.map((category) => (
        <li
          key={category.category}
          css={css`
            border-top: 1px solid ${gray5};
            ::first-of-type {
              border-top: none;
            }
          `}
        >
          <AccountFacilityCategory data={category} limits={limits} />
        </li>
      ))}
    </ul>
  );
};
