class Api::V1::OrgAdmins::OrganizationController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_org_admin

  def index
    @organization = @org_admin.organization
  end

  private

  def set_org_admin
    @org_admin = OrgAdmin.find(params[:org_admin_id])
  end
end
