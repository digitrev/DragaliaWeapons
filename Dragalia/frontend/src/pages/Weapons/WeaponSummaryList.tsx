/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import {
  AccountWeaponData,
  ElementData,
  WeaponSeriesData,
  WeaponTypeData,
} from '../../api/DataInterfaces';
import { accent2, gray5 } from '../../Styles';
import { WeaponSummary } from './WeaponSummary';

interface Props {
  data: AccountWeaponData[];
  weaponSeries: WeaponSeriesData[];
  weaponTypes: WeaponTypeData[];
  elements: ElementData[];
}

export const WeaponSummaryList: FC<Props> = ({
  data,
  weaponTypes,
  elements,
  weaponSeries,
}) => (
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
    {weaponSeries.map((series) => (
      <li
        key={series.weaponSeries}
        css={css`
          border-top: 1px solid ${gray5};
          ::first-of-type {
            border-top: none;
          }
        `}
      >
        <WeaponSummary
          data={data.filter(
            (aw) => aw.weapon?.weaponSeries === series.weaponSeries,
          )}
          elements={elements}
          weaponSeries={series.weaponSeries}
          weaponTypes={weaponTypes}
        />
      </li>
    ))}
  </ul>
);
