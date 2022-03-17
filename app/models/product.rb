class Product < ApplicationRecord
  
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item #custom validation

  validates :title, :description, :image_url, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 10 }
  validates :image_url, allow_blank: true,
            format: { 
                with: %r{\.(jpg|gif|png)\z}i,
                message: "must be a URL for GIF, JPG or PNG image."
            }
  
  private

    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "Line item present") #error object directly refereing to base obj, it can refer individual attributes
        throw :abort
      end
    end
  
end
