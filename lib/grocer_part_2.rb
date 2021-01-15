require_relative './part_1_solution.rb'
require "pry"

def find_item_by_name_in_collection(name, collection)
  index = 0

  collection.each do |grocery_item|
    return grocery_item if grocery_item[:item] === name 
    index += 1
  end

  nil
end


def consolidate_cart(cart)
  index = 0
  new_cart = []
  
  cart.each do |grocery_item|
    current_item = find_item_by_name_in_collection(grocery_item[:item], new_cart)
    if current_item
      new_cart_index = 0
      new_cart.each do |new_cart_item|
        if new_cart_item[:item] === current_item[:item]
          new_cart_item[:count] += 1
        end
        new_cart_index += 1
      end
    else
      grocery_item[:count] = 1
      new_cart << grocery_item
    end
    index += 1
  end
  new_cart
end

def apply_coupons(cart, coupons)

updated_cart = []
  
  i = 0
  
  while i < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart) # => find_item_by_name_in_collection("AVOCADO", cart)
    coupon_applied_name = "#{coupons[i][:item]} W/ COUPON" # => "AVOCADO W/ COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_applied_name, cart)
        binding.pry
 
    if cart_item != nil && cart_item[:count] >= coupons[i][:num]
      
      if cart_item_with_coupon != nil
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_applied_name,
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[i][:num]
        }
        
        cart << cart_item_with_coupon
        cart_item[i][:count] -= coupons[i][:num]
        cart << cart_item
      end
    end
    i += 1
  end
 cart
end
    

def apply_clearance(cart)
  i = 0
  while i < cart.length
  
    if cart[i][:clearance] == true
      cart[i][:price] = (cart[i][:price - (cart[i][:price] * 0.2)).round(2)
    end
    i += 1
  end
  return cart
end

def checkout(cart, coupons)
  
  consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total = 0
  
  i = 0
  while i < cart.length
   total += cart[i][:price]
   
   if total > 100
     total = (total - (total * 0.1)).round(2)
   end
   i += 1
  end
  
  total
end
