/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC, useEffect, useState } from 'react';
import { AccountWeaponData, MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { PrimaryButton } from '../../Styles';
import { Field } from '../Forms/Field';
import { Form, Values, isInteger, required } from '../Forms/Form';
import { Costs } from '../Materials/Costs';
import { Weapon } from './Weapon';

interface Props {
  data: AccountWeaponData;
}

export const AccountWeapon: FC<Props> = ({ data }) => {
  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  const { weaponId, weapon } = data;

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getWeaponCosts(weaponId);
      if (!cancelled) {
        setCosts(costData);
        setCostsLoading(false);
      }
    };
    if (costsRequested) {
      doGetCosts();
    }
    return () => {
      cancelled = true;
    };
  }, [costsRequested, weaponId, costUpdate]);

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
      setCostUpdate(!costUpdate);
    } catch {
      res = false;
    }

    return { success: res };
  };

  const handleCosts = () => {
    setCostsRequested(true);
  };

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
                <Field name="slot" type="Number" />
              </td>
              <td>
                <Field name="bonus" type="Number" />
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
                <Field name="slotWanted" type="Number" />
              </td>
              <td>
                <Field name="bonusWanted" type="Number" />
              </td>
            </tr>
          </tbody>
        </table>
      </Form>
      {costsRequested ? (
        costsLoading ? (
          <LoadingText />
        ) : (
          <Costs data={costs || []} />
        )
      ) : (
        <PrimaryButton
          css={css`
            margin-top: 10px;
          `}
          onClick={handleCosts}
        >
          Costs
        </PrimaryButton>
      )}
    </div>
  );
};
