---
title: 3DSecure.io MPI API Documentation
---

# Getting Started

You need an API key to interact with our API. Sign-up <a href="http://www.3dsecure.io/">here</a>.

<p class="alert alert-danger">
API keys comes with many privileges so keep them secret.
</p>

## API endpoint

````
https://mpi.3dsecure.io      # live accounts
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
authentication. The important responses from this method is a PAReq (Payment
Authentication Request) and url, which is parsed onto the ACS (Access Control
Server) of the issuing bank (or other ACS provider) via the user's browser.

The following will check 3-D Secure for a given card:

````shell
curl -X POST https://mpi.3dsecure.io/enrolled \
     -u <your-api-key>: \
     -d "amount=2050"   \
     -d "currency=EUR"  \
     -d "order_id=1234567890" \
     -d "card[number]=4111111111111111" \
     -d "card[month]=12" \
     -d "card[year]=2020" \
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
    "term_url":"https://secure5.arcot.com/acspage/cap?RID=35325&VAA=B",
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
     -F "pares=eJzFV2uTqkgS/SsdPR+NOzzkIRO0E8UblTcI+A0RAQVBeRT66xf1dt+eO70bd3djYys0rDqRmZVZebLMYv8cyuKlTy5NXp3eXrHf0deX5BRXu/yUvr16rvRt9vrnnHWzS5IIThJ3l2TOaknTRGnyku/eXimcorczBqdijNhh0ygi8R22pfAtSe23REK9zlkT2EnzEMZoBkWJKY6O6Pc95+OWv+Ms8r4cjV/iLDq1czaKz5yqz5nHYJHvS7ZMLqowHx1MmgxDiVH3ibDID1Wzu8+a0dch3801AcAfX/Gq3SxMP8SE4YI3FrlLsLuoTeY4ihEYhk5fUOqP8UMSLPLA2fpuDpRVN9oeBTAW+Yyw46lcxkO7zhl6xiIfKzYZ6uqUjBKjjx9zFvnhXB2d5uingY1jtD2irBvM2TYv/+4UzSIPnG3aqO2aOWCR7zM2jvp+zgPAc3XuF0PKWTCD8iYKwHOMwT5E2CTO5yg1OjX+PrRAkVaXvM3Ku6t/BVjk7grySOKcdfL0NG52SV5G3pyat9esbes/EARC+Duc/l5dUgQfA0FQBhkFdk2e/vb61Ep26mlf/VtqfHSqTnkcFfktakdyaEmbVbuXD9++MuPad0sYYov8t9HUt5GWp293BJ1i5GgT+drop8h+ZZefnb000bcmi7D7Bj8ZmrN2sk/ujEhePFt9e/3tcxUIeZo07X+y5ft2ny2821tHRZfM+6RYJ3iiX4pgr0JZlYRcKfWcGjLv7V3vKckiHz5+D+CZrU+n8hS86Up5cgOBBCtL7HedSubuRdtcGCfZEv6KuGS3JuWK7ChoZ4poYoRzzsRscgwNkulrzZ1a6IJcXmdTaq1As1AtTSgcemHsz1ax3VNJMLhFbDEp3NuIc1qUe12yon1N787BTBHzpNxE6k2TjHR/bBG3AcvQLjtiy6UpSc6UMKOmy7Sr0rKN07dPmfge5TK5PqMKSJQRojZ6zvjk0ub7kRJjqWuqylsHngdRw/MWn2lRMMtu+yB1gc6lx3N2zGUGohywPAkIYKJZDeStUFhblizCxdq7iZYGCBlgnjhqKxYuXUPfzuKbqGmgeuKDJnhi4WnWDApPXUGEGxgFVhviIlSyWNdcC2o3gI+S0HDVwX9gxzuGfWAHnjsI4koDx4ddLtP49VobRBeYXKqvOZC6vKj3W5m5+9Brdgql9LGfIkJGjfxdtZWlbqNoqVdKXYing+CC1VO3cjlps/BQcVjdQPvEGndRbOoYF1PHJ9FNsOjCwK63OJltec4d13jk64UqSrcYZw6RL6GRz3SaDaCQvse5G/V0NJYLVFPlvQZQmXfOsqNup4Il3s8VjMenA4HncmvJpZbQXKleCfN+j1snMlomS29laKQySRlDTRRDFOs2jYecCAYFIZqpAVskDwXTdAapJ8GlvE2wiTReg1w+cTN7GW/WcLJrFGramWvDOyqCfCK2iYkrkd1eru40oM8nzc0OgZLuT+vEO6s1NtvYppuH+io89FPk3Do70rHOlBUMsURHqXkseNx1LFUAFuB+jol7xsQBTVFWt7rgTLWw+EqvNjjdCpt2xsm+HEbbpXkVRRnwgUmSAdZN9VkhYj1dSrRbojppmSk2hdcjE265ykBKhHf3Rmj1ykJmYgrBUBKfBHLrTRedXuT1lshcSScE6khtmJVXOghirZEWnYaDKXG0M235rgvko6eiJbrYH4t97Xlbo4WwLLOWRX6ujC9L5XQbSyXNUwDVkW3qAuhZLCNjWmDLfHUMmggG/gYWTzqFLijW7id6LEd6CGGwyDaydNMsCPknvhKhbjlr6xO1NZdXuHrHY9ctzqAaRwSCK6KaoEH9AFBdCG86Vo2Y+sDGsnnHoHn4omQEYHzQHh2DKKVjGGiDIIDlO/UBxi3Wgmje47rrgkGT7zRe+Xr2i1R2ZvDYSZ5EHKMoj5zVxCapdXS8Yd1484fSGRGrYHFbORAFbeTPsETp+OyazOggFWQz6IDIV9uljdUVfSjLntax8lwVw27VtqAil+rFZxJDpybIZOoQrXrslpfzhFqv3OvgkG1JKyM2XSupEXXheQPgjh8c6ax20qHpDlkzCYKhh1xXkQ18Urki5PwRG/eIeSekls9xjpMYCKj7HaKGZpWBVMHUnejoNbIUOHg/L8XRxMjlTul4K+gMsfd0yz4RZ4NunEPQ1r6ys+k8ksRaVKH11RX26/mwNTB7z4f6yEew6LdTZ7y+BXLwmmmp9rV/A9rDL1sTOXe8uC0F+adlyrcBh/ZtgU4sz+sVuahm6ZmHh0MGhVUd4Wu7KaKuWcrtjPALMw9QV8G581Ait9K8cgf91AW+rJQWsUyl8hyhTiJhYG8i4RT4ibgA1KJKDuTsJKPZheJjYztc+AkEmm0KarFSjAmJWddDrUuMwk+OOLUdvKjeNPjaR/A6Nim6bC3lGuSh9YtlWrn3Mj3/KFPzJDm3JMwnxfb/WabazRs06a9l+h37H9HCgunm8a+7WFYbNetjHTxiBmNoKBipvhj/pDmwlOldHl0EK8Vo71D2i6hRJOfgZ+ZuyyBMHWx6Hyy7mIHn80GYnnqPgpNu0YaqdNaJPuAnhyOdHIm1RB/6oyBNbRTdn5SCgsa629+sQgL0xApq39XkZktdrzALNLjexsasw4hYXiPDhFwn8Oiml7W9PW8KI1DLpCj03sf2zYJUcme9V2bJtQCpxgEgH9JIfcSm3DsKGzU4LhQl/TidZoyFcfI+r+huWOoJXoQ7TOkWmgIeJa1Cu9bkBPwr2cpzjtZhzOZ/0+3YIhTgexeQPbqduGT6nfozH+HDLxFakjZWLdj/LV/SM18iUJPNpg2sc8EtUSLC07yUjxUSrfDQH5udDCWu7nJygLRxXCCevwNYSs+8xZFELu6CwUmaySvy0pQrJVhPOj+m/AulSgYB9kNu9RPZR8yxR6s7gqlmSc9c3T6MqmYWmMRt5xmE3QQcZC6h3TkmYfR4ayyXZlUai1W0dciRfQVfdUeaJpDBFd++KFXkRx+KfPSmP7rWx4v28dK+P8I+v8D/AbfgHYI="
