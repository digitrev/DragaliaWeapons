/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, useEffect, useState } from 'react';
import { AccountPassiveData, MaterialCosts } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/UserData';
import { LoadingText } from '../Loading';
import { PrimaryButton } from '../../Styles';
import { Field } from '../Forms/Field';
import { Form, Values } from '../Forms/Form';
import { Costs } from '../Costs/Costs';
import { Passive } from './Passive';

interface Props {
  data: AccountPassiveData;
}

export const AccountPassive: FC<Props> = ({ data }) => {
  const { passiveId, passive } = data;

  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getPassiveCosts(passiveId);
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
  }, [costsRequested, passiveId, costUpdate]);

  const handleSubmit = async (values: Values) => {
    const api = new PrivateApi();
    let res: boolean;
    try {
      await api.putPassive(values.passiveId, {
        passiveId: values.passiveId,
        owned: values.owned,
        wanted: values.wanted,
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
      <Form
        submitCaption="Update"
        onSubmit={handleSubmit}
        defaultValues={data}
        showSubmit={false}
        successMessage={'✔'}
        failureMessage={'❌'}
      >
        <table
          css={css`
            border-collapse: separate;
            border-spacing: 15px 0px;
          `}
        >
          <tbody>
            <tr>
              <td>{passive ? <Passive data={passive} /> : ''} </td>
              <td>
                <Field label="Owned" name="owned" type="Checkbox" />
              </td>
              <td>
                <Field label="Wanted" name="wanted" type="Checkbox" />
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
