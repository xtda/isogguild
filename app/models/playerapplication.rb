class Playerapplication < ApplicationRecord
  attr_accessor :links_warcraftlogs

  def links_warcraftlogs
    link_warcraftlogs.split(' ')
  end

  def links_wowprogress
    link_wowprogress.split(' ')
  end
end
