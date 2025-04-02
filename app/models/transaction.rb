# frozen_string_literal: true

class Transaction < ApplicationRecord
  has_many :actions, inverse_of: :blockchain_transaction

  validates :time, :height, :block_hash,
            :sender, :receiver, :gas_burnt, presence: true

  validates :tx_hash, presence: true, uniqueness: true
  validates :external_id, presence: true, uniqueness: true

  accepts_nested_attributes_for :actions

  scope :transfers, -> { joins(:actions).where(actions: { action_type: 'Transfer' }) }
end
