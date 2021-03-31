/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import { MaterialData, MaterialCategoryData } from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { MaterialCategory } from './MaterialCategory';

interface Props {
  data: MaterialData[];
}

export const MaterialList: FC<Props> = ({ data }) => {
  const categories: MaterialCategoryData[] = [];
  [...Array.from(new Set(data.map((material) => material.category)))].forEach(
    (cat) =>
      categories.push({
        category: cat,
        materials: data.filter((mat) => mat.category === cat),
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
          <MaterialCategory data={category} />
        </li>
      ))}
    </ul>
  );
};
