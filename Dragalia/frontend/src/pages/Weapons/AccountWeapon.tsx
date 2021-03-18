/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC, Fragment, useEffect, useState } from 'react';
import {
  AccountWeaponData,
  MaterialCosts,
  WeaponLevelLimit,
  WeaponUnbindLimit,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { PrimaryButton } from '../../Styles';
import { Field } from '../Forms/Field';
import {
  Form,
  Values,
  isInteger,
  required,
  nonNegative,
  maxValue,
} from '../Forms/Form';
import { Costs } from '../Materials/Costs';
import { Weapon } from './Weapon';

interface Props {
  data: AccountWeaponData;
  unbindLimits: WeaponUnbindLimit[];
  levelLimits: WeaponLevelLimit[];
}

export const AccountWeapon: FC<Props> = ({
  data,
  unbindLimits,
  levelLimits,
}) => {
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
      const updateWeapon: AccountWeaponData = {
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
        dominion: values.dominion,
        dominionWanted: values.dominionWanted,
        bonus: values.bonus,
        bonusWanted: values.bonusWanted,
      };
      await api.putWeapon(values.weaponId, updateWeapon);
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
          copies: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: 4 },
          ],
          copiesWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: 4 },
          ],
          weaponLevel: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
          ],
          weaponLevelWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
          ],
          unbind: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
          ],
          unbindWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
          ],
          refine: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
          ],
          refineWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
          ],
        }}
      >
        <table>
          <tbody>
            <tr>
              <th />
              <th>Copies</th>
              <th>Weapon Level</th>
              <th>Unbind</th>
              {weapon?.weaponSeries !== 'Core' && <th>Refinement</th>}
              {weapon?.element !== 'None' && (
                <Fragment>
                  <th>Slots</th>
                  <th>Bonus</th>
                </Fragment>
              )}
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
              {weapon?.weaponSeries !== 'Core' && (
                <td>
                  <Field name="refine" type="Number" />
                </td>
              )}
              {weapon?.element !== 'None' && (
                <Fragment>
                  <td>
                    <Field name="slot" type="Number" />
                  </td>
                  <td>
                    <Field name="bonus" type="Number" />
                  </td>
                </Fragment>
              )}
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
              {weapon?.weaponSeries !== 'Core' && (
                <td>
                  <Field name="refineWanted" type="Number" />
                </td>
              )}
              {weapon?.element !== 'None' && (
                <Fragment>
                  <td>
                    <Field name="slotWanted" type="Number" />
                  </td>
                  <td>
                    <Field name="bonusWanted" type="Number" />
                  </td>
                </Fragment>
              )}
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
