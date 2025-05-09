# dlt-hub/dlt #2221

## Requirements

**Tools**:
* [just](https://github.com/casey/just)
* [poetry>=2.1](https://github.com/python-poetry/poetry)
* [az](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

**Data**:
You will also need a test data set (**jsonl** files). We used a test data set of ~ 5GB in size.

## Steps

1. Logout from any currently active accounts

   ```shell
   az logout
   ```

2. Setup Python environment under `.venv`

   ```shell
   just install-deps
   ```

3. Start docker environment
  
   ```shell
   just start-dev-env
   ```

4. Upload test data into Azurite container (recommended: 5GB+)

   ```shell
   just setup-dev-env <path-to-test-dataset>
   ```

5. Run dlt pipeline

   ```shell
   just run-dlt
   ```

# Fix

Attention: this modifies the .venv directly and poetry is not able to track this change.
It is recommended to remove the .venv and re-install all dependencies once this section is done.

1. Patch dlt

   ```shell
   just patch-dlt
   ```

2. Run dlt pipeline again

   ```shell
   just run-dlt
   ```
