/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React from 'react';

export const LoadingText = () => {
  return (
    <div
      css={css`
        font-size: 16px;
        font-style: italic;
      `}
    >
      Loading...
    </div>
  );
};
