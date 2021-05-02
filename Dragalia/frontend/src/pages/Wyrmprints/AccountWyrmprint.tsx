/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, useEffect, useState } from 'react';
import {
  AccountWyrmprintData,
  MaterialCosts,
  WyrmprintLimit,
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
import { Wyrmprint } from './Wyrmprint';
import Accordion from '@material-ui/core/Accordion';
import AccordionSummary from '@material-ui/core/AccordionSummary';
import AccordionDetails from '@material-ui/core/AccordionDetails';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';

interface Props {
  data: AccountWyrmprintData;
  limits: WyrmprintLimit;
  accordionStatus?: { [key: number]: boolean };
  updateAccordion?: (id: number, status: boolean) => void;
}

export const AccountWyrmprint: FC<Props> = ({
  data,
  limits,
  accordionStatus,
  updateAccordion,
}) => {
  const { wyrmprintId, wyrmprint } = data;

  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getWyrmprintCosts(wyrmprintId);
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
  }, [costsRequested, wyrmprintId, costUpdate]);

  const handleSubmit = async (values: Values) => {
    const api = new PrivateApi();
    let res: boolean;
    try {
      const updateWyrmprint: AccountWyrmprintData = {
        wyrmprintId: values.wyrmprintId,
        copies: values.copies,
        copiesWanted: values.copiesWanted,
        wyrmprintLevel: values.wyrmprintLevel,
        wyrmprintLevelWanted: values.wyrmprintLevelWanted,
        unbind: values.unbind,
        unbindWanted: values.unbindWanted,
      };
      await api.putWyrmprint(values.wyrmprintId, updateWyrmprint);
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
        expanded={(accordionStatus && accordionStatus[wyrmprintId]) || false}
        onChange={(event, expanded) =>
          updateAccordion && updateAccordion(wyrmprintId, expanded)
        }
      >
        <AccordionSummary expandIcon={<ExpandMoreIcon />}>
          {wyrmprint ? <Wyrmprint data={wyrmprint} /> : ''}
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
              wyrmprintLevel: [
                { validator: isInteger },
                { validator: required },
                { validator: nonNegative },
                { validator: maxValue, arg: limits?.level },
              ],
              wyrmprintLevelWanted: [
                { validator: isInteger },
                { validator: required },
                { validator: nonNegative },
                { validator: maxValue, arg: limits?.level },
              ],
              unbind: [
                { validator: isInteger },
                { validator: required },
                { validator: nonNegative },
                { validator: maxValue, arg: 4 },
              ],
              unbindWanted: [
                { validator: isInteger },
                { validator: required },
                { validator: nonNegative },
                { validator: maxValue, arg: 4 },
              ],
            }}
          >
            <table>
              <tbody>
                <tr>
                  <th />
                  <th>Copies</th>
                  <th>Wyrmprint Level</th>
                  <th>Unbind</th>
                </tr>
                <tr>
                  <th>Current</th>
                  <td>
                    <Field name="copies" type="Number" />
                  </td>
                  <td>
                    <Field name="wyrmprintLevel" type="Number" />
                  </td>
                  <td>
                    <Field name="unbind" type="Number" />
                  </td>
                </tr>
                <tr>
                  <th>Wanted</th>
                  <td>
                    <Field name="copiesWanted" type="Number" />
                  </td>
                  {
                    <td>
                      <Field name="wyrmprintLevelWanted" type="Number" />
                    </td>
                  }
                  <td>
                    <Field name="unbindWanted" type="Number" />
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
        </AccordionDetails>
      </Accordion>
    </div>
  );
};
