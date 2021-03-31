/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { InventoryCategoryData } from '../../api/DataInterfaces';
import { gray5 } from '../../Styles';
import { Inventory } from './Inventory';

interface Props {
  data: InventoryCategoryData;
}

export const InventoryCategory: FC<Props> = ({ data: { category, items } }) => {
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
        {items.map((item) => (
          <li
            key={item.materialId}
            css={css`
              border-top: 1px solid ${gray5};
              ::first-of-type {
                border-top: none;
              }
            `}
          >
            <Inventory data={item} />
          </li>
        ))}
      </ul>
    </div>
  );
};
