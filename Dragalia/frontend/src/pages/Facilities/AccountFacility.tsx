/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, useEffect, useState } from 'react';
import {
  AccountFacilityData,
  FacilityLimit,
  MaterialCosts,
} from '../../api/DataInterfaces';
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
import { Facility } from './Facility';

interface Props {
  data: AccountFacilityData;
  limits: FacilityLimit;
}

export const AccountFacility: FC<Props> = ({ data, limits }) => {
  const [costs, setCosts] = useState<MaterialCosts[] | null>(null);
  const [costsLoading, setCostsLoading] = useState(true);
  const [costsRequested, setCostsRequested] = useState(false);
  const [costUpdate, setCostUpdate] = useState(false);

  const { facility, facilityId, copyNumber } = data;

  useEffect(() => {
    let cancelled = false;
    const doGetCosts = async () => {
      const api = new PrivateApi();
      const costData = await api.getFacilityCosts(facilityId, copyNumber);
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
  }, [costsRequested, facilityId, copyNumber, costUpdate]);

  const handleSubmit = async (values: Values) => {
    const api = new PrivateApi();
    let res: boolean;
    try {
      await api.putFacility(values.facilityId, values.copyNumber, {
        facilityId: values.facilityId,
        copyNumber: values.copyNumber,
        currentLevel: values.currentLevel,
        wantedLevel: values.wantedLevel,
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
      {facility && (
        <div
          css={css`
            display: flex;
          `}
        >
          <Facility
            data={{
              ...facility,
              facility:
                facility.facility + (copyNumber > 1 ? ` #${copyNumber}` : ''),
            }}
            showLimit={false}
          />
        </div>
      )}
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
            { validator: maxValue, arg: limits.maxLevel },
          ],
          currentLevel: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
            { validator: maxValue, arg: limits.maxLevel },
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
