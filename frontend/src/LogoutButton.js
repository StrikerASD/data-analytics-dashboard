import { GoogleLogout } from '@react-oauth/google';

const LogoutButton = () => {
  const handleLogout = () => {
    console.log('User logged out');
  };

  return (
    <GoogleLogout
      onLogoutSuccess={handleLogout}
    />
  );
};
