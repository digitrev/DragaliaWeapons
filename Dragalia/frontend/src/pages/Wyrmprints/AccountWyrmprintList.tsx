/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { AccountWyrmprintData, WyrmprintLimit } from '../../api/DataInterfaces';
import { accent2, gray5, PrimaryButton } from '../../Styles';
import { AccountWyrmprint } from './AccountWyrmprint';
import useAccordionStatus from '../../hooks/useAccordionStatus';

interface Props {
  data: AccountWyrmprintData[];
  limits: WyrmprintLimit[];
}

export const AccountWyrmprintList: FC<Props> = ({ data, limits }) => {
  const findLimit = (rarity: number | undefined) => {
    let limit = limits.find((l) => l.rarity === rarity);
    if (limit === undefined) {
      limit = {
        rarity: rarity || 0,
        level: 0,
      };
    }
    return limit;
  };

  const allExpanded = data.reduce((map, wyrmprint) => {
    map[wyrmprint.wyrmprintId] = true;
    return map;
  }, {} as { [key: number]: boolean });
  const {
    expandAll,
    collapseAll,
    accordionStatus,
    updateAccordion,
  } = useAccordionStatus(allExpanded);
  return (
    <>
      <PrimaryButton
        onClick={expandAll}
        css={css`
          margin-right: 10px;
        `}
      >
        Expand All
      </PrimaryButton>
      <PrimaryButton onClick={collapseAll}>Collapse All</PrimaryButton>
      <ul
        css={css`
          list-style: none;
          margin: 10px 0 0 0;
          padding: 0px 20px;
          background-color: #fff;
          border-bottom-left-radius: 4px;
          border-bottom-right-radius: 4px;
          border-top: 3px solid ${accent2};
          box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
        `}
      >
        {data.map((wyrmprint) => (
          <li
            key={wyrmprint.wyrmprintId}
            css={css`
              border-top: 1px solid ${gray5};
              ::first-of-type {
                border-top: none;
              }
            `}
          >
            <AccountWyrmprint
              data={wyrmprint}
              limits={findLimit(wyrmprint.wyrmprint?.rarity)}
              accordionStatus={accordionStatus}
              updateAccordion={updateAccordion}
            />
          </li>
        ))}
      </ul>
    </>
  );
};
