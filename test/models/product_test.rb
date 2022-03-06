require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  def product_image_url(image_url)
    Product.new(
      title: "Testing Image",
      description: "Testing the image format file jpg|gif|png",
      price: 1,
      image_url: image_url
    )
  end

  test "product should be valid" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "price must be positive value" do
    product = Product.new(
                title: "Test Price",
                description: "Testing the price greater than 0.01",
                image_url: "7apps.jpg",
              )
    #invalidate price is negative value
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], 
                  product.errors[:price]
    # invalidate if price is 0
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                  product.errors[:price]
    # validate the price is greater than 0.01
    product.price = 0.01
    assert product.valid?
  end

  test "valid image url" do
    ok = %w{test.png test.gif test.jpg test.JPG
            https://a.b.c/x/y/z/test.gif}
    ok.each do |image|
      assert product_image_url(image).valid?, 
              "#{image} shouldn't be invalid"
    end
  end

  test "invalid image url" do
    bad = %w{ test.png/more test test.doc}
    bad.each do |image|
      assert product_image_url(image).invalid?, 
          "#{image} shouldn't be valid"
    end 
  end

  test "product is not valid without unique title" do
    product = Product.new(
                title: products(:ruby).title,
                description: "testing duplicate title",
                image_url: "7apps.jpg",
                price: 9.99
              )
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors["title"]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(
                title: products(:ruby).title,
                description: "testing duplicate title",
                image_url: "7apps.jpg",
                price: 9.99
              )
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors["title"]
  end
end
