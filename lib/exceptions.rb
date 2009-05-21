module Exceptions
  class CartException < RuntimeError
    attr :msg
    def initialize(msg)
      @msg = msg
    end
  end
end
