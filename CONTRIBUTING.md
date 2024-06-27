# Contributing

## Update the Project Readme
The readme must be updated with the appropriate information for the package.

The UTMs in the Tasman website links need updating with the package name.

## Update the integration_tests/pyproject.toml file

The name and description of the package needs updating, as does any required versions of dbt and other packages.

## Setting up CI (Snowflake Only - Delete the workflow for non snowflake projects)

The Snowflake credentials for the [CI User](https://start.1password.com/open/i?a=42H2BWQB2ZCPLOKXJJ4F4ESLQM&v=jfvurlkbuupihjfqitylwp3swe&i=fgvlwgg3k2cec5lqatu7htmh4e&h=tasman.1password.com) must be added to the repo in Settings > Secrets and Variables > Actions > Repository Secrets

## Updating the package dbt_project.yml file
The file needs updating with the package name, and any package level configurations (such as schema names or materialisations).

## Updating the integration tests dbt_project.yml file
This file needs updating the appropriate configurations to run the package in a test environment, such as updating project variables, and including test data seeds etc.