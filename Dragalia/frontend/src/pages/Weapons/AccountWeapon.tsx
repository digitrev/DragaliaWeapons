/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { AccountWeaponData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { Field } from '../Forms/Field';
import { Form, Values } from '../Forms/Form';
import { Weapon } from './Weapon';

interface Props {
  data: AccountWeaponData;
}

export const AccountWeapon: FC<Props> = ({ data }) => {
  const handleSubmit = async (values: Values) => {
    const api = new PrivateApi();
    let res: boolean;
    try {
      await api.putWeapon(values.weaponId, {
        weaponId: values.weaponId,
        copies: values.copies,
        copiesWanted: values.copiesWanted,
        weaponLevel: values.weaponLevel,
        weaponLevelWanted: values.weaponLevelWanted,
        unbind: values.unbind,
        unbindWanted: values.unbindWanted,
        refine: values.refine,
        refineWanted: values.refineWanted,
        slot: values.slot,
        slotWanted: values.slotWanted,
        bonus: values.bonus,
        bonusWanted: values.bonusWanted,
      });
      res = true;
    } catch {
      res = false;
    }

    return { success: res };
  };

  const { weapon } = data;

  return (
    <div
      css={css`
        padding: 10px 0px;
      `}
    >
      {weapon ? <Weapon data={weapon} /> : ''}
      <Form
        submitCaption="Update"
        onSubmit={handleSubmit}
        defaultValues={data}
        showSubmit={false}
        successMessage={'✔'}
        failureMessage={'❌'}
      >
        <table>
          <tbody>
            <tr>
              <th />
              <th>Copies</th>
              <th>Weapon Level</th>
              <th>Unbind</th>
              <th>Refinement</th>
              <th>Slots</th>
              <th>Bonus</th>
            </tr>
            <tr>
              <th>Current</th>
              <td>
                <Field name="copies" type="Number" />
              </td>
              <td>
                <Field name="weaponLevel" type="Number" />
              </td>
              <td>
                <Field name="unbind" type="Number" />
              </td>
              <td>
                <Field name="refine" type="Number" />
              </td>
              <td>
                <Field name="slot" type="Checkbox" />
              </td>
              <td>
                <Field name="bonus" type="Checkbox" />
              </td>
            </tr>
            <tr>
              <th>Wanted</th>
              <td>
                <Field name="copiesWanted" type="Number" />
              </td>
              <td>
                <Field name="weaponLevelWanted" type="Number" />
              </td>
              <td>
                <Field name="unbindWanted" type="Number" />
              </td>
              <td>
                <Field name="refineWanted" type="Number" />
              </td>
              <td>
                <Field name="slotWanted" type="Checkbox" />
              </td>
              <td>
                <Field name="bonusWanted" type="Checkbox" />
              </td>
            </tr>
          </tbody>
        </table>
      </Form>
    </div>
  );
};
