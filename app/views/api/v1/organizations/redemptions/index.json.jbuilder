json.array! @redemptions do |redemption|
  json.partial! 'api/v1/redemptions/redemption.json.jbuilder', redemption: redemption
end
