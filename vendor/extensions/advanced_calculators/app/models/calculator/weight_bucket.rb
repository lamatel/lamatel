class Calculator::WeightBucket < Calculator::Advanced
  preference :default_weight, :decimal, :default => 0

  def self.description
    I18n.t("weight_bucket", :scope => :calculator_names)
  end

  def self.unit
    I18n.t('weight_unit')
  end

  # as order_or_line_items we always get line items, as calculable we have Coupon, ShippingMethod or ShippingRate
  def compute(order_or_line_items)
    line_items = order_or_line_items.is_a?(Order) ? order_or_line_items.line_items : order_or_line_items
    
    total_weight = line_items.map{|li|
        (li.variant.weight || self.preferred_default_weight) * li.quantity
      }.sum

    get_rate(total_weight) || self.preferred_default_amount
  end
end
