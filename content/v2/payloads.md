---
title: Payloads | Gengo API
---

# Payloads

__Most of the processing throughout the Translate API will be around a Job Payload. This is a simple container representing the instance of a translation job.__

* [For responses](#job-payload---for-responses)
* [For submissions](#job-payload---for-submissions)

##Job Payload - For responses

job_id
: _String_ of Job ID.

body_src
: _String_ of original body of text (to be translated).

body_tgt
: _String_ of translated body of text (if available).

lc_src
: _String_ of source language code. Gengo uses IETF codes to define languages and language pairs.

lc_tgt
: _String_ of target language code.

unit_count
: _Integer_ of count of source language units (either words or characters depending on source language)
tier String. Quality level ("machine", "standard", "pro", or "ultra")

credits
: _Decimal_ of credit price based on language pair and tier.

status
: _String_ of current status of job. Either "available", "pending", "reviewable", "revising", "approved", or "cancelled".

captcha_url
: _String_ of the full URL to a captcha image, used only if a job is in the "reviewable" state and you wish to reject the job.

eta
: _Integer_ of Estimated seconds until completion.
callback_url String. The full URL to which we will send system updates (completed jobs, new comments, etc.).

auto_approve
: _Boolean_ of whether the job will be automatically approved after translation has completed.

ctime
: _String_ of Unix Timestamp for when this job was submitted (by you - not by the translator).

custom_data
: _String_ of up to 1K of client-specific data that may have been sent when the job was submitted.
mt This value will be "1" if the text in body_tgt is a machine translation. A machine translation is provided as a convenience while a human translation is pending. You can choose to use or discard the provided translation.

##Job Payload - For submissions

body_src
: _String_ of original body of text (to be translated).

lc_src
: _String_ of source language code. Gengo uses IETF codes to define languages and language pairs.

lc_tgt
: _String_ of target language code.

tier
: _String_ of quality level ("machine", "standard", "pro", or "ultra")

type
: _String_ of job type. Either 'text' (default) or 'file'. Use 'file' for ordering file jobs via the API using job identifiers from the file quote function.

identifier _(required if type = 'file')_
: _String_ of the identifier returned as a response from the file quote method (e.g. identifer = '2ea3a2dbea3be97375ceaf03200fb184')

glossary_id _(optional)_
: _String_ id of the glossary that you want to use.

position _(optional)_
: _String_ of the position of the job in a group of jobs. When the job group is displayed to translators, this ensures that ordering is maintained. This parameter is ignored when a group of jobs is submitted without as_group or if the string of the position cannot be casted into an integer.

force _(optional) 1 (true) / 0 (false - default)_
: _Integer_ of whether or not to override lazy loading and force a new translation. Read about lazy loading here.

comment _(optional)_
: _String_ of instructions or comments for translator to consider when translating.

use_preferred _(optional) 1 (true) / 0 (false)_
: _Integer_ of whether to use translators from the preferred translators list associated with the account.

callback_url _(optional)_
: _String_ of the full URL to which we will send system updates (completed jobs, new comments, etc.).

auto_approve _(optional) 1 (true) / 0 (false)_
: _Integer_ of whether to automatically approve jobs after they've been translated. Default is false. If false, completed jobs will await review and approval by customer for 72 hours.

custom_data _(optional)_
: _String_ of up to 1K of storage for client-specific data that may be helpful for you to have mapped to this job.