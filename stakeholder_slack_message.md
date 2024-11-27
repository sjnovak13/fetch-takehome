<!-- Fourth: Communicate with Stakeholders
Construct an email or slack message that is understandable to a product or business leader who isn’t familiar with your day to day work. This part of the exercise should show off how you communicate and reason about data with others. Commit your answers to the git repository along with the rest of your exercise.

What questions do you have about the data?
How did you discover the data quality issues?
What do you need to know to resolve the data quality issues?
What other information would you need to help you optimize the data assets you're trying to create?
What performance and scaling concerns do you anticipate in production and how do you plan to address them? --> 

Hi `Stakeholder-Name`,

I have conducted a review of the Users, Brands, and Receipts data that was shared with discovered data quality issues with the Users data. Some of these issues can be resolved automatically, but I have some questions as well. Please find my questions/comments below:

1. The `users.json` file has apparent duplicate id's. Should the `_id` column be unique? If so, this can be resolved by deduplicating the data on that column.
    - Ex: `_id`: `5ff1e194b6a9d73a3a9f1052`
2. Certain fields are missing from some records. If the fields are required, then steps need to be taken to re-populate the file with the required values. Otherwise, can these fields be populated as `NULL` in the case that fields are missing?
    - Ex: `_id`: `5ff616a68f142f11dd189163` is missing the `lastlogin` field.
3. A high proportion of the values in the `state` field are `WI` with a couple of other states included. Is it expected that a high number of users reside in Wisconsin? This could indicate a bug in the sign-up application.

Please review my findings and let me know if you would like to jump on a call to discuss in more detail.