import { useState, useCallback } from 'react';
import { FilterElement } from '../components/ElementSelect';

const useElementFilter = () => {
  const allSelected = {
    Flame: true,
    Water: true,
    Wind: true,
    Light: true,
    Shadow: true,
    None: true,
  } as { [key in FilterElement]: boolean };
  const [elementFilter, setElementFilter] = useState(allSelected);

  const selectNone = () => {
    setElementFilter({} as { [key in FilterElement]: boolean });
  };

  const selectAll = () => {
    setElementFilter(allSelected);
  };

  const toggleElement = useCallback((element: FilterElement) => {
    setElementFilter((current) => {
      return {
        ...current,
        [element]: !current[element],
      };
    });
  }, []);

  return {
    elementFilter,
    toggleElement,
    selectNone,
    selectAll,
  };
};

export default useElementFilter;
