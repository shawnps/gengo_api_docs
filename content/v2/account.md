---
title: Account | Gengo API
---

# Account methods

This describes the endpoints that deal with Account information on Gengo API.

* [Stats __(GET)__](#stats-get)
* [Balance __(GET)__](#balance-get)

## Stats (GET)

__Summary__
: Retrieves account stats, such as orders made.

__URL__
: http://api.gengo.com/v2/account/stats

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.
  * ts(required) Current Unix epoch time as an integer.

__Example call__

    #!python
    # -*- coding: utf-8 -*-
    #!/usr/bin/python

    from gengo import Gengo

    # Get an instance of Gengo to work with...
    gengo = Gengo(
        public_key='your_public_key',
        private_key='your_private_key',
        sandbox=False, # possibly false, depending on your dev needs )

    # Print the account stats...
    print gengo.getAccountStats()


__Response__

<%= headers 200 %>
<%= json :account_stats %>

## Balance (GET)

__Summary__
: Retrieves account balance in credits.

__URL__
: http://api.gengo.com/v2/account/balance

__Authentication__
: Required

__Parameters___
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.
  * ts(required) Current Unix epoch time as an integer.

__Example call__

    #!python
    # -*- coding: utf-8 -*-
    #!/usr/bin/python
    from gengo import Gengo

    # Get an instance of Gengo to work with...
    gengo = Gengo(
        public_key='your_public_key',
        private_key='your_private_key',
        sandbox=False, # possibly false, depending on your dev needs
        debug=True)

    # Retrieve and print the account balance. Properties ahoy!
    print gengo.getAccountBalance()['response']['credits']

__Response__

<%= headers 200 %>
<%= json :account_balance %>
