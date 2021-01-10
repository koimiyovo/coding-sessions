class RoundUtil
  def self.round_nearest_to_005(num_to_round)
    (num_to_round * 20).round / 20.0
  end
end