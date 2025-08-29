# TF Stacks Demo

This demo is a bit more complicated. You need to have an HCP account with Stacks enabled as well as a GCP project with a service account with the appropriate permissions.

Top level overview of the things you need to do to get this demo working:

1. Create an HCP account,
2. Link your GitHub to it.
3. Enable stacks
4. Create a stack project for this
5. Recommended to create a service account  on your GCP project for the next step
6. Export your credentials as json
7. Create a variable set and import credentials as a sensitive terraform variable called 'gcp-creds'.
8. Replace project field in the provider file and variable set in the deployment file with your gcp project id and variable set id.
9. Should work now.