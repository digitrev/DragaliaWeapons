import React, {
  createContext,
  FC,
  useContext,
  useEffect,
  useState,
} from 'react';
import createAuth0Client, { Auth0Client, User } from '@auth0/auth0-spa-js';
import { authSettings } from '../../AppSettings';
import { PrivateApi } from '../../api/PrivateData';

interface Auth0User extends User {
  name: string;
  email: string;
}

interface IAuth0Context {
  isAuthenticated: boolean;
  user?: Auth0User;
  signIn: () => void;
  signOut: () => void;
  loading: boolean;
  getAccessToken: () => any;
}

export const Auth0Context = createContext<IAuth0Context>({
  isAuthenticated: false,
  signIn: () => {},
  signOut: () => {},
  loading: true,
  getAccessToken: () => {},
});

export const useAuth = () => useContext(Auth0Context);

export const AuthProvider: FC = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);
  const [user, setUser] = useState<Auth0User | undefined>(undefined);
  const [auth0Client, setAuth0Client] = useState<Auth0Client>();
  const [loading, setLoading] = useState<boolean>(true);

  const getAuth0ClientFromState = () => {
    if (auth0Client === undefined) {
      throw new Error('Auth0 client not set');
    }
    return auth0Client;
  };

  useEffect(() => {
    const initAuth0 = async () => {
      setLoading(true);
      const auth0FromHook = await createAuth0Client(authSettings);
      setAuth0Client(auth0FromHook);

      if (
        window.location.pathname === '/signin-callback' &&
        window.location.search.indexOf('code=') > -1
      ) {
        await auth0FromHook.handleRedirectCallback();
        const token = await auth0FromHook.getTokenSilently();
        const api = new PrivateApi(token);
        await api.putAccount();
        window.location.replace(window.location.origin);
      }

      const isAuthenticatedFromHook = await auth0FromHook.isAuthenticated();
      if (isAuthenticatedFromHook) {
        const user = await auth0FromHook.getUser<Auth0User>();
        setUser(user);
      }
      setIsAuthenticated(isAuthenticatedFromHook);
      setLoading(false);
    };
    initAuth0();
  }, []);

  return (
    <Auth0Context.Provider
      value={{
        isAuthenticated,
        user,
        signIn: () => getAuth0ClientFromState().loginWithRedirect(),
        signOut: () =>
          getAuth0ClientFromState().logout({
            client_id: authSettings.client_id,
            returnTo: window.location.origin + '/signout-callback',
          }),
        loading,
        getAccessToken: () => getAuth0ClientFromState().getTokenSilently(),
      }}
    >
      {children}
    </Auth0Context.Provider>
  );
};

// export const getAccessToken = async () => {
//   const auth0FromHook = await createAuth0Client(authSettings);
//   const accessToken = await auth0FromHook.getTokenSilently();
//   return accessToken;
// };
