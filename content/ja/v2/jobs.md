---
title: Jobs | Gengo API
---

# Jobs methods

This describes the endpoints that deal with Jobs on the Gengo API.

* [Job Group __(GET)__](#job-group-get)
* [Jobs __(POST)__](#jobs-post)
* [Jobs __(GET)__](#jobs-get)
* [Jobs by {id} __(GET)__](#jobs-by-id-get)


## Job group (GET)

__Summary__
: Retrieves a group of jobs that were previously submitted together by their group id.

__URL__
: http://api.gengo.com/v2/translate/jobs/group/{group_id}

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Example call__

    # -*- coding: utf-8 -*-
    #!/usr/bin/python
    from mygengo import MyGengo

    # Get an instance of MyGengo to work with...
    gengo = MyGengo(
        public_key = 'your_public_key',
        private_key = 'your_private_key',
        sandbox = True, # possibly false, depending on your dev needs )

    # If you have one job id, but want to get the id of every other job that
    # was submitted with it, you can do this.
    print gengo.getTranslationJobBatch(id = 42)


__Response__

<%= headers 200 %>
<%= json :job_group_get %>


## Jobs (POST)

__Summary__
: Submits a job or group of jobs to translate.

__URL__
: http://api.gengo.com/v2/translate/job/s

__Authentication__
: Required

__Parameters___
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Data arguments__
: * jobs(required): An array of Job Payloads. Please see the job payloads page for full details of the required parameters.
  * as_group(optional): 1 (true) / 0 (false, default). Whether all jobs in this group should be done by one translator. Some restrictions apply to what jobs can be grouped, including the requirement that language pairs and tiers must be the same across all jobs.

__Example call__

    # -*- coding: utf-8 -*-
    #!/usr/bin/python
    from mygengo import MyGengo

    # Get an instance of MyGengo to work with...

    gengo = MyGengo(
        public_key = 'your_public_key',
        private_key = 'your_private_key',
        sandbox = True, # possibly false, depending on your dev needs
        )

    # This is an exhaustive view of this object; chances are your code will never
    # have to be this verbose because you'd want to build it up programmatically.
    data = {
        'jobs': {
            'job_1': {
                'type': 'text', # REQUIRED. Type to translate, you'll probably always put 'text' here. 'slug': 'Single :: English to Japanese', # REQUIRED. Slug for internally storing, can be generic.
                'body_src': 'Testing myGengo API library calls.', # REQUIRED. The text you're translating. ;P
                'lc_src': 'en', # REQUIRED. source_language_code (see getServiceLanguages() for a list of codes)
                'lc_tgt': 'ja', # REQUIRED. target_language_code (see getServiceLanguages() for a list of codes)
                'tier': 'standard', # REQUIRED. tier type ("machine", "standard", "pro", or "ultra")  'auto_approve': 0, # OPTIONAL. Hopefully self explanatory (1 = yes, 0 = no)
                'comment': 'HEY THERE TRANSLATOR', # OPTIONAL. Comment to leave for translator.'callback_url': 'http://...', # OPTIONAL. Callback URL that updates are sent to.'custom_data': 'your optional custom data, limited to 1kb.' # OPTIONAL
            },
            'job_2': {
                'type': 'text', # REQUIRED. Type to translate, you'll probably always put 'text' here. ;P
                'slug': 'Single :: English to Japanese', # REQUIRED. Slug for internally storing, can be generic.
                'body_src': 'Testing myGengo API library calls.', # REQUIRED. The text you're translating. ;P
                'lc_src': 'en', # REQUIRED. source_language_code (see getServiceLanguages() for a list of codes)
                'lc_tgt': 'ja', # REQUIRED. target_language_code (see getServiceLanguages() for a list of codes)
                'tier': 'standard', # REQUIRED. tier type ("machine", "standard", "pro", or "ultra")'auto_approve': 0, # OPTIONAL. Hopefully self explanatory (1 = yes, 0 = no)'comment': 'HEY THERE TRANSLATOR', # OPTIONAL. Comment to leave for translator.             'callback_url': 'http://...', # OPTIONAL. Callback URL that updates are sent to.'custom_data': 'your optional custom data, limited to 1kb.' # OPTIONAL         }, },
            'process': 1, # OPTIONAL. 1 (true, default) / 0 (false). Whether to pay for the job(s) and make them available for translation.
            'as_group': 1, # OPTIONAL. 1 (true) / 0 (false, default). Whether all jobs in this group should be done by one translator.
        }

    # And now we post them over...
    prints gengo.postTranslationJobs(jobs = data)

__Response__

In all cases, the response from should be near instant. That said, there are 3 possible types of response payloads depending on the jobs that were submitted in the POST call.

_All jobs are new_

If there are only new jobs (see lazy loading), or all jobs have the force flag, the response will have a new order id, the number of jobs, the total cost of the order, as well as a group id if the as_group flag is set to true.

<%= headers 200 %>
<%= json :jobs_post_all_new %>

_All jobs are old_

If there are only lazy jobs (i.e. all jobs have already been ordered before and translations exist), the response is a list of the jobs, keyed the same as in the original submission. Notice that each index is a list, as there may be several lazy jobs for a single payload if the force flag has been used in past POSTs.

<%= headers 200 %>
<%= json :jobs_post_all_old %>

_Mix of new and old jobs_

If there is a mix of lazy jobs and new jobs in the POST, you will get back a response that contains the old jobs, an order ID for the new jobs, number of new jobs, total cost, and a group ID for the new batch of jobs in the order.

<%= headers 200 %>
<%= json :jobs_post_mix %>

## Jobs (GET)

__Summary__
: Retrieves a list of resources for the most recent jobs filtered by the given parameters.

__URL__
: http://api.gengo.com/v2/translate/jobs

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Data arguments__
: * status(optional): "unpaid", "available", "pending", "reviewable", "approved", "rejected", or "canceled"
  * timestamp_after(optional): Epoch timestamp from which to filter submitted jobs.
  * count(optional): Defaults to 10. Maximum 200.

__Note__

* If you only use count, you'll get the most recent count jobs.
* If you use count with timestamp_after, you'll get count jobs submitted since timestamp_after.
* If you only use timestamp_after, you'll get all jobs submitted since timestamp_after.

__Example call__

    # -*- coding: utf-8 -*-
    #!/usr/bin/python
    from mygengo import MyGengo

    # Get an instance of MyGengo to work with...
    gengo = MyGengo(
        public_key = 'your_public_key',
        private_key = 'your_private_key',
        sandbox = True, # possibly false, depending on your dev needs )

    # Think of this as a "search my jobs" method, and it becomes very self-explanatory.
    print gengo.getTranslationJobs(status = "upaid", count = 15)


__Response__

<%= headers 200 %>
<%= json :jobs_get %>


## Jobs by id (GET)

__Summary__
: Retrieves a list of jobs. They are requested by a comma-separated list of job ids.

__URL__
: http://api.gengo.com/v2/translate/jobs/{ids}

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Example call__

    #!/usr/bin/env ruby

    require 'mygengo'

    @mygengo_client = MyGengo::API.new({
        :public_key => 'pub_key',
        :private_key => 'priv_key',
        :sandbox => false,
    })

    puts @mygengo_client.getTranslationJobs(:ids => [1,2,3,4,5])

__Response__

<%= headers 200 %>
<%= json :jobs_by_ids_get %>