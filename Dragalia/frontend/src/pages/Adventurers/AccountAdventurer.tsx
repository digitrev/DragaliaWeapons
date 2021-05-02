/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, useEffect, useState } from 'react';
import { AccountAdventurerData, MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
import { PrimaryButton } from '../../Styles';
import { Field } from '../Forms/Field';
import {
  Form,
  isInteger,
  maxValue,
  nonNegative,
  required,
  Values,
} from '../Forms/Form';
import { Costs } from '../Costs/Costs';
import { Adventurer } from './Adventurer';
import { useAuth } from '../Auth/Auth';
import Accordion from '@material-ui/core/Accordion';
import AccordionSummary from '@material-ui/core/AccordionSummary';
import AccordionDetails from '@material-ui/core/AccordionDetails';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';

interface Props {
  data: AccountAdventurerData;
  accordionStatus?: { [key: number]: boolean };
  updateAccordion?: (id: number, status: boolean) => void;
}

export const AccountAdventurer: FC<Props> = ({
  data,
  accordionStatus,
  updateAccordion,
}) => {
  const { getAccessToken } = useAuth();
  const { adventurerId, adventurer } = data;

  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const costData = await api.getAdventurerCosts(adventurerId);
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
  }, [costsRequested, adventurerId, costUpdate, getAccessToken]);

  const handleSubmit = async (values: Values) => {
    const token = await getAccessToken();
    const api = new PrivateApi(token);
    let res: boolean;
    try {
      const updateAdventurer: AccountAdventurerData = {
        adventurerId: values.adventurerId,
        currentLevel: values.currentLevel,
        wantedLevel: values.wantedLevel,
      };
      await api.putAdventurer(values.adventurerId, updateAdventurer);
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
        expanded={(accordionStatus && accordionStatus[adventurerId]) || false}
        onChange={(event, expanded) =>
          updateAccordion && updateAccordion(adventurerId, expanded)
        }
      >
        <AccordionSummary expandIcon={<ExpandMoreIcon />}>
          {adventurer ? <Adventurer data={adventurer} /> : ''}
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
            showSubmit={false}
            successMessage={'✔'}
            failureMessage={'❌'}
            validationRules={{
              wantedLevel: [
                { validator: isInteger },
                { validator: required },
                { validator: nonNegative },
                { validator: maxValue, arg: adventurer!.mcLimit },
              ],
              currentLevel: [
                { validator: isInteger },
                { validator: required },
                { validator: nonNegative },
                { validator: maxValue, arg: adventurer!.mcLimit },
              ],
            }}
          >
            <div
              css={css`
                display: flex;
              `}
            >
              <Field name="currentLevel" label="Current MC" type="Number" />
              <Field name="wantedLevel" label="Wanted MC" type="Number" />
            </div>
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
          </Form>
        </AccordionDetails>
      </Accordion>
    </div>
  );
};
