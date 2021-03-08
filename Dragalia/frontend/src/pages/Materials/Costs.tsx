/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC, useEffect, useState } from 'react';
import { MaterialCosts } from '../../api/DataInterfaces';

interface Props {
  data: MaterialCosts[];
}

export const Costs: FC<Props> = ({ data }) => {
  const [materialCosts, setMaterialCosts] = useState<MaterialCosts[]>(data);

  const sumByMaterial = (c: MaterialCosts[]): MaterialCosts[] => {
    return c.reduce<MaterialCosts[]>((acc, cur) => {
      const x = acc.find(
        (mc) => mc.material.material === cur.material.material,
      );
      if (x === undefined) {
        acc.push({
          material: cur.material,
          quantity: cur.quantity,
          product: 'Total',
        });
      } else {
        x.quantity += cur.quantity;
      }
      return acc;
    }, []);
  };

  useEffect(() => setMaterialCosts(sumByMaterial(data)), [data]);

  return (
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
        </tr>
        {materialCosts.map((mc) => (
          <tr key={`${mc.material.materialId} ${mc.product}`}>
            <td>{mc.product}</td>
            <td>{mc.material.material}</td>
            <td>{mc.quantity}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};
