class OrgAdmin < User
  belongs_to :organization

  def name
    "Organization Admin"
  end
end
