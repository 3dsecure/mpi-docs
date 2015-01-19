---
title: Clearhaus transaction API integration tests
---

# Introduction

Here you will find a list of tests and expected responses that could be helpful
when you write an integration of the [transaction
API](http://docs.gateway.clearhaus.com).

You should hit

````
https://gateway.test.clearhaus.com
````

when running these tests. You may send as many tests as you like; there is no
requirement that the tests happen sequentially.

# Tests

Generally, when values are not listed, you may choose any "realistic" value;
e.g. the card expire date should not be in the past. Notice that you may use any
card number (that passes LUHN-10) for the test gateway.

For Clearhaus to verify your integration and help digging out details, you can
send us a CSV file structured as:

| `test_case_id`                         | `transaction_id`                       |
|----------------------------------------|----------------------------------------|
| `51a973f8-2d4b-4343-a075-d3d5c35e2dcf` | `22cdf576-40a1-4c81-b222-8bfbf6045751` |
| `64e1bb11-e268-43dd-8da6-038ea4559f97` | `41223987-81db-4d67-84ae-d04bae13941b` |
| ...                                    | ...                                    |

(Notice that a `test_case_id` may be present multiple times.)

Then we will check that it looks good on our end.


## Simple tests

### Authorization

Test case ID: `51a973f8-2d4b-4343-a075-d3d5c35e2dcf`

1. Create an authorization.

Repeat for your relevant currencies.

### Void

Test case ID: `64e1bb11-e268-43dd-8da6-038ea4559f97`

1. Create an authorization.
2. Void the transaction.

Repeat with a `text_on_statement`.

### Full capture

Test case ID: `090a2366-82fd-4aa9-9b1f-2a6dd780a79c`

1. Create an authorization.
2. Create a capture that captures the full amount.

Repeat with a default `text_on_statement` on the authorization that is
overwritten in the capture.

### Full refund

Test case ID: `d0eb2bf3-ca1b-4b2f-bacb-b7735588685a`

1. Create an authorization.
2. Capture the full amount.
3. Refund the full amount.


## Advanced capturing

### Partial capture

Test case ID: `70726196-7ae0-4e27-9577-cdbe634207ef`

1. Create an authorization.
2. Capture some of reserved money.

### Multiple partial captures

Test case ID: `8ccd855e-6c91-4d6a-9ace-82cfbc197ab4`

1. Create an authorization.
2. Capture some of the reserved money.
3. Capture the remaining amount.


## Advanced refunding

### Partial refund

Test case ID: `6a7a6c39-cdec-4363-b6b3-ecd192765a6d`

1. Create an authorization.
2. Capture the full amount.
3. Refund some of the amount.

### Partial capture and full refund

Test case ID: `16e0a32c-8745-4bf8-b415-ccef2394bc7b`

Example amounts in [ ].

1. Create an authorization. [1000]
2. Capture some of the amount. [500]
3. Capture some more (but not the remaining). [400]
4. Refund all that has been captured. [900]

### Partial capture and partial refund

Test case ID: `179871d8-2035-48c0-b1af-03e6d5e97b77`

Example amounts in [ ].

1. Create an authorization. [1000]
2. Capture some of the amount. [500]
3. Capture the remaining amount. [500]
4. Refund some of what has been captured. [900]


## Using card tokens

### Authorization

Test case ID: `524eb908-f590-4e42-9d34-2e7f607d216a`

1. Create a card.
2. Use the card token to create an authorization.
3. Void the transaction.

### Credit

Test case ID: `08687376-1f7e-4199-b22e-e51b653a1150`

1. Create a card.
2. Use the card token to create a credit.


## 3D Secure

### Visa

Test case ID: `224bd6ea-d7dd-40f1-aa21-3882e31b766d`

1. Create an authorization with 3D Secure on a Visa card.
2. Capture the full amount.

### MasterCard

Test case ID: `2227a512-7ae1-4cfc-82da-d7059c0b8ee5`

1. Create an authorization with 3D Secure on a MasterCard card.
2. Capture the full amount.


## Recurring

### Initial

Test case ID: `c8c6352b-e5a8-40ac-8edf-073b84aa36ab`

1. Create a recurring on a card number that has not previously been used.
2. Capture the full amount.

### Subsequent

Test case ID: `76c0e51b-eb7f-4a49-a36f-6afd98edefb4`

1. Create a recurring on the same card as was used in test case
   `c8c6352b-e5a8-40ac-8edf-073b84aa36ab`.
2. Capture the full amount.
