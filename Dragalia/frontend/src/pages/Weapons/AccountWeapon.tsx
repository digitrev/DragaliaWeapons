/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC, useEffect, useState } from 'react';
import {
  AccountWeaponData,
  MaterialCosts,
  WeaponLimit,
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
  limits: WeaponLimit;
}

export const AccountWeapon: FC<Props> = ({ data, limits }) => {
  const { weaponId, weapon } = data;

  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

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
            { validator: maxValue, arg: limits?.level },
          ],
          weaponLevelWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.level },
          ],
          unbind: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.unbind },
          ],
          unbindWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.unbind },
          ],
          refine: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.refinement },
          ],
          refineWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.refinement },
          ],
          slot: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.slots },
          ],
          slotWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.slots },
          ],
          dominion: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.dominion },
          ],
          dominionWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.dominion },
          ],
          bonus: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.bonus },
          ],
          bonusWanted: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits?.bonus },
          ],
        }}
      >
        <table>
          <tbody>
            <tr>
              <th />
              <th>Copies</th>
              <th>Weapon Level</th>
              {limits.unbind > 0 && <th>Unbind</th>}
              {limits.refinement > 0 && <th>Refinement</th>}
              {limits.slots > 0 && <th>5⭐ Slots</th>}
              {limits.dominion > 0 && <th>Dominion Slots</th>}
              {limits.bonus > 0 && <th>Bonus</th>}
            </tr>
            <tr>
              <th>Current</th>
              <td>
                <Field name="copies" type="Number" />
              </td>
              <td>
                <Field name="weaponLevel" type="Number" />
              </td>
              {limits.unbind > 0 && (
                <td>
                  <Field name="unbind" type="Number" />
                </td>
              )}
              {limits.refinement > 0 && (
                <td>
                  <Field name="refine" type="Number" />
                </td>
              )}
              {limits.slots > 0 && (
                <td>
                  <Field name="slot" type="Number" />
                </td>
              )}
              {limits.dominion > 0 && (
                <td>
                  <Field name="dominion" type="Number" />
                </td>
              )}
              {limits.bonus > 0 && (
                <td>
                  <Field name="bonus" type="Number" />
                </td>
              )}{' '}
            </tr>
            <tr>
              <th>Wanted</th>
              <td>
                <Field name="copiesWanted" type="Number" />
              </td>
              {
                <td>
                  <Field name="weaponLevelWanted" type="Number" />
                </td>
              }
              {limits.unbind > 0 && (
                <td>
                  <Field name="unbindWanted" type="Number" />
                </td>
              )}
              {limits.refinement > 0 && (
                <td>
                  <Field name="refineWanted" type="Number" />
                </td>
              )}
              {limits.slots > 0 && (
                <td>
                  <Field name="slotWanted" type="Number" />
                </td>
              )}
              {limits.dominion > 0 && (
                <td>
                  <Field name="dominionWanted" type="Number" />
                </td>
              )}
              {limits.bonus > 0 && (
                <td>
                  <Field name="bonusWanted" type="Number" />
                </td>
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
