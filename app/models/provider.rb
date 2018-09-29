class Provider < User
  has_many :redeemables, dependent: :destroy

  def redemptions
    redeemables_ids = redeemables.map(&:id)
    Redemption.where(redeemable_id: redeemables_ids)
  end
end
