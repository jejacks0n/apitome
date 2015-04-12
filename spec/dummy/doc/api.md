API Documentation
=================

### Current Version

  1. `/api/v1/*`
  2. `/api/edge/*` (forthcoming version)

### Introduction

This API adheres to the [json:api specification](http://jsonapi.org). To be explicit you can provide the `Accept` header
as `application/vnd.api+json`, but this is the default behavior.

Each endpoint response is validated against a JSON schema, and the documentation for each scenario contains a link to
the schema used in the validation layer. These schemas sometimes include a `$ref` node to an additional schema, and in
these cases you can modify the url to load the desired JSON schema.

#### Authentication

A **Client ID** and **Secret Key** will be issued for your specific client application which can then be used to
retrieve an OAuth token. These are considered your **client credentials**.

Before any API request can be fulfilled, a valid OAuth access token must be requested and provided back on subsequent
API requests. The token must be provided in the `Authorization` header as `Bearer [access_token]`, or as an
`access_token` param. The header technique is strongly recommended but may not always work, for instance on event
streams.

If no token or an invalid/expired token is provided to any API endpoint, a 401 status code will be returned with
additional messaging, at which point a new token may be requested.

There are two token types. A [client access token](#access-tokens-client-access-token-client-credentials-) (a
`client_credential` grant), and a [user access token](#access-tokens-user-access-token-password-) (a `password` grant).
All requests require a token, most requiring a user access token, and a few that only require a client access token, you
may need to use both token types under different circumstances.

### Request Headers

The `Accept-Language` header should be provided on all requests to enable localization of messaging. The value will
default to `en-US,en` if left unspecified.
