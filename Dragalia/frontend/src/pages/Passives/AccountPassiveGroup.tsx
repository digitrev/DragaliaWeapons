/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { AccountPassiveGroupData } from '../../api/DataInterfaces';
import { gray5 } from '../../Styles';
import { AccountPassive } from './AccountPassive';
import Accordion from '@material-ui/core/Accordion';
import AccordionSummary from '@material-ui/core/AccordionSummary';
import AccordionDetails from '@material-ui/core/AccordionDetails';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import { ElementIcon, ElementString } from '../../components/ElementIcon';
import { WeaponIcon, WeaponString } from '../../components/WeaponIcon';

interface Props {
  data: AccountPassiveGroupData;
  accordionStatus?: { [key: number]: boolean };
  updateAccordion?: (id: number, status: boolean) => void;
  index: number;
}

export const AccountPassiveGroup: FC<Props> = ({
  data: { element, weaponType, passives, owned, wanted },
  updateAccordion,
  accordionStatus,
  index,
}) => {
  return (
    <div
      css={css`
        padding: 10px 0px;
      `}
    >
      <Accordion
        expanded={(accordionStatus && accordionStatus[index]) || false}
        onChange={(event, expanded) =>
          updateAccordion && updateAccordion(index, expanded)
        }
      >
        <AccordionSummary expandIcon={<ExpandMoreIcon />}>
          <div
            css={css`
              padding: 10px 0px;
              font-size: 19px;
            `}
          >
            {element} {weaponType}{' '}
            {element !== 'None' && (
              <ElementIcon element={element as ElementString} />
            )}{' '}
            {weaponType && (
              <WeaponIcon weaponType={weaponType as WeaponString} />
            )}
          </div>
          <div
            css={css`
              margin: auto 25px auto auto;
            `}
          >
            Owned: {owned}, Wanted: {wanted}
          </div>
        </AccordionSummary>
        <AccordionDetails
          css={css`
            flex-direction: column;
          `}
        >
          {accordionStatus && accordionStatus[index] && (
            <ul
              css={css`
                list-style: none;
                margin: 10px 0 0 0;
                padding: 0px 20px;
                background-color: #fff;
                border-bottom-left-radius: 4px;
                border-bottom-right-radius: 4px;
                box-shadow: 0 3px 5px 0 rgba(0, 0, 0, 0.16);
              `}
            >
              {passives.map((passive) => (
                <li
                  key={passive.passiveId}
                  css={css`
                    border-top: 1px solid ${gray5};
                    ::first-of-type {
                      border-top: none;
                    }
                  `}
                >
                  <AccountPassive data={passive} />
                </li>
              ))}
            </ul>
          )}
        </AccordionDetails>
      </Accordion>
    </div>
  );
};
