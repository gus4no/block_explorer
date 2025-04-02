require "net/http"
require "uri"
require "json"

class TransactionUpdater
  API_URL = "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=#{Rails.application.credentials.secret_api_key}"

  def self.fetch_and_update
    new.fetch_and_update
  end

  def fetch_transactions
    uri = URI.parse(API_URL)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      Rails.logger.error "Failed to fetch transactions: #{response.message}"
      []
    end
  end

  def fetch_and_update
    json_transactions = fetch_transactions
    upsert_local_transactions(json_transactions)
  end

  private

  def upsert_local_transactions(transactions)
    transactions.map do |transaction_data|
      transaction = Transaction.find_or_initialize_by(external_id: transaction_data["id"])
      next if transaction.persisted?

      transaction.assign_attributes(
        {
          external_id: transaction_data["id"],
          external_created_at: transaction_data["created_at"],
          external_updated_at: transaction_data["updated_at"],
          time: transaction_data["time"],
          height: transaction_data["height"],
          tx_hash: transaction_data["hash"],
          block_hash: transaction_data["block_hash"],
          sender: transaction_data["sender"],
          receiver: transaction_data["receiver"],
          gas_burnt: transaction_data["gas_burnt"],
          success: transaction_data["success"],
          actions_attributes: transaction_actions_data(transaction_data["actions"])
        }
      )

      transaction.save!
      transaction
    end.compact
  end

  def transaction_actions_data(actions_data)
    actions_data.map do |action_data|
      {
        deposit: action_data["data"]["deposit"].to_i,
        action_type: action_data["type"],
        data: action_data["data"]
      }
    end
  end
end
