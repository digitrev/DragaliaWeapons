/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC } from 'react';
import { AccountInventoryData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { getAccessToken } from '../Auth/Auth';
import { Field } from '../Forms/Field';
import { Form, Values, isInteger, required, nonNegative } from '../Forms/Form';
import { Material } from './Material';

interface Props {
  data: AccountInventoryData;
}

export const Inventory: FC<Props> = ({ data }) => {
  const handleSubmit = async (values: Values) => {
    const token = await getAccessToken();
    const api = new PrivateApi(token);
    let res: boolean;
    try {
      await api.putItem(values.materialId, {
        materialId: values.weaponId,
        quantity: values.quantity,
      });
      res = true;
    } catch {
      res = false;
    }

    return { success: res };
  };

  const { material } = data;

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
        validationRules={{
          quantity: [
            { validator: isInteger },
            { validator: required },
            { validator: nonNegative },
          ],
        }}
      >
        <table>
          <tbody>
            <tr>
              <td>{material ? <Material data={material} /> : ''}</td>
              <td>
                <Field name="quantity" type="Number" />
              </td>
            </tr>
          </tbody>
        </table>
      </Form>
    </div>
  );
};
