json.array! @redemptions do |redemption|
  json.partial! 'redemption.json.jbuilder', redemption: redemption
end
