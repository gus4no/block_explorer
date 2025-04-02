# frozen_string_literal: true

class TransactionsController < ApplicationController
  def index
    TransactionUpdater.fetch_and_update
    @transactions = Transaction.transfer
  end
end
