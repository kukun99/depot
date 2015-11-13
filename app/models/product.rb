class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: {
    message: 'に値が入力されていません'
  }
  validates :price, numericality: {
    greater_than_or_equal_to: 0.01,
    message: 'は0.01以上の値を入力してください'
  }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'はGIF、JPG、PNG画像のURLでなければなりません'
  }
  validates :title, allow_blank: true, length: {
    minimum: 10,
    message: 'は%{count}文字以上で入力してください'
  }

  private

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, '品目が存在します')
        return false
      end
    end
end
