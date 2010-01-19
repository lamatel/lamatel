module Spree
  module ActiveShipping
    # Bogus calcualtor for testing purposes.  Uses the common functionality of ActiveShippingCalcualtor but 
    # doesn't actually use a real carrier to obtain rates.
    class BogusCalculator < ActiveShippingCalculator  
      def carrier
        Spree::ActiveShipping::BogusCarrier
      end
    end
  end
end