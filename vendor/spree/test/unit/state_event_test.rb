require 'test_helper'

class StateEventTest < ActiveSupport::TestCase
  context "Order" do
    setup do
      @order = Factory(:order)
    end

    context "when completed" do
      setup { @order.complete! }
      should_change("StateEvent.count", :by => 1) { StateEvent.count }
      should_change("@order.state", :from => "in_progress", :to => "new") { @order.state }

      context "then canceled" do
        setup { @order.cancel! }
        should_change("StateEvent.count", :by => 1) { StateEvent.count }
        should_change("@order.state", :from => "new", :to => "canceled") { @order.state }

        should "allow resuming" do
          assert @order.can_resume?, "Order can't be resumed(and it should!)"
        end

        context "then resumed" do
          setup { @order.resume! }

          should_change("StateEvent.count", :by => 1) { StateEvent.count }
          should_change("@order.state", :from => "canceled", :to => "new") { @order.state }
        end
      end

      context "then paid" do
        setup do
          Payment.create!({:amount => @order.total, :order => @order})
        end

        should_change("@order.state", :from => "new", :to => "paid") { @order.state }
      end
    end
  end
end
