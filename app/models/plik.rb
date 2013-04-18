class Plik < ActiveRecord::Base
  # attr_accessible :title, :body
   validates :opis, length: { in: 3..20 }, allow_blank: false
end
