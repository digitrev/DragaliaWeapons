import { Button, ButtonGroup } from '@material-ui/core';
import { FC } from 'react';
import { ElementIcon, ElementString } from './ElementIcon';

export type FilterElement = ElementString | 'None';

export interface ElementSelectProps {
  elementFilter: { [key in FilterElement]: boolean };
  toggleElement: (element: FilterElement) => void;
  selectNone: () => void;
  selectAll: () => void;
}

export const ElementSelect: FC<ElementSelectProps> = ({
  elementFilter,
  toggleElement,
  selectNone,
  selectAll,
}) => {
  const elements: ElementString[] = [
    'Flame',
    'Wind',
    'Water',
    'Light',
    'Shadow',
  ];
  return (
    <ButtonGroup>
      {elements.map((element) => {
        return (
          <Button
            onClick={() => toggleElement(element)}
            color={elementFilter[element] ? 'primary' : 'default'}
            variant={elementFilter[element] ? 'contained' : undefined}
          >
            <ElementIcon element={element} />
          </Button>
        );
      })}
      <Button
        onClick={() => toggleElement('None')}
        color={elementFilter['None'] ? 'primary' : 'default'}
        variant={elementFilter['None'] ? 'contained' : undefined}
      >
        {'No Element'}
      </Button>{' '}
      <Button onClick={selectAll}>Select All</Button>
      <Button onClick={selectNone}>Select None</Button>
    </ButtonGroup>
  );
};
