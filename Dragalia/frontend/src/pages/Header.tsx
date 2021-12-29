/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { Link } from 'react-router-dom';
import { gray1, gray5 } from '../Styles';

export const Header = () => {
  return (
    <div
      css={css`
        position: fixed;
        box-sizing: border-box;
        top: 0;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 20px;
        background-color: #fff;
        border-bottom: 1px solid ${gray5};
        box-shadow: 9 3px 7px 0 rgba(110, 112, 114, 0.21);
        z-index: 99;
      `}
    >
      <Link to="/DragaliaWeapons?page=about">About</Link>
      <Link
        to="/DragaliaWeapons"
        css={css`
          font-size: 24px;
          font-weight: bold;
          color: ${gray1};
          text-decoration: none;
        `}
      >
        Home
      </Link>
      <Link to="/DragaliaWeapons?page=settings">Save/Load</Link>
    </div>
  );
};
