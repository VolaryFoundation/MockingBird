require APP_ROOT + "/models/group"

module SC
  class AdminController < BaseController
    get "/" do
      @group_claims = Group.all(:user_id => nil, :pending_user_id.ne => nil)
      @groups_deleted = Group.where(:deleted => true)
      haml :"admin/index"
    end
  end
end
