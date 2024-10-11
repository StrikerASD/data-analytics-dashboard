// LoginButton.js
import React from 'react';
import { GoogleLogin } from '@react-oauth/google';

const LoginButton = () => {
  const handleLogin = (credentialResponse) => {
    console.log(credentialResponse); // You can handle the response here
  };

  return (
    <GoogleLogin
      onSuccess={handleLogin}
      onFailure={(error) => console.error('Login Failed:', error)}
    />
  );
};

export default LoginButton;
