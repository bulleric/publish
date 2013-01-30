require File.expand_path("../../../../test_helper", __FILE__)

class CallbacksTest < ActiveSupport::TestCase

  setup do
    @klass = Product
    @product  = FactoryGirl.build(:product)
  end

  test "should includes the before_publish callback" do
    assert @klass.respond_to?(:before_publish)
  end

  test "should includes the after_publish callback" do
    assert @klass.respond_to?(:after_publish)
  end

  test "should not execute callbacks publish callbacks if not call publish!" do
    assert_nil @product.before_publish_called
    assert_nil @product.after_publish_called
  end

  test "should execute the before_publish and after_publish callbacks" do
    @product.publish!

    assert @product.before_publish_called
    assert @product.after_publish_called
  end


  setup do
    @published_product = FactoryGirl.build(:product)
    @published_product.publish!
  end



  test "should includes the before_unpublish callback" do
    assert @klass.respond_to?(:before_unpublish)
  end

  test "should includes the after_unpublish callback" do
    assert @klass.respond_to?(:after_unpublish)
  end

  test "should not execute callbacks unpublish callbacks if not call unpublish!" do
    assert_nil @published_product.before_unpublish_called
    assert_nil @published_product.after_unpublish_called
  end

  test "should execute the before_unpublish and after_unpublish callbacks" do
    @published_product.unpublish!
    @published_product.reload

    assert @published_product.before_unpublish_called
    assert @published_product.after_unpublish_called
  end
end
