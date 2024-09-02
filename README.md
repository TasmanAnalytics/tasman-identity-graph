[![tasman_logo][tasman_wordmark_black]][tasman_website_light_mode]
[![tasman_logo][tasman_wordmark_cream]][tasman_website_dark_mode]

---
*We are the boutique analytics consultancy that turns disorganised data into real business value. [Get in touch][tasman_contact] to learn more about how Tasman can help solve your organisations data challenges.*

# tasman-identity-graph
Identity resolution (sometimes referred to as 'identity stitching' or 'identity backstitching') is the process by which multiple user identities are unified into a single profile. It is a critical step in the tracking process to ensure accurate measurement of user behaviour across multiple apps or sessions, and the creation of a single customer view.

Rudderstack as a CDP has a paid for feature that does this identity resolution for you, but you can also implement it yourself by utilising identity graphs. We find all the different identifiers that are connected together, these identifiers are called **vertices**, and links between them, called **edges**. In an identity graph, each node/vertex represents a user identifier, and a link/edge exists where two or more identifiers have at some point in time been captured together.

Each connected component (set of connected edges and vertices) of the identity graph represents a single user profile, and enables the building of a comprehensive view of each user across multiple sessions and apps.

Identity graphs are constantly evolving, and a user profile may have lots of different identifiers over its lifetime.

## Our Resolution

As an overview, our approach takes a set of rudderstack identify event calls, and creates user profiles using this connected component algorithm. For this approach you need an understanding of SQL and dbt to implement/orchestrate the work.

You need to select which identifiers you wish to use in this graph, the ones chosen in this example are a backend `user_id`, the `anonymous_id` from the events, and an `email`.  You only need 2 to make this work.

The output table will provide you for every id found the `profile_id` for that individual user profile. 

| ORIGINAL_ID | PROFILE_ID |
| --- | --- |
| anon1 | anon1 |
| user1 | anon1 |
| user1@example.com | anon1 |
| user25@example.com | anon1 |
| anon2 | anon2 |
| user2 | anon2 |
| user2@example.com | anon2 |
| anon4 | anon4 |
| user4 | anon4 |
| user4@example.com | anon4 |
| anon5 | anon5 |
| anon6 | anon5 |
| user5 | anon5 |
| user5@example.com | anon5 |
| user6@example.com | anon5 |

You can then use this table to join back on your events table and find the way that they join together to create a single user.

**Key Features:**
- 🔥 Uses a conected component algorithm to resolve identities of users
- ⚙️ Configure the number of times you would like the resolution to run. 

## Getting Started
- You need a table of identify events in the format: 
    event_id, user_id, anonymous_id, email, event_time

## Supported Data Warehouses
This package currently supports Snowflake.

## Contact
This package has been written and is maintained by [Tasman Analytics][tasman_contact]

If you find a bug, or for any questions please open an issue on GitHub.

<!---
The links below need updating with the package name for utm_campaign
--->

[tasman_website_dark_mode]: https://tasman.ai?utm_source=github&utm_medium=internal-referral&utm_campaign=tasman-identity-graph#gh-dark-mode-only
[tasman_website_light_mode]: https://tasman.ai?utm_source=github&utm_medium=internal-referral&utm_campaign=tasman-identity-graph#gh-light-mode-only
[tasman_contact]: https://tasman.ai/contact?utm_source=github&utm_medium=internal-referral&utm_campaign=tasman-identity-graph
[tasman_wordmark_cream]: https://raw.githubusercontent.com/TasmanAnalytics/.github/master/images/tasman_wordmark_cream_500.png#gh-dark-mode-only
[tasman_wordmark_black]: https://raw.githubusercontent.com/TasmanAnalytics/.github/master/images/tasman_wordmark_black_500.png#gh-light-mode-only 