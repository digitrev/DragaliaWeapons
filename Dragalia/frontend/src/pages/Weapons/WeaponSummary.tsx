/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import React, { FC, Fragment } from 'react';
import {
  AccountWeaponData,
  ElementData,
  WeaponTypeData,
} from '../../api/DataInterfaces';
import { ElementIcon, ElementString } from '../../components/ElementIcon';
import { WeaponIcon, WeaponString } from '../../components/WeaponIcon';

interface Props {
  data: AccountWeaponData[];
  weaponSeries: string;
  weaponTypes: WeaponTypeData[];
  elements: ElementData[];
}

export const WeaponSummary: FC<Props> = ({
  data,
  weaponSeries,
  weaponTypes,
  elements,
}) => {
  const getSummaryString = (w: AccountWeaponData | undefined) => {
    if (w === undefined || w.copies === 0) {
      return '-';
    }
    return `${w.unbind}.${w.refine}`;
  };

  // useEffect(() => {
  //   console.log(data);
  // }, [data]);

  return (
    <Fragment>
      <h4>{weaponSeries}</h4>
      <table
        css={css`
          border-collapse: separate;
          border-spacing: 15px 0px;
        `}
      >
        <tbody>
          <tr>
            <th></th>
            {elements.map((e) => (
              <th>
                <ElementIcon element={e.element as ElementString} />
                {/* {e.element} */}
              </th>
            ))}
          </tr>
          {weaponTypes.map((wt) => (
            <tr>
              <td>
                <WeaponIcon weaponType={wt.weaponType as WeaponString} />
                {/* {wt.weaponType} */}
              </td>
              {elements.map((e) => (
                <td>
                  {getSummaryString(
                    data.find(
                      (aw) =>
                        aw.weapon?.weaponType === wt.weaponType &&
                        aw.weapon.element === e.element,
                    ),
                  )}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </Fragment>
  );
};
