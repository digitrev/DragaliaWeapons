/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React from 'react';
import { Link } from 'react-router-dom';
import { UserIcon } from '../img/Icons';
import { fontFamily, fontSize, gray1, gray2, gray5 } from '../Styles';
import { useAuth } from './Auth/Auth';

const buttonStyle = css`
  border: none;
  font-family: ${fontFamily};
  font-size: ${fontSize};
  padding: 5px 10px;
  background-color: transparent;
  color: ${gray2};
  text-decoration: none;
  cursor: pointer;
  span {
    margin-left: 10px;
  }
  :focus {
    outline-color: ${gray5};
  }
`;

export const Header = () => {
  const { isAuthenticated, user, loading } = useAuth();

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
      `}
    >
      <Link to="/about">About</Link>
      <Link
        to="/"
        css={css`
          font-size: 24px;
          font-weight: bold;
          color: ${gray1};
          text-decoration: none;
        `}
      >
        Home
      </Link>
      {!loading &&
        (isAuthenticated ? (
          <div>
            <span>{user!.name}</span>
            <Link
              to={{ pathname: '/signout', state: { local: true } }}
              css={buttonStyle}
            >
              <UserIcon />
              <span>Sign Out</span>
            </Link>
          </div>
        ) : (
          <Link to="./signin" css={buttonStyle}>
            <UserIcon />
            <span>Sign In</span>
          </Link>
        ))}
    </div>
  );
};
