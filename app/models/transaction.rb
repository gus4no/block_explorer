# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :time, :height, :block_hash,
            :sender, :receiver, :gas_burnt, presence: true

  validates :hash, presence: true, uniqueness: true
  validates :external_id, presence: true, uniqueness: true

  validates :hash, presence: true, uniqueness: true
  validates :block_hash, presence: true
end
