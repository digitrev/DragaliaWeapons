/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { FC, useEffect, useState } from 'react';
import { AccountDragonData, MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { PrimaryButton } from '../../Styles';
import { Field } from '../Forms/Field';
import { Form, isInteger, nonNegative, required, Values } from '../Forms/Form';
import { Costs } from '../Costs/Costs';
import { Dragon } from './Dragon';

interface Props {
  data: AccountDragonData;
}

export const AccountDragon: FC<Props> = ({ data }) => {
  const { dragonId, dragon } = data;

  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getDragonCosts(dragonId);
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
  }, [costsRequested, dragonId, costUpdate]);

  const handleSubmit = async (values: Values) => {
    const api = new PrivateApi();
    let res: boolean;
    try {
      const updateDragon: AccountDragonData = {
        dragonId: values.dragonId,
        unbind: values.unbind,
        unbindWanted: values.unbindWanted,
      };
      await api.putDragon(values.dragonId, updateDragon);
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
      {dragon ? <Dragon data={dragon} /> : ''}
      <Form
        submitCaption="Update"
        onSubmit={handleSubmit}
        defaultValues={data}
        showSubmit={false}
        successMessage={'✔'}
        failureMessage={'❌'}
        validationRules={{
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
        }}
      >
        <div
          css={css`
            display: flex;
          `}
        >
          <Field name="unbind" label="Current Unbinds" type="Number" />
          <Field name="unbindWanted" label="Wanted Unbinds" type="Number" />
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
