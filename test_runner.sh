set -ex

dfx identity new test_candy || true
dfx identity use test_candy

ADMIN_PRINCIPAL=$(dfx identity get-principal)
ADMIN_ACCOUNTID=$(dfx ledger account-id)

echo $ADMIN_PRINCIPAL
echo $ADMIN_ACCOUNTID

dfx canister create --all
dfx build --all
dfx canister install test_runner --mode=reinstall
echo "yes"

TEST_RUNNER_ID=$(dfx canister id test_runner)

echo $TEST_RUNNER_ID

dfx canister call test_runner test

