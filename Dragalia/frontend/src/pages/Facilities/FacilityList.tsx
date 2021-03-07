/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import { FacilityCategoryData, FacilityData } from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { FacilityCategory } from './FacilityCategory';

interface Props {
  data: FacilityData[];
}

export const FacilityList: FC<Props> = ({ data }) => {
  const categories: FacilityCategoryData[] = [];
  [...Array.from(new Set(data.map((facility) => facility.category)))].forEach(
    (cat) =>
      categories.push({
        category: cat,
        facilities: data.filter((fac) => fac.category === cat),
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
          <FacilityCategory data={category} />
        </li>
      ))}
    </ul>
  );
};
