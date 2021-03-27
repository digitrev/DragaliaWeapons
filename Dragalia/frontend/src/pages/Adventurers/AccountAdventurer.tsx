/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC, useEffect, useState } from 'react';
import { AccountAdventurerData, MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
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

interface Props {
  data: AccountAdventurerData;
}

export const AccountAdventurer: FC<Props> = ({ data }) => {
  const { adventurerId, adventurer } = data;

  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
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
  }, [costsRequested, adventurerId, costUpdate]);

  const handleSubmit = async (values: Values) => {
    const api = new PrivateApi();
    let res: boolean;
    try {
      const updateAdventurer: AccountAdventurerData = {
        adventurerId: values.adventurerId,
        currentLevel: values.currentLevel,
        wantedLevel: values.wantedLevel,
      };
      await api.putAdventurer(values.weaponId, updateAdventurer);
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
      {adventurer ? <Adventurer data={adventurer} /> : ''}
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
          <Field name="currentLevel" label="Current Level" type="Number" />
          <Field name="wantedLevel" label="Wanted Level" type="Number" />
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
    </div>
  );
};
