---
title: Order | Gengo API
---

# Order methods

This describes the endpoints that deal with Order on the Gengo API.

* [Order __(GET)__](#order-get)

## Order (GET)

__Summary__
: Retrieves a group of jobs that were previously submitted together by their order id.

__URL__
: http://api.gengo.com/v2/translate/order/{order_id}

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.
  * ts(required) Current Unix epoch time as an integer.

__Example call__

    #!ruby
    #!/usr/bin/env ruby

    require 'mygengo'

    @mygengo_client = MyGengo::API.new({
        :public_key => 'pub_key',
        :private_key => 'priv_key',
        :sandbox => false,
    })

    puts @mygengo_client.getTranslationOrderJobs({
        :order_id => 559516
    })


__Response__

<%= headers 200 %>
<%= json :order_get %>
