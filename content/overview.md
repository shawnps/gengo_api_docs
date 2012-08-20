---
title: Gengo API Overview
---

# Gengo API v2 Overview

* <a href="#translation-flow">Translation Flow</a>
* <a href="#what-happens-behind-the-scenes">Behind the Scenes</a>
* <a href="#methodology">Methodology</a>
* <a href="#ordering-jobs">Ordering jobs</a>
* <a href="#working-without-a-database">Working without a database</a>
* <a href="#polling">Polling</a>
* <a href="#callbacks">Callbacks</a>
* <a href="#grouping-jobs">Grouping jobs</a>
* <a href="#escaping-text-from-a-job">Escaping text from a job</a>
* <a href="#different-levels">Different levels (Standard, Pro, Ultra)</a>
* <a href="#cancelling-jobs">Cancelling jobs</a>
* <a href="#comments">Comments</a>
* <a href="#the-review-process">The review process</a>
    * <a href="#approving-jobs">Approving jobs</a>
    * <a href="#automatic-approval">Automatic approval</a>
    * <a href="#revising-jobs">Revising jobs</a>
    * <a href="#rejecting-jobs">Rejecting jobs</a>
* <a href="#order-machine-translation">Ordering machine translation</a>
* <a href="#machine-translation-preview">Getting a preview translation by machine</a>
* <a href="#retrieve-orders-placed-from-web-ui-via-the-api-and-vice-versa">Retrieve orders placed from Web UI via the API and vice versa</a>
* <a href="#using-credits">Using credits</a>
* <a href="#call-formats">Call formats</a>
* <a href="#response-formats">Response formats</a>
* <a href="#encoding">Encoding</a>


## Translation flow

The Gengo API allows you to connect your app to Gengo, and order human translation without needing to use a manual web interface. Because human translation is not instant, our API is asynchronous (a bit like <a href='http://mturk.com'>Mechanical Turk</a>). This means that unlike some other web APIs like <a href='http://flickr.com'>Flickr</a> or <a href='http://twitter.com'>Twitter</a>, you need to allow time for translators to complete their translations.


## What happens behind the scenes

Gengo uses a large (800+) team of translators, who are in all timezones around the globe. All translators who want to work for myGengo first have to take and pass at least one translation test.

Gengo's translators are notified of new jobs when they come in, and work on translations on a first-come, first-serve basis. They work on the jobs within our website's translation interface.


## Methodology

The Translate API attempts to follow a <a href='http://en.wikipedia.org/wiki/Representational_state_transfer'>REST-based architecture</a>.  The main resource (entry-point) revolves around jobs, and state changes on jobs should be done with PUT calls on the desired resource.  For situations where certain HTTP methods can not be used (such as PUT or DELETE), methods can be overridden with the "_method" parameter.


## Ordering jobs

To order translation, you should make a <a href='/v2/translate/jobs'>translate/jobs/ (POST)</a> call. See the method page for details. It's pretty straightforward! When you order jobs, they become "available" which means our translators can view them and start working on them straight away. When a translator picks up a job the status becomes "pending", and when they have finished the translation the status becomes "reviewable". There are two ways to find out if a job has been translated - polling a URL, and assigning a callback.


## Working without a database

If you want to order translations within your app without using a database, you can use what we call "lazy loading" to request strings to be translated without having to pass an ID to our app every time you want to check on their progress or receive a translation back. For instance, if you have a simple PHP website that just has a few strings in it, you might not want to have to store the unique ID we return from our translate/jobs/ POST call - instead, you can use <a href='/v2/translate/jobs'>translate/jobs/ (POST)</a> and simply pass us a string. If it has already been requested by you, you won't be charged again for the translation - and if has been translated you will receive back the translation at that point.


## Polling

Each job has a unique URL that will return the status of the job.  A typical response will mention its status ("incomplete", "reviewable", etc.) and include the translated content if completed and approved.  If the job is not yet complete, a machine translation will be offered temporarily.  Excessive polling will result in a suspended account, so please be reasonable about using this method.  We currently recommend polling not more than once every 30 minutes.


## Callbacks

