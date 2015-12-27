module Smartcols
  class Table
    def json()
      require 'json'
      return JSON.parse(self.__json())
    end
  end
  require 'smartcols/smartcols'
end
