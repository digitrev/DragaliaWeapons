/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC, Fragment, useEffect, useState } from 'react';
import NumberFormat from 'react-number-format';
import {
  AccountInventoryData,
  MaterialCosts,
  MaterialData,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
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
  const [items, setItems] = useState<AccountInventoryData[]>([]);

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

  useEffect(() => {
    setSummaryData(sumByMaterial(data));
    const doGetItems = async () => {
      const api = new PrivateApi();
      const itemData = await api.getItemFilter([
        ...Array.from(new Set(data.map<string>((d) => d.material.materialId))),
      ]);
      setItems(itemData);
    };
    doGetItems();
  }, [data]);

  const needed = (
    cost: number | undefined,
    inventory: number | undefined,
  ): number => {
    if (cost === undefined || inventory === undefined) {
      return 0;
    } else {
      return Math.max(0, cost - inventory);
    }
  };

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
            <th>In Inventory</th>
            <th>Needed</th>
          </tr>
          {displayType === 'Summary' &&
            summaryData.map((sd) => (
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
          {displayType === 'Breakdown' &&
            data.map((mc) => (
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
                  {' '}
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
    </Fragment>
  );
};
