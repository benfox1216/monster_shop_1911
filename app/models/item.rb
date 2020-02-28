class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, greater_than_or_equal_to: 0


  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.most_popular
    self.where(active?: true).order(purchased: :desc)
  end

  def self.least_popular
    self.where(active?: true).order(:purchased)
  end

  def item_order(order_id)
    item_orders.find_by(order_id: order_id, item_id: id)
  end

  def activate
    write_attribute(:active?, true)
  end

  def deactivate
    write_attribute(:active?, false)
  end

end
