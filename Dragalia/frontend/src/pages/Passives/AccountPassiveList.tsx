/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC, useMemo } from 'react';
import {
  AccountPassiveData,
  AccountPassiveGroupData,
} from '../../api/DataInterfaces';
import { accent2, gray5, PrimaryButton } from '../../Styles';
import { AccountPassiveGroup } from './AccountPassiveGroup';
import useAccordionStatus from '../../hooks/useAccordionStatus';

interface Props {
  data: AccountPassiveData[];
}

export const AccountPassiveList: FC<Props> = ({ data }) => {
  const groups = data.reduce<AccountPassiveGroupData[]>((acc, cur) => {
    if (cur.passive !== undefined) {
      const ind = acc.findIndex(
        (x) =>
          x.element === cur.passive!.element &&
          x.weaponType === cur.passive!.weaponType,
      );
      if (ind >= 0) {
        acc[ind].passives.push(cur);
        if (cur.owned) {
          acc[ind].owned += 1;
        } else if (cur.wanted) {
          acc[ind].wanted += 1;
        }
      } else {
        acc.push({
          element: cur.passive.element,
          weaponType: cur.passive.weaponType,
          passives: [cur],
          owned: cur.owned ? 1 : 0,
          wanted: !cur.owned && cur.wanted ? 1 : 0,
        });
      }
    }
    return acc;
  }, []);

  const allExpanded = useMemo(
    () =>
      data.reduce((map, group, index) => {
        map[index] = true;
        return map;
      }, {} as { [key: number]: boolean }),
    [data],
  );

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
        {groups.map((group, index) => (
          <li
            key={`${group.element} ${group.weaponType}`}
            css={css`
              border-top: 1px solid ${gray5};
              ::first-of-type {
                border-top: none;
              }
            `}
          >
            <AccountPassiveGroup
              data={group}
              accordionStatus={accordionStatus}
              updateAccordion={updateAccordion}
              index={index}
            />
          </li>
        ))}
      </ul>
    </>
  );
};
