# README

This repo is in charge of fetching a list of transactions from an api and displaying them in a table.

## How to run the project

1. Clone the repo
2. Run `bundle install`
3. Run `bin/dev`

## How to run the tests

1. Run `rails rspec`

## How to run the project

The repo includes single root route that would display all the transfer transactions in table.

Just go to `http://localhost:3000/` and you will see the table with all the transactions.

# Notes and questions about the project

## Transaction primary key hash or id
Went with both to have the flexibility to find transactions using both.

## Actions count

Does this value ever change on the api, would I get the same transaction again with more actions, I'm  bit confused by actions_count is this being used as a counter cache? If so should we rely on rails for it? if these actions won't change I think we can use what the api returns but if actions ever change is better to use actions_count as  counter cache to keep integrity. For the sake of timing, I'll use whatever the api responds with, can be adjusted later if needed.

## API timestamps

API already responds with timestamps, I'm going to save those and our internal ones. Internal would be useful to debug when it was actually synced/updated in our system. The ones from the API I'm assuming are the actual dates the transaction was created which is also relevant.

## Store Tranfers only

Not sure if other types of transactions are relevant given we only want to show up transfers, should we store others? Or just filter by type in the UI. For now, I'll just save whatever comes from the api thinking other type of transactions may be relevant in other parts of the UI.

## Action data structure

Don't know much about the blockchain world, data for actions have different attributes depending on the action type. Not sure how much flexibility we want here to use things like jsonb vs dedicated columns to store these. Each of them have their pros and cons, but given we may need faster querying and indexing I'll go with dedicated columns for now or maybe a hybrid approach where commonly queried fields like 'deposit' are dedicated columns.

I worry that a single action model ends up with  bunch of different columns that are not needed for a specific action type, can also use different models for each action type. like TransferAction and FunctionCallAction and have each its own set of dedicated columns but that comes with added complexity.

## Upsert vs find_or_initialize

This is really were I lost  lot of time, I went initially with upsert because I wanted the updates to be fast but I ended up opening  can of worms because validations don't run there and I realized this later in the code. I have DB validations in place which would cut it, but didn't feel right as we may have other validations needed.

Also, upsert does not work with nested attributes so I had to upsert actions separately and for this I needed   hold of the transaction id. And well... upsert does not return the record itself but  result so in order to get the id, I think I had to find the transaction and didn't want to go deeper there and find more unknowns.

Ended up settling with find_or_intialize_by that is  bit more expensive as it needs to run a select and then based on the result do an insert where upsert does that in  single call.

I think theres potential to make this better but I'm already out of time.

## ActiveRecord.raise_int_wider_than_64bit = false ?

Not sure why setting up a decimal for deposit didn't work, didn't realize until I was testing via web and rails was complaining. This was not the case with the rspec testing so in order to save time I did what rails itself suggested of setting that config to false.

## Fetching transactions

While transactions are fetched in the controller, I wonder if these should be moved to some background job in the real world or some sort of listener to make sure we have the most up to date transactions to avoid the roundtrip of fetching them in the controller.
For the purpose of the test I assumed it was fine to fetch them in the controller.


# Nice to haves

- Tailwind styling
- More tests for more scenarios and edge cases
- Fetching transactions in the background maybe?