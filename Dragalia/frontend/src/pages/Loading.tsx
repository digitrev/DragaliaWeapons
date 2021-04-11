/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';

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
