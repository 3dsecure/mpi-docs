---
title: 3DSecure.io MPI API Documentation
---

# Getting Started

You need an API key to interact with our API. Sign-up <a href="http://www.3dsecure.io/">here</a>.

<p class="alert alert-danger">
The API key is what you pay for so keep it secret.
</p>

## API endpoint

````
https://mpi.3dsecure.io      # live accounts
https://mpi.test.3dsecure.io # test accounts
````


## Authentication

Authentication is done via HTTP Basic Auth. Simply provide your API key as
the username and a blank string as password. When using cURL, have just a `:`
after the username to specify an empty password.

````shell
curl -i https://mpi.3dsecure.io \
     -u <your-api-key>:
````

You will get this response when you provide an invalid API key:

````http
HTTP/1.1 401 Not Authorized
````

## Response format
Responses are in JSON format.

HTTP response codes are used to indicate API response status:

````
Number  Text
200     OK
400     Bad Request
401     Unauthorized
500     Internal Server Error
````


# Examples

## Get enrollment status

This method is used to verify if a given card is enrolled for 3-D Secure
authentication. The important responses from this method are a PAReq (Payment
Authentication Request) and URL, which is passed onto the ACS (Access Control
Server) of the issuing bank (or other ACS provider) via the cardholders browser.

The following will check 3-D Secure for a given card:

````shell
curl -X POST https://mpi.3dsecure.io/enrolled \
     -u <your-api-key>: \
     -d "amount=2050"   \
     -d "currency=EUR"  \
     -d "order_id=1234567890" \
     -d "card[number]=4111111111111111" \
     -d "card[expire_month]=12" \
     -d "card[expire_year]=2020" \
     -d "merchant[id]=123456789012345" \
     -d "merchant[name]=Best Merchant Inc" \
     -d "merchant[acquirer_bin]=411111" \
     -d "merchant[country]=DK" \
     -d "merchant[url]=http://www.bestmerchantinc.com/" \
     -d "cardholder_ip=8.8.8.8"
````

Example response (snippet):

````json
{
    "acs_url":"https://secure5.arcot.com/acspage/cap?RID=35325&VAA=B",
    "pareq_value":"eNpdU8tymzAU3ecrvMumYz1AgD2yZnDsTpMZx06TRdudLK5skhiIgNjust/Tr+qXVMIm4DDDoHvuOdKZexB/2hqA2SOo2oC4Ggz4AspSbmCQJpPrSELAZKApSOyFkWYaY+brJAq0pzTQa6ewmlX8Hd4aRZDoKMIs8WXiK2/NvIAFDPwwoRrCkV6fFVbzDqZM80yQIR5SjtqybRcyE4xFPmUhoZiGhPkRRw5tGQswaiuzqgUsJNXb9PZeMBpYFUfnsuvvwNzOBKa4fTg6QR0lkzsQ84PcFa/AUVN1TZXXWWWOgmLrpS26dm1exbaqijFC+/1+CKddhrnZII5cs7WOPnvnq9oBZf+wQ5qIxSzed+/8uPj9QO6flb98iiccOUbHT2QF1hlhmODRgARj6o0Z46jBezPaOd/i35+/hH7x7ATOQMconJf4hBLqKH2kN43aGMjUUYxCN4626ghwKPIMrMbm+7HuGYZSCevPfT4m83kQ/ObbRcCqsnHls7V++fVAHoPlnb/9eVMuVz+m8fzrNN5MXOwN6cJHaoMiETkZSbvUOGr3t0e7v7i5A+h8CcQVR5cX5D/FxN2u",
    "account_id":"oDbfkZQ1S6OJ4hYCsOPXBAEFBAg=",
    "enrolled":"Y",
    "eci":"2",
    "error":null
}
````

## Check PARes

This method is used to validate the PARes response from the ACS.

````shell
curl -X POST https://mpi.3dsecure.io/check \
     -u <your-api-key>: \
     --data-urlencode "pares=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"
````

Example response (snippet):

