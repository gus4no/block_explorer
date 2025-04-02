require "rails_helper"

RSpec.describe TransactionUpdater do
  describe '.fetch_and_update' do
    let(:api_url) { "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=#{Rails.application.credentials.secret_api_key}" }
    let(:mock_transactions) do
      [
        {
          "id": 208851,
          "created_at": "2021-01-11T10:20:13.70879-06:00",
          "updated_at": "2021-01-11T10:20:13.70879-06:00",
          "time": "2021-01-11T10:20:04.132926-06:00",
          "height": 27326763,
          "hash": "6RtU9UkAQaJBVMrgvtDiARxzbhx1vKrwoTv4aZRxxgt7",
          "block_hash": "FrWmh1BtBc8yvAZPJrJ97nVth6eryukbLANyFQ3TuQai",
          "sender": "86e6ebcc723106eee951c344825b91a80b46f42ff8b1f4bd366f2ac72fab99d1",
          "receiver": "d73888a2619c7761735f23c798536145dfa87f9306b5f21275eb4b1a7ba971b9",
          "gas_burnt": "424555062500",
          "actions": [
            {
              "data": {
                "deposit": "716669915088987500000000000"
              },
              "type": "Transfer"
            }
          ],
          "actions_count": 1,
          "success": true
        },
        {
          "id": 1321321,
          "created_at": "2025-04-01T12:00:00Z",
          "updated_at": "2025-04-01T12:30:00Z",
          "time": "2025-04-01T12:00:00Z",
          "height": 100,
          "hash": "hash_123",
          "block_hash": "block_hash_123",
          "sender": "sender_address",
          "receiver": "receiver_address",
          "gas_burnt": 500,
          "success": true,
          "actions": [
            {
              "type": "transfer",
              "data": { "deposit": 100 }
            }
          ]
        }
      ].as_json
    end

    before do
      allow_any_instance_of(TransactionUpdater).to receive(:fetch_transactions).and_return(mock_transactions)
    end

    it 'fetches the transactions from the API and updates local records' do
      TransactionUpdater.fetch_and_update
      transaction = Transaction.first
      expect(transaction.external_id).to eq 208851
    end

    it "does not create another already existing transaction" do
      TransactionUpdater.fetch_and_update
      TransactionUpdater.fetch_and_update
      expect(Transaction.count).to eq 2
    end

    it "sets up action attributes" do
      TransactionUpdater.fetch_and_update
      transaction = Transaction.first
      action = transaction.actions.first
      expect(action.deposit).to eq 716669915088987500000000000
    end
  end
end
