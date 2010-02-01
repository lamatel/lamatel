module LamatelHelper
  
  def lamatel_product_description product
    description = (product.description.length > 50)? product.description[0..50] + "..." : product.description unless product.description.nil?
  end
  
end