Callbacks are our recommended way of being notified when a translation job is ready. Each api_key (obtained from the Account area) can be assigned a default callback URL telling myGengo where to send notifications when a job is ready for approval. Similar to PayPal’s IPN methodology, this allows an API implementation to be notified about translation jobs when they are ready.  Read details about how this works on the <a href='/v2/callback_urls'>Callback URLs</a> page.


## Grouping jobs

If you want a set of jobs to be completed by one translator, you can group them when you place the <a href='/v2/translate/jobs'>translate/jobs/ (POST)</a> call. This is useful if you want to ensure consistency - but please bear in mind it will take longer than a non-grouped order as the jobs will have to be done sequentially rather than in parallel.


## Escaping text from a job

Sometimes you might want to include text within a job that you do not need to be translated (such as code blocks, or inline comments for the translator). To exclude text from the word count of a job, and indicate to the translator that it does not need to be translated, you can wrap text within triple square brackets [[[like this]]]. Please remember to close your triple brackets, and try to avoid having large areas of excluded text - it's normally better to break the job into parts instead.


## What do the different levels (Standard, Pro, Ultra) mean?

Please see our <a href='http://gengo.com/help/quality_policy'>Quality Policy</a> page for more information.


## Cancelling jobs

Call <a href='/v2/translate/job_id_delete'>translate/jobs/{id} (DELETE)</a> to cancel a job. If you are unable to use the DELETE http method, you can fake the method by adding the _method="delete" parameter. You may only cancel translations while their status is "available" - this is to avoid wasting translator time.


## Comments

You can add comments to each job, whatever status it is in. Use the <a href='/v2/translate/job-id-comment'>translate/job/{id}/comment (POST)</a> method to add comments to a job that you have already submitted, and attach a comment to your job within the <a href='/v2/translate/jobs'>translate/jobs/ (POST)</a> call when you order.

We recommend you do add comments to all jobs to give context and direction to the translator. Jobs that have comments are usually picked up and translated more quickly than those that don't. Translators can also add comments to a job to add detail, or ask for clarifications.

If your system will not be able to respond to comments, or you do not plan to, it is helpful to add a comment saying "Our system is unable to respond to any translator comments" or similar - this will avoid the translator waiting for a response from you. We may add a further parameter for this specific case - let us know what you think using the "Feedback" tab.

Please bear in mind that it is prohibited by our terms of service to solicit contact details from a myGengo translator.


## The review process

As we charge for human translation, we offer our customers the opportunity to review jobs and formally approve them. To handle the approval process in your application, you will need to build an interface for your users to review the preview text, and potentially to review a captcha.

By approving a job you are telling us that you are happy with the translation and that you require no further work from the translator and that job. Please be aware that it is extremely difficult for us to make changes or offer any kind of refund after a job has been approved.

If you prefer not to manually approve jobs, or your system does not have the capability, you can simply add the auto_approve="true" parameter to your job requests. This will instantly approve jobs when they are submitted, and provide you with the full translated text. Please note that by using the auto_approve parameter you waive your right to reject or request revisions on a translation.


### Approving jobs

To approve a job, send a <a href='/v2/translate/job-id-put'>translate/job/{id} (PUT)</a> call with the action set to "approve". You can also add feedback at this time, consisting of a rating from 1-5, a comment for the translator and a comment for myGengo. The feedback rating and comment for the translator are sent to the translator, and myGengo receives the rating, comment for translator and comment for myGengo.

It really helps us to receive feedback ratings for each translation, as we can see how well our translators are doing, reward good work, and provide guidance to any translator that is not performing well. We may also use the feedback ratings in future to prioritize translator-job matchings.

For this reason, it is unhelpful to place automatic feedback rating commands into your application - for instance by always rating each job as 3/5. So please only submit feedback that has been explicitly provided by a human, otherwise leave it blank.

### Automatic approval

If a job is in a reviewable state for a certain time, it will be automatically approved. This is so that translators do not have to wait unnecessarily for confirmation or payment. The period is 72 hours, or 24 hours for each 1000 words, whichever is the greatest. For example, a 5,000 word job would have an auto-approve period of 24 hours x 5 = 120 hours.

### Revising jobs

