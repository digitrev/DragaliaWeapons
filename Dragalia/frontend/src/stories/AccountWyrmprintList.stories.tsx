/** @jsxImportSource @emotion/react */
import React from 'react';
import { AccountWyrmprintList } from '../pages/Wyrmprints/AccountWyrmprintList';
import { AccountWyrmprintData, WyrmprintLimit } from '../api/DataInterfaces';

const wyrmprintData = [
  {
    wyrmprintId: 1,
    wyrmprintLevel: 23,
    wyrmprintLevelWanted: 30,
    unbind: 2,
    unbindWanted: 4,
    copies: 1,
    copiesWanted: 1,
    wyrmprint: {
      wyrmprintId: 1,
      wyrmprint: 'Plunder Pals',
      rarity: 5,
      affinity: 'None',
      abilities: ['ability one', 'ability two'],
    },
  },
  {
    wyrmprintId: 2,
    wyrmprintLevel: 23,
    wyrmprintLevelWanted: 30,
    unbind: 2,
    unbindWanted: 4,
    copies: 1,
    copiesWanted: 1,
    wyrmprint: {
      wyrmprintId: 2,
      wyrmprint: "A Dog's Day",
      rarity: 5,
      affinity: 'None',
      abilities: ['ability one', 'ability two'],
    },
  },
  {
    wyrmprintId: 3,
    wyrmprintLevel: 23,
    wyrmprintLevelWanted: 30,
    unbind: 2,
    unbindWanted: 4,
    copies: 1,
    copiesWanted: 1,
    wyrmprint: {
      wyrmprintId: 3,
      wyrmprint: 'Jewels of the Sun',
      rarity: 5,
      affinity: 'None',
      abilities: ['ability one', 'ability two'],
    },
  },
] as AccountWyrmprintData[];

const AccountWyrmprintListStories = {
  title: 'Account Wyrmprint List',
  component: AccountWyrmprintList,
  parameters: {},
};
export default AccountWyrmprintListStories;
const Template = (args: any) => (
  <AccountWyrmprintList data={wyrmprintData} limits={[] as WyrmprintLimit[]} />
);
export const Primary = Template.bind({});
