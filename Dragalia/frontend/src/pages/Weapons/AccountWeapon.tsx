/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC } from 'react';
import { DisplayWeaponData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { Field } from '../Forms/Field';
import { Form, Values, isInteger, required } from '../Forms/Form';
import { Weapon } from './Weapon';

interface Props {
  data: DisplayWeaponData;
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
        padding-bottom: 10px;
      `}
    >
      {weapon ? <Weapon data={weapon} /> : ''}
      <Form
        submitCaption="Update"
        onSubmit={handleSubmit}
        defaultValues={data}
        showSubmit={true}
        successMessage={'✔'}
        failureMessage={'❌'}
        validationRules={{
          copies: [{ validator: isInteger }, { validator: required }],
          copiesWanted: [{ validator: isInteger }, { validator: required }],
          weaponLevel: [{ validator: isInteger }, { validator: required }],
          weaponLevelWanted: [
            { validator: isInteger },
            { validator: required },
          ],
          unbind: [{ validator: isInteger }, { validator: required }],
          unbindWanted: [{ validator: isInteger }, { validator: required }],
          refine: [{ validator: isInteger }, { validator: required }],
          refineWanted: [{ validator: isInteger }, { validator: required }],
        }}
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
