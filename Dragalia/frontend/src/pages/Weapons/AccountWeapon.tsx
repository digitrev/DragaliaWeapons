/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, useEffect, useState } from 'react';
import {
  AccountWeaponData,
  MaterialCosts,
  WeaponLimit,
} from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
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
import { Costs } from '../Costs/Costs';
import { Weapon } from './Weapon';
import { useAuth } from '../Auth/Auth';
import Accordion from '@material-ui/core/Accordion';
import AccordionSummary from '@material-ui/core/AccordionSummary';
import AccordionDetails from '@material-ui/core/AccordionDetails';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';

interface Props {
  data: AccountWeaponData;
  limits: WeaponLimit;
  accordionStatus?: { [key: number]: boolean };
  updateAccordion?: (id: number, status: boolean) => void;
}

export const AccountWeapon: FC<Props> = ({
  data,
  limits,
  accordionStatus,
  updateAccordion,
}) => {
  const { getAccessToken } = useAuth();
  const { weaponId, weapon } = data;

  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
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
  }, [costsRequested, weaponId, costUpdate, getAccessToken]);

  const handleSubmit = async (values: Values) => {
    const token = await getAccessToken();
    const api = new PrivateApi(token);
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
      <Accordion
        expanded={(accordionStatus && accordionStatus[weaponId]) || false}
        onChange={(event, expanded) =>
          updateAccordion && updateAccordion(weaponId, expanded)
        }
      >
        <AccordionSummary expandIcon={<ExpandMoreIcon />}>
          {weapon ? <Weapon data={weapon} /> : ''}
        </AccordionSummary>
        <AccordionDetails
          css={css`
            flex-direction: column;
          `}
        >
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
                  )}
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
        </AccordionDetails>
      </Accordion>
    </div>
  );
};