````

Example response (snippet):

````json
{
    "currency" : "EUR",
    "cavv" : "CAACBpiWlxgBQwhwGZaXAAAAAAA=",
    "amount": "1101",
    "cavv_algorithm" : "2",
    "eci" : "6",
    "order_id" : "00000000001234567890",
    "valid": true,
    "xid" : "MDAwMDAwMDAwMDEyMzQ1Njc4OTA="
}
````

# API Reference

### Enrolled

This method is used to verify if a given card is enrolled for 3-D Secure authentication. The important responses from this method is a PAReq (Payment Authentication Request) and url, which is parsed onto the ACS (Access Control Server) of the issuing bank (or other ACS provider) via the user’s browser.

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
  <dd>[A-Z]{2} <br /> ISO 3166-1 2-letter country codes</dd>
  <dt>merchant[id]</dt>
  <dd>[A-Z0-9/-]{15,24} <br /> Merchant account ID or Card Acceptor ID provided by the acquiring bank. <br /><code>The Merchant ID must be the value registered to Visa and MasterCard</code>
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

Not available yet..

[JSON-HAL]: http://tools.ietf.org/html/draft-kelly-json-hal "IETF HAL draft"
[HATEOAS]: http://en.wikipedia.org/wiki/HATEOAS
[Tokenization]: http://en.wikipedia.org/wiki/Tokenization_(data_security)
