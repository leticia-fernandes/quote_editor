class Quote < ApplicationRecord
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

  validates :name, presence: true

  belongs_to :company
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  scope :ordered, -> { order(id: :desc) }

  def total_price
    line_items.sum(&:total_price)
  end
end