If a job requires corrections, you can request them using the <a href='/v2/translate/job-id-put'>translate/job/{id} (PUT)</a> call, and the "revise" action. Please be as descriptive as possible with your comment when you request a correction.

### Rejecting jobs

If you are unhappy with a translation from myGengo, you have the opportunity to reject the job and either receive a credits refund, or pass the job onto a different translator. For more details on what you can expect from our translation, please visit our <a href='http://gengo.com/help/quality_policy/'>Quality Policy</a> page, which outlines what constitutes a fair or unfair rejection.

All rejections are reviewed by our staff, and we take each one seriously - normally we will contact the translator and review what has gone wrong with that particular translation. While we are obviously happy to uphold fair rejections, if you persistently reject jobs without reason, your account will be suspended as this kind of behaviour is unfair to the translator and time-consuming for us.

To reject a job, use the <a href='/v2/translate/job-id-put'>translate/job/{id} (PUT)</a> call with the action parameter set to "reject". We insist that rejections are made by humans (because we don't want machines rejecting translations) so we require you to complete a captcha when you submit a rejection. See the translate/job/{id} (PUT) page for more details.

## Order machine translation

We've tried to make it convenient for you to use the myGengo API both for human and machine translation. While we're not big fans of the low quality machine translation can produce, we realise that not all users want, or can afford for, all of their content to be translated by humans. So it's easy for you to switch between the two, and machine translation is free. If you would like to order machine translation only, simply use the tier="machine" when you call the translate/jobs (POST) method and you will not be charged for your order.   Please also note that machine translations have a character limit of 7500 characters.

We use Google's Translate API service to supply our machine translation. Let us know if there's another free service you'd like us to add by using the Feedback tab.

## Machine translation preview

If you have ordered human translation, and are still waiting for the job to be reviewable, you can see a machine translation preview by including the pre_mt="1" parameter. This might be useful if you have new content that you want to show up on a page, and you don't want to wait for the human translation before publishing.

## Retrieve orders placed from Web UI via the API and vice versa

If you place an order via the web form, you can retrieve it via the API by using the job ID which is found through your customer dashboard, and use it in calls like <a href='/v2/translate/job-id-get'>translate/job/{id} (GET)</a>. Please note that jobs ordered via the web form do not trigger API callbacks.

You can see jobs placed through the API on the website, on your customer dashboard, by logging into the mygengo.com site.


## Using credits

All human translation jobs ordered via the API require up-front payment of myGengo credits. Credits are deducted from your account when you order jobs via a <a href='/v2/translate/jobs'>translate/jobs/ (POST)</a> call (except when you use a tier of "machine" to order machine translation). You can buy credits by logging into the mygengo.com site and visiting your Account page. The current version of the myGengo Translate API requires accounts to maintain a positive credit balance for jobs to be translated.  If there are not enough credits to process a job when it is submitted via the API, the response will indicate this.

## Call Formats
All API calls require the api_key parameter to be sent.  Authenticated calls must also be signed and sent with the api_sig parameter.  If the call is by POST, parameters specific to the entry-point should be wrapped in a parameter named "data".

For example, an API call might send the following key-value pairs:

<pre class='code'>
array(
'api_key' => ...,
'_method'  => 'put',
'api_sig' => ...
'data' => ...
)
</pre>

A GET call on the other hand might have the following query string:
?api_key=...&api_sig=...&lc_src=..


## Response Formats

All API responses will contain at least 1 and possibly 2 key-value pairs.  The second key's name will depend on whether the call was successful or not.  The second key name for a successful call with an expected payload will be "response", i.e. {"opstat" : "ok", "response" : "..."} and a failed response will have second key name as "err", i.e. {"opstat" : "error", "err" : {"code" : ...}}

Currently the API can respond in one of two response formats: JSON and XML.  Examples of successful and failed responses in each format can be found on the [example call and responses] page.  You can specify the response format as an HTTP Header value ("Accept: application/json"), or send the format query parameter with the desired response type.  If both an HTTP Header value and format parameter exist, the format parameter takes precedence.  By default, responses are sent in JSON.


## Encoding

myGengo expects all data to be UTF-8 encoded and will respond with UTF-8 encoded data. Make sure you encode your data in UTF-8 to avoid issues.