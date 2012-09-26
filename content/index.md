---
title: Gengo API
---

# The Gengo API

The Gengo API helps you to take your service global. Whether you're integrating an option for translation for your users, or building a fun translation application, our API handles a [variety of languages](http://gengo.com/how-it-works/pricing-languages/) and [features](http://gengo.com/api/).

The online documentation here describes the resources comprising the official Gengo API. You can jump right in by browsing the resources on the right >>

The current version of the Gengo API is v2. If you have any problems or requests please [contact support](mailto:support@gengo.com?subject=Gengo API Inquiry).

For older versions of the Gengo API, you can view [previous API documentation](/legacy/).

Also, if you notice any inconsistencies or mistakes in our documentation, please don't hesitate to [contact support](mailto:support@gengo.com?subject=Gengo API Documentation inconsistency) to let us know or, if you feel up to it, issue a pull request to [our Documentation Github repository](https://github.com/mygengo/gengo_api_docs) because it is open source !

## Current known issues (Updated 2012-09-27)

Below are a list of current issues that we know exist in our API and are working to resolve. We apologise for any inconvenience that they may cause and appreciate your patience in working around them.

* _Ordering job(s), cancelling the job(s) and then using the Force parameter to order them results in lazy-loading retrieve on the jobs only returning machine translations (reported 2012-09-19)_
: Suggested workaround is to retrieve the Force-ordered jobs via [querying by job id](/v2/jobs/#jobs-by-id-get)

* _Ordering a large batch of jobs and then immediately afterwards ordering the first load again (lazy-loading the order) may result in double charging if the job queue has not finished processing the jobs that were ordered the first time (reported 2012-09-19)_
: Suggested workaround is to get the status of the initial order by [querying using the order id](/v2/order/#order-get) or [receiving a callback](/v2/callback_urls/). If this is not possible, please try lazy loading after waiting for at least 5 minutes after the initial order.

* _When using V2, if a non-reachable callback url is set in each job payload in a group of jobs, the jobs will individually take very long to get processed and become available to translator and the customer dashboard (reported 2012-09-27)_
: Suggested workaround to make sure that the callback url is reachable prior to placing orders.


## Upcoming Changes

*2012-09-19*
We are currently working on improved stability and better error messaging in response payloads. We have also recently changed how we manage the Gengo API documentation so we can make faster updates.
