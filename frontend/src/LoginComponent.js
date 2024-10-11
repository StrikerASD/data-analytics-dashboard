import React from 'react';
import { GoogleOAuthProvider, GoogleLogin } from '@react-oauth/google';
import LoginButton from './LoginButton';
import LogoutButton from './LogoutButton';

const App = () => {
    const responseGoogle = (response) => {
        console.log(response);
        // Handle the response, send the token to your backend for validation
    };

    return (
        <GoogleOAuthProvider clientId="295291854751-ppkvgc8642rr5iiupoi0rk11n8481hd2.apps.googleusercontent.com">
            <div>
                <h2>My App</h2>
                <GoogleLogin
                    onSuccess={responseGoogle}
                    onFailure={responseGoogle}
                    cookiePolicy={'single_host_origin'}
                />
            </div>
        </GoogleOAuthProvider>
    );
};

export default App;
