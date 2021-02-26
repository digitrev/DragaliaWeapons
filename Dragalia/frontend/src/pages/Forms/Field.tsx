/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { ChangeEvent, FC, useContext } from 'react';
import { fontFamily, fontSize, gray5, gray2, gray6 } from '../../Styles';
import { FormContext } from './Form';
import Select, { ActionMeta, OptionTypeBase } from 'react-select';

export interface SubmitOption {
  label: string;
  value: string;
}

interface Props {
  name: string;
  label?: string;
  type?:
    | 'Text'
    | 'TextArea'
    | 'Password'
    | 'Number'
    | 'Checkbox'
    | 'Hidden'
    | 'Select';
  submitOptions?: SubmitOption[];
}

const baseCSS = css`
  box-sizing: border-box;
  font-family: ${fontFamily};
  font-size: ${fontSize};
  margin-bottom: 5px;
  padding: 8px 10px;
  border: 1px solid ${gray5};
  border-radius: 3px;
  color: ${gray2};
  background-color: white;
  width: 100%;
  :focus {
    outline-color: ${gray5};
  }
  :disabled {
    background-color: ${gray6};
  }
`;

export const Field: FC<Props> = ({
  name,
  label,
  type = 'Text',
  submitOptions: selectOptions,
}) => {
  const { setValue, touched, setTouched, validate } = useContext(FormContext);

  const handleChange = (
    e: ChangeEvent<HTMLInputElement> | ChangeEvent<HTMLTextAreaElement>,
  ) => {
    if (setValue) {
      setValue(name, e.currentTarget.value);
    }
    if (touched[name]) {
      if (validate) {
        validate(name);
      }
    }
  };

  const handleCheck = (e: ChangeEvent<HTMLInputElement>) => {
    if (setValue) {
      setValue(name, e.currentTarget.checked);
    }
    if (touched[name]) {
      if (validate) {
        validate(name);
      }
    }
  };

  const handleSelectChange = (
    value: SubmitOption | null,
    actionMeta: ActionMeta<SubmitOption>,
  ) => {
    if (value) {
      if (setValue) {
        setValue(name, value.value);
      }
      if (validate) {
        validate(name);
      }
    }
  };

  const handleBlur = () => {
    if (setTouched) {
      setTouched(name);
    }
    if (validate) {
      validate(name);
    }
  };

  return (
    <FormContext.Consumer>
      {({ values, errors }) => (
        <div
          css={css`
            display: flex;
            flex-direction: column;
            align-self: center;
          `}
        >
          {label && (
            <label
              css={css`
                font-weight: bold;
              `}
              htmlFor={name}
            >
              {label}
            </label>
          )}
          {(type === 'Text' || type === 'Password' || type === 'Number') && (
            <input
              type={type.toLowerCase()}
              id={name}
              value={values[name] === undefined ? '' : values[name]}
              onChange={handleChange}
              onBlur={handleBlur}
              css={baseCSS}
            />
          )}
          {type === 'TextArea' && (
            <textarea
              id={name}
              value={values[name] === undefined ? '' : values[name]}
              onChange={handleChange}
              onBlur={handleBlur}
              css={css`
                ${baseCSS};
                height: 100px;
              `}
            />
          )}
          {type === 'Checkbox' && (
            <input
              id={name}
              checked={values[name] === undefined ? '' : values[name]}
              type="checkbox"
              onChange={handleCheck}
              onBlur={handleBlur}
              css={baseCSS}
            />
          )}
          {type === 'Hidden' && (
            <input
              id={name}
              value={values[name] === undefined ? '' : values[name]}
              type="hidden"
            />
          )}
          {type === 'Select' && (
            <Select options={selectOptions} onChange={handleSelectChange} />
          )}
          {errors[name] &&
            errors[name].length > 0 &&
            errors[name].map((error) => (
              <div
                key={error}
                css={css`
                  font-size: 12px;
                  color: red;
                `}
              >
                {error}
              </div>
            ))}
        </div>
      )}
    </FormContext.Consumer>
  );
};
