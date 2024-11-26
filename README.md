# Sample User Attributes application

Simple SAP CAP NodeJs application to demonstrate authentication on SAP BTP.
This application is only available after logging in, and will show the details of the user coming from the security framework.

### Installation

Change `/xs-security.json` with the relevant user attributes

```
npm install
mbt build
cf deploy ./mta_archives/userAttributes_1.0.0.mtar
```

Create a role and map the user attributes to the Corporate IdP attributes, and assign the role to your user.

### Run locally

- Run `cds bind -2 userAttributes-auth`
- Copy the service key into /app/default-env.json
- Start server via `cds watch --profile hybrid`
- Start approuter via `cds app && npm start`
- Open your browser to localhost:5000