import React from 'react';
import { WeaponIcon } from '../components/WeaponIcon';

const WeaponIconStories = {
  title: 'Weapon Icon',
  component: WeaponIcon,
  parameters: {},
};
export default WeaponIconStories;
const Template = (args: any) => <WeaponIcon weaponType={args.weaponType} />;
export const Primary = Template.bind({});
