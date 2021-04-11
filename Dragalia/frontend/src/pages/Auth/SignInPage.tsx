import { FC } from 'react';
import { StatusText } from '../../Styles';
import { Page } from '../Page';
import { useAuth } from './Auth';

type SignInAction = 'signin' | 'signin-callback';

interface Props {
  action: SignInAction;
}

export const SignInPage: FC<Props> = ({ action }) => {
  const { signIn } = useAuth();

  if (action === 'signin') {
    signIn();
  }

  return (
    <Page title="Sign In">
      <StatusText>Signing in ...</StatusText>
    </Page>
  );
};
