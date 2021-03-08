/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC, Fragment, useEffect, useState } from 'react';
import { MaterialCosts, MaterialData } from '../../api/DataInterfaces';
import { PrimaryButton } from '../../Styles';

interface Props {
  data: MaterialCosts[];
}

interface SummaryTable {
  material: MaterialData;
  sum: number;
}

type DisplayType = 'Summary' | 'Breakdown';

export const Costs: FC<Props> = ({ data }) => {
  const [summaryData, setSummaryData] = useState<SummaryTable[]>([]);
  const [displayType, setDisplayType] = useState<DisplayType>('Summary');

  const sumByMaterial = (c: MaterialCosts[]): SummaryTable[] => {
    return c.reduce<SummaryTable[]>((acc, cur) => {
      const x = acc.find(
        (mc) => mc.material.material === cur.material.material,
      );
      if (x === undefined) {
        acc.push({
          material: cur.material,
          sum: cur.quantity,
        });
      } else {
        x.sum += cur.quantity;
      }
      return acc;
    }, []);
  };

  const handleDisplay = () => {
    switch (displayType) {
      case 'Breakdown':
        setDisplayType('Summary');
        break;
      case 'Summary':
        setDisplayType('Breakdown');
        break;
    }
  };

  useEffect(() => setSummaryData(sumByMaterial(data)), [data]);

  return (
    <Fragment>
      <PrimaryButton
        css={css`
          margin-left: 10px;
          margin-top: 10px;
        `}
        onClick={handleDisplay}
      >
        {displayType}
      </PrimaryButton>
      <table
        css={css`
          border-collapse: separate;
          border-spacing: 15px 0px;
        `}
      >
        <tbody>
          <tr>
            {displayType === 'Breakdown' && <th>Product</th>}
            <th>Material</th>
            <th>Cost</th>
          </tr>
          {displayType === 'Summary' &&
            summaryData.map((sd) => (
              <tr key={sd.material.materialId}>
                <td>{sd.material.material}</td>
                <td>{sd.sum}</td>
              </tr>
            ))}
          {displayType === 'Breakdown' &&
            data.map((mc) => (
              <tr key={`${mc.product} ${mc.material.materialId}`}>
                <td>{mc.product}</td>
                <td>{mc.material.material}</td>
                <td>{mc.quantity}</td>
              </tr>
            ))}
        </tbody>
      </table>
    </Fragment>
  );
};
