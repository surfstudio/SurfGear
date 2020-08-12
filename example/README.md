# mwwm_github_client

An example of mwwm architecture.

Github client with search and add to favorites

### How to run?

[Create oauth app in your github account](https://developer.github.com/apps/building-oauth-apps/creating-an-oauth-app/)
with:  
Authorization callback URL - **my.app://oauth2redirect**

Then replace **your-client-id** and **your-client-secret** in 
```
const clientId = 'your-client-id';
const clientSecret = 'your-client-secret';
```
