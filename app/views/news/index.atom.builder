atom_feed do |feed|
  feed.title "Osp Leśniewo"
  feed.updated @aktualnosci_atom.first.created_at
  @aktualnosci_atom.each do |aktualnosc|
    feed.entry aktualnosc do |entry|
      entry.title aktualnosc.tytul
      entry.content aktualnosc.tresc[0..200]+"...", :type => 'html'
      entry.author do |author|
        author.name "Miłosz Osiński"
      end
    end
  end
end
