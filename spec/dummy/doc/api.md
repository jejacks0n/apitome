## API Documentation

### Request Headers

The [`Accept-Language`](http://www.w3.org/International/questions/qa-accept-lang-locales) header should be provided in all requests so localization of messaging can be applied and/or different translations for records can be returned. The value will default to `en-US,en` if unspecified.

The `X-Unit-Type` header should be provided in all requests so units of measurements (temperature, etc) can be provided back to the client in the correct format or processed/converted before storing. The value can be either `imperial`, or `metric`. This could be provided to the user as a setting, and if omitted will be inferred using the `Accept-Language` header or 'en-US,en'. Imperial/Fahrenheit will be used for country codes matching "US", "LR" (Liberia), or "MM" (Myanmar/Burma), otherwise Metric/Celsius is assumed.

### Response Codes

#### 401 Unauthorized

The server responds with a 401 if the client isn't providing the correct client id/secret or if the user doesn't have access to the given resource being requested.

```json
{
  "error": "unauthenticated",
  "error_description": "This action requires authentication to continue."
}
```
