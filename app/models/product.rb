class Product < ApplicationRecord
  
  def get_product_iamge
    (product_image.attached?) ? product_image : "sample.png"
  end
end
