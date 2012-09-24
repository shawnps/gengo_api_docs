---
title: Job | Gengo API
---

# Job methods

This describes the endpoints that deal with singular Job tasks and information on Gengo API.

* [Job __(GET)__](#job-get)
* [Job __(PUT)__](#job-put)
* [Job __(DELETE)__](#job-delete)
* [Preview __(GET)__](#preview-get)
* [Revisions __(GET)__](#revisions-get)
* [Revision __(GET)__](#revision-get)
* [Feedback __(GET)__](#feedback-get)
* [Comment __(POST)__](#comment-post)
* [Comments __(GET)__](#comments-get)


## Job (GET)

__Summary__
: Retrieves a specific job.

__URL__
: http://api.gengo.com/v2/translate/job/{id}

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.
  * pre_mt(optional) 1 (true) / 0 (false, default). Whether to return a machine translation if the human translation is not complete yet.

__Example call__

    # -*- coding: utf-8 -*-
    #!/usr/bin/python
    from mygengo import MyGengo

    # Get an instance of MyGengo to work with...
    gengo = MyGengo(
        public_key = 'your_public_key',
        private_key = 'your_private_key',
        sandbox = True, # possibly false, depending on your dev needs )

    # Get the job in question; pre_mt set to 1 will give you a machine translation
    # if the human translation isn't available yet. ;)
    gengo.getTranslationJob(id = 42, pre_mt = 1)


__Response__

<%= headers 200 %>
<%= json :JOB_GET %>


## Job (PUT)

__Summary__
: Updates a job to translate.

__URL__
: http://api.gengo.com/v2/translate/job/{id}

__Authentication__
: Required

__Parameters___
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Data arguments__
: * action(required):
      * "revise" - Returns this job back to the translator for revisions
        Other parameters:
          * comment (required) - The reason to the translator for sending the job back for revisions.
      * "approve" - Approves job
        Other parameters:
          * rating (optional) 1 (poor) to 5 (fantastic)
          * for_translator (optional) Comments for the translator
          * for_mygengo (optional) Comments for myGengo staff (private)
          * public (optional) 1 (true) / 0 (false, default). Whether myGengo can share this feedback publicly
      * "reject" - Rejects the translation. Please see our FAQs for details of the rejection process.
        Other parameters
          * reason (required) "quality", "incomplete", "other"
          * comment (required)
          * captcha (required) The captcha image text. Each job in a "reviewable" state will have a captcha_url value, which is a URL to an image. This captcha value is required only if a job is to be rejected. If the captcha is wrong, a URL for a new captcha is also included with the error message.
          * follow_up (optional) "requeue" (default) or "cancel". If you choose "requeue" the job will be rejected and then passed onto another translator. If you choose "cancel" the job will be completely cancelled upon rejection.

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

    # Update a job that has an id of 42, and reject it, cite the reason,
    # add a comment, and throw up some captcha stuff. See the docs for
    # more information pertaining to this method, it can do quite a bit. :)

    gengo.updateTranslationJob(
        id = 42,
        action = {
            'action': 'reject',
            'reason': 'quality',
            'comment': 'My grandmother does better.',
            'captcha': 'bert'
        }
    )

__Response__

<%= headers 200 %>
<%= json :ok_empty_response %>


## Job (DELETE)

__Summary__
: Cancels the job. You can only cancel a job if it has not been started already by a translator.

__URL__
: http://api.gengo.com/v2/translate/job/{id}

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

    # Get the job in question; pre_mt set to 1 will give you a machine translation
    # if the human translation isn't available yet. ;)
    gengo.deleteTranslationJob(id = 42)

__Response__

<%= headers 200 %>
<%= json :ok_empty_response %>


## Preview (GET)

__Summary__
: Renders a JPEG preview image of the translated text.

__URL__
: http://api.gengo.com/v2/translate/job/{id}/preview

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Note__

If the request is valid, a raw JPEG image stream will be returned. The width of the JPEG is 673 pixels, and the height will vary depending on the text length. Please allow enough space within your app to display long preview images (for instance by providing a scrollable area).

In the case of an authentication error, an error response will be returned in JSON or XML format. In the case of other errors, an empty file will be returned.

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

    # This method is a bit tricky; you can call it like below, but how you treat # the returned data is very much up to you.
    gengo.getTranslationJobPreview(id = 42)


## Revisions (GET)

__Summary__
: Gets list of revision resources for a job. Revisions are created each time a translator or Senior Translator updates the text.

__URL__
: http://api.gengo.com/v2/translate/job/{id}/revisions

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
        sandbox = True, # possibly false, depending on your dev needs
        )

    # Get every revision on a job. Returns a data set, iterate if need be!
    print gengo.getTranslationJobRevisions(id = 42)

__Response__

<%= headers 200 %>
<%= json :revisions_get %>


## Revision (GET)

__Summary__
: Gets a specific revision for a job.

__URL__
: http://api.gengo.com/v2/translate/job/{id}/revision/{rev_id}

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
        sandbox = True, # possibly false, depending on your dev needs
        )

    # Get specific revision
    print gengo.getTranslationJobRevision(id = 42, rev_id = 1)

__Response__

<%= headers 200 %>
<%= json :revision_get %>


## Feedback (GET)

Gets a specific revision for a job.

__Summary__
: Retrieves the feedback you have submitted for a particular job.

__URL__
: http://api.gengo.com/v2/translate/job/{id}/feedback

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
        sandbox = True, # possibly false, depending on your dev needs
        )

    # Get feedback given on a job
    print gengo.getTranslationJobFeedback(id = 42)

__Response__

<%= headers 200 %>
<%= json :feedback_get %>


## Comments (GET)

__Summary__
: Retrieves the comment thread for a job.

__URL__
: http://api.gengo.com/v2/translate/job/{id}/comments

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Note__
: Possible values for "author" are "translator", "customer", and "senior translator".

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

    # Get all the comments on a specific job.
    # Note that this returns a data set, so while we just print it below, you'll # inevitably want to iterate over it and such.
    print gengo.getTranslationJobComments(id = 42)

__Response__

<%= headers 200 %>
<%= json :COMMENTS_GET %>


## Comment (POST)

__Summary__
: Submits a new comment to the job's comment thread.

__URL__
: http://api.gengo.com/v2/translate/job/{id}/comment

__Authentication__
: Required

__Parameters__
: * api_key(required) Your API key.
  * api_sig(required) Your API signature.

__Date arguments__
: * body(required): The comment body

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

    # Post a comment on a specific job; perhaps you have an update for the translator # or something of the sort.
    gengo.postTranslationJobComment(
        id = 42,
        comment = {
            'body': 'I love lamp!'
        }
    )

__Response__

<%= headers 200 %>
<%= json :ok_empty_response %>