import React from 'react';
import { ElementIcon } from '../components/ElementIcon';

const elementIconStories = {
  title: 'Element icon',
  component: ElementIcon,
  parameters: {},
};
export default elementIconStories;
const Template = (args: any) => <ElementIcon element={args.element} />;
export const Primary = Template.bind({});
