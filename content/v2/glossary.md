---
title: Glossary | Gengo API
---

# Glossary methods

This describes the endpoints that deal with Glossaries on the Gengo API.

* [Glossaries __(GET)__](#glossaries-get)
* [Glossary __(GET)__](#glossary-get)


## Glossaries (GET)

__Summary__
: Retrieves a list of glossaries that belongs to the authenticated user

__URL__
: http://api.gengo.com/v2/translate/glossary

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Example call__

    #!ruby
    #!/usr/bin/env ruby

    require 'mygengo'

    @mygengo_client = MyGengo::API.new({
        :public_key => 'pub_key',
        :private_key => 'priv_key',
        :sandbox => false,
    })

    puts @mygengo_client.getGlossaryList


__Response__

<%= headers 200 %>
<%= json :glossary_list_get %>


## Glossary (GET)

__Summary__
: Retreives a glossary by Id

__URL__
: http://api.gengo.com/v2/translate/glossary/{glossary_id}

__Authentication__
: Required

__Parameters___
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Example call__

    #!ruby
    #!/usr/bin/env ruby

    require 'mygengo'

    @mygengo_client = MyGengo::API.new({
        :public_key => 'pub_key',
        :private_key => 'priv_key',
        :sandbox => false,
    })

    puts @mygengo_client.getGlossary(:id => @glossary_id)

__Response__

<%= headers 200 %>
<%= json :glossary_get %>
