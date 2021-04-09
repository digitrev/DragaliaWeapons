import React from 'react';
import Flame from '../img/element/Flame.png';
import Water from '../img/element/Water.png';
import Wind from '../img/element/Wind.png';
import Light from '../img/element/Light.png';
import Shadow from '../img/element/Shadow.png';

export type ElementString = 'Flame' | 'Wind' | 'Water' | 'Light' | 'Shadow';

export interface ElementIconProps {
  element: ElementString;
}

const map = {
  Flame: Flame,
  Wind: Wind,
  Water: Water,
  Light: Light,
  Shadow: Shadow,
};
export const ElementIcon: React.FC<ElementIconProps> = (props) => {
  return (
    <img
      src={map[props.element]}
      alt={props.element}
      height={17}
      style={{ marginBottom: '-3px' }}
    />
  );
};
