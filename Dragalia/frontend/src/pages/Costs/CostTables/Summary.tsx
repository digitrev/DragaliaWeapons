/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import NumberFormat from 'react-number-format';
import { AccountInventoryData } from '../../../api/DataInterfaces';
import { needed } from '../../../api/HelperFunctions';
import { SummaryTable } from '../Costs';

interface Props {
  data: SummaryTable[];
  items: AccountInventoryData[];
}

export const Summary: FC<Props> = ({ data, items }) => (
  <table
    css={css`
      border-collapse: separate;
      border-spacing: 15px 0px;
    `}
  >
    <tbody>
      <tr>
        <th>Material</th>
        <th>Cost</th>
        <th>In Inventory</th>
        <th>Needed</th>
      </tr>
      {data.map((sd) => (
        <tr key={sd.material.materialId}>
          <td>{sd.material.material}</td>
          <td>
            <NumberFormat
              displayType="text"
              thousandSeparator={true}
              isNumericString={true}
              value={sd.sum}
            />
          </td>
          <td>
            <NumberFormat
              displayType="text"
              thousandSeparator={true}
              isNumericString={true}
              value={
                items.find((i) => i.materialId === sd.material.materialId)
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
                sd.sum,
                items.find((i) => i.materialId === sd.material.materialId)
                  ?.quantity,
              )}
            />
          </td>
        </tr>
      ))}
    </tbody>
  </table>
);