````json
{
    "amount":"21601",
    "currency":"DKK",
    "cavv":"jI3JBkkaQ1p8CBAAABy0CHUAAAA=",
    "cavv_algorithm":"3",
    "eci":"2",
    "merchant_id":"02000000000",
    "last4":"1548",
    "status":"Y",
    "valid":true,
    "xid":"MDAwMDAwMDAwMDEyMzQ2Njc4OTA="
}
````

# API Reference

### Enrolled

This method is used to verify if a given card is enrolled for 3-D Secure authentication. The important responses from this method are a PAReq (Payment Authentication Request) and url, which is parsed onto the ACS (Access Control Server) of the issuing bank (or other ACS provider) via the user's browser.

````
POST https://mpi.3dsecure.io/enrolled
````

#### Parameters

<dl class="dl-horizontal">
  <dt>amount</dt>
  <dd>[0-9]{1,11} <br /> Amount in minor units of given currency (e.g. cents if in Euro).</dd>
  <dt>currency</dt>
  <dd>[A-Z]{3} <br /> ISO 4217 3-letter currency code.</dd>
  <dt>order_id</dt>
  <dd>[:print:]{1,125} <br /> Order ID or other unique transaction identifier</dd>
  <dt>cardholder_ip</dt>
  <dd>[0-9\.a-fA-F:]{3,39} <br /> Cardholder's IP address (v4 or v6).</dd>
  <dt>card[number]</dt>
  <dd>[0-9]{12,19} <br /> Primary account number of card to charge.</dd>
  <dt>card[expire_month]</dt>
  <dd>[0-9]{2} <br /> Expiry month of card to charge.</dd>
  <dt>card[expire_year]</dt>
  <dd>[0-9]{4} <br /> Expiry year of card to charge.</dd>
  <dt>merchant[acquirer_bin]</dt>
  <dd>[0-9]{6,11} <br /> Acquiring institution identification code. <br /> Typically this is a 6-digit BIN assigned to the acquirer by Visa or MasterCard.</dt>
  <dt>merchant[country]</dt>
  <dd>[A-Z]{2} <br /> ISO 3166-1 2-letter country code</dd>
  <dt>merchant[id]</dt>
  <dd>[[:alnum:]]{1,15}(-[[:alnum:]]{1,8}|) <br /> Merchant account ID or Card Acceptor ID provided by the acquiring bank. <br /><code>The Merchant ID must be the value registered to Visa and MasterCard</code>
  <dt>merchant[name]</dt>
  <dd>[:print:]{1,25} <br /> Text that will be shown to the cardholder during authentication at the ACS.</dd>
  <dt>merchant[url]</dt>
  <dd>[:valid_url:] <br /> Valid URL, E.g. http://www.example.org/</dd>
</dl>

<p class="alert alert-info">
<b>Notice:</b> Getting the correct Acquirer BIN number and the Merchant ID from the acquiring bank is always a hassle the first time.
</p>


### Check

This method is used to validate the PARes response from the ACS.

````
POST https://mpi.3dsecure.io/check
````

#### Parameters

<dl class="dl-horizontal">
  <dt>pares</dt>
  <dd>[:base64:]  <br /> Base64 encoded PARes</dd>
</dl>

<p class="alert alert-info">
<b>Notice:</b> The ```pares``` should be url-encoded to garantee that valid base64 reaches the endpoint. For curl use ```--data-urlencode```.
</p>

## Response status codes

### Electronic Commerce Indicator (ECI) Values

| ECI Visa | ECI MC | Status |
|:--------|:--------|---------|
| 5 | 2 | Authentication Successful |
| 6 | 1 | Attempts Processing Performed |
| 7 | 0 | Authentication Failed |
| 7 | 1 | Authentication Could Not Be Performed |
| 7 | 0 | Error |

## Test card numbers

Not available yet.

[3-D_Secure]: http://en.wikipedia.org/wiki/3-D_Secure
[Tokenization]: http://en.wikipedia.org/wiki/Tokenization_(data_security)
