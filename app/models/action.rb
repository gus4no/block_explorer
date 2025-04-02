# frozen_string_literal: true

class Action < ApplicationRecord
  belongs_to :transaction

  enum action_type: { transfer: "Transfer", function_call: "FunctionCall" }

  scope :transfers, -> { where(action_type: "Transfer") }

  validates :action_type, presence: true
  validates :deposit, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end