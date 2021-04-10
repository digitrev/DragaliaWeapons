/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, Fragment, useEffect, useState } from 'react';
import NumberFormat from 'react-number-format';
import ReactPaginate from 'react-paginate';
import {
  AccountInventoryData,
  MaterialCosts,
} from '../../../api/DataInterfaces';
import { needed } from '../../../api/HelperFunctions';
import {
  displayLimit,
  marginPagesDisplayed,
  pageRangeDisplayed,
} from '../../../AppSettings';

interface Props {
  data: MaterialCosts[];
  items: AccountInventoryData[];
}

export const Breakdown: FC<Props> = ({ data, items }) => {
  const [displayItems, setDisplayItems] = useState<MaterialCosts[]>([]);
  const [offset, setOffset] = useState(0);
  const [pageCount, setPageCount] = useState(1);

  const handlePageChange = (selectedItem: { selected: number }) => {
    setOffset(selectedItem.selected * displayLimit);
  };

  useEffect(() => {
    setPageCount(Math.ceil(data.length / displayLimit));
    setDisplayItems(data.slice(offset, offset + displayLimit));
  }, [data, offset]);

  return (
    <Fragment>
      <table
        css={css`
          border-collapse: separate;
          border-spacing: 15px 0px;
        `}
      >
        <tbody>
          <tr>
            <th>Product</th>
            <th>Material</th>
            <th>Cost</th>
            <th>In Inventory</th>
            <th>Needed</th>
          </tr>
          {displayItems.map((mc) => (
            <tr key={`${mc.product} ${mc.material.materialId}`}>
              <td>{mc.product}</td>
              <td>{mc.material.material}</td>
              <td>
                <NumberFormat
                  displayType="text"
                  thousandSeparator={true}
                  isNumericString={true}
                  value={mc.quantity}
                />
              </td>
              <td>
                <NumberFormat
                  displayType="text"
                  thousandSeparator={true}
                  isNumericString={true}
                  value={
                    items.find((i) => i.materialId === mc.material.materialId)
                      ?.quantity
                  }
                />
              </td>
              <td>
                <NumberFormat
                  displayType="text"
                  thousandSeparator={true}
                  isNumericString={true}
                  value={needed(
                    mc.quantity,
                    items.find((i) => i.materialId === mc.material.materialId)
                      ?.quantity,
                  )}
                />
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <ReactPaginate
        pageCount={pageCount}
        pageRangeDisplayed={pageRangeDisplayed}
        marginPagesDisplayed={marginPagesDisplayed}
        onPageChange={handlePageChange}
        containerClassName="pagination"
        pageClassName="pages pagination"
        activeClassName="active"
        breakClassName="break-me"
      />
    </Fragment>
  );
};
