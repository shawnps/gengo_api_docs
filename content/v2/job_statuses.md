---
title: Job statuses | Gengo API
---

# Job statuses

Each submitted job goes through a series of statuses before delivery. At any time when you request the contents of a job, it will be in one of the following states:

`available`
: Ready for a translator to take the job for translation.

`pending`
: Currently being translated.

`reviewable`
: Translation has finished and is awaiting submitter approval.

`approved`
: Submitter has approved the translation.

`rejected`
: Translation has been rejected and is no longer available.

`canceled`
: Translation has been canceled before being pickedup, and is no longer available.
