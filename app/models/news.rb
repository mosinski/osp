class News < ActiveRecord::Base
  attr_accessible :tresc, :tytul, :rodzaj, :termin

  def self.search(search, page)
    paginate :per_page => 6, :page => page,
      :conditions => ['tytul ILIKE :q or tresc ILIKE :q', q: "%#{search}%"], :order => 'termin'
  end
end
