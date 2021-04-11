import React from 'react';
import { Weapon } from '../pages/Weapons/Weapon';

const weaponStories = {
  title: 'Weapon',
  component: Weapon,
  parameters: {},
  argTypes: {
    weapon: { control: { type: 'text' }, defaultValue: 'Durandal' },
    weaponSeries: { control: { type: 'text' }, defaultValue: 'Agito' },
    rarity: { control: { type: 'number' }, defaultValue: 6 },
    element: {
      options: ['Flame', 'Wind', 'Water', 'Light', 'Shadow', 'None'],
      control: { type: 'select' },
      defaultValue: 'Wind',
    },
    weaponType: {
      options: [
        'Axe',
        'Blade',
        'Bow',
        'Dagger',
        'Lance',
        'Manacaster',
        'Sword',
        'Staff',
        'Wand',
      ],
      control: { type: 'select' },
      defaultValue: 'Sword',
    },
  },
};
export default weaponStories;
const Template = (args: {
  weapon: string;
  weaponSeries: string;
  weaponId: number;
  weaponType: string;
  rarity: number;
  element: string;
}) => <Weapon data={{ ...args }} />;
export const Primary = Template.bind({});
