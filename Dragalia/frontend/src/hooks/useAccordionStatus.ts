import { useState, useCallback } from 'react';

const useAccordionStatus = (expandedState: { [key: number]: boolean }) => {
  const [accordionStatus, setAccordionStatus] = useState(
    {} as { [key: number]: boolean },
  );

  const expandAll = () => {
    setAccordionStatus((current) => {
      return {
        ...expandedState,
      };
    });
  };
  const collapseAll = () => {
    setAccordionStatus({});
  };

  const updateAccordion = useCallback((id: number, status: boolean) => {
    setAccordionStatus((current) => {
      return {
        ...current,
        [id]: status,
      };
    });
  }, []);

  return {
    accordionStatus,
    expandAll,
    collapseAll,
    updateAccordion,
  };
};

export default useAccordionStatus;
