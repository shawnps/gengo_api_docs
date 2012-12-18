---
title: Translation API | Gengo
description : Translate and globalize your platform or website with our Translation API. Machine translate for free or integrate professional translation for pennies.
keywords: Gengo, Translation
---

# The Gengo API

The Gengo API helps you to take your service global. Whether you're integrating an option for translation for your
users, or building a fun translation application, our API handles a [variety of
languages](http://gengo.com/how-it-works/pricing-languages/) and [features](http://gengo.com/api/).

The online documentation here describes the resources comprising the official Gengo API. You can jump right in by
browsing the resources on the right >>

The current version of the Gengo API is v2. If you have any problems or requests please [contact
support](mailto:support@gengo.com?subject=Gengo API Inquiry). We are also on IRC on [freenode](http://freenode.net/) in
the channel __#Gengo__. Please stop by and ping us!

For older versions of the Gengo API, you can view [previous API documentation](/legacy/).

Also, if you notice any inconsistencies or mistakes in our documentation, please don't hesitate to [contact
support](mailto:support@gengo.com?subject=Gengo API Documentation inconsistency) to let us know or, if you feel up to
it, issue a pull request to [our Documentation Github repository](https://github.com/mygengo/gengo_api_docs) because it
is open source !

## Current known issues (Updated 2012-12-12)

Below are a list of current issues that we know exist in our API and are working to resolve. We apologise for any
inconvenience that they may cause and appreciate your patience in working around them.

* _Ordering a large batch of jobs and then immediately afterwards ordering the first load again (lazy-loading the order)
may result in double charging if the job queue has not finished processing the jobs that were ordered the first time_
: Suggested workaround is to get the status of the initial order by [querying using the order id](/v2/order/#order-get)
or [receiving a callback](/v2/callback_urls/). If this is not possible, please try lazy loading after waiting for at
least 5 minutes after the initial order.
