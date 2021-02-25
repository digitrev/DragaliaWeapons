import React from 'react';
import { Page } from './Page';
import Select, { ActionMeta } from 'react-select';

interface Flavour {
  value: string;
  label: string;
}

export const Example = () => {
  const options: Flavour[] = [
    { value: 'chocolate', label: 'Chocolate' },
    { value: 'strawberry', label: 'Strawberry' },
    { value: 'vanilla', label: 'Vanilla' },
  ];

  const handleChange = (val: Flavour | null, meta: ActionMeta<Flavour>) => {
    console.log(val);
  };

  return (
    <Page title="Example">
      <Select options={options} onChange={handleChange} />
    </Page>
  );
};
