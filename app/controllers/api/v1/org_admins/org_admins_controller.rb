class Api::V1::OrgAdmins::OrgAdminsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_org_admin

  def show
  end

  private

  def set_org_admin
    @org_admin = OrgAdmin.find(params[:id])
  end
end
