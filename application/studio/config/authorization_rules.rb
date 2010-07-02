authorization do
  role :admin do
    includes :guest
    has_permission_on [:people, :clients, :bands, :services, :equipments, :agendas, :equips, :external_rents],
      :to => [:index, :show, :new, :edit, :create, :update, :destroy]

    has_permission_on :bands, :to => [:add_member, :remove_member] 
    has_permission_on :agendas, :to => [:add_equip, :remove_equip, :cancel] 
    has_permission_on :equips, :to => :import_equips
  end

  role :guest do
    has_permission_on [:clients, :bands, :services, :equipments, :agendas, :equips],
      :to => [:index, :show]
    has_permission_on :people, :to => :show
    has_permission_on :equips, :to => :export_equips
    has_permission_on [:bands, :clients], :to => [:new, :create]
  end

  role :band do
    includes :guest

    has_permission_on :people, :to => [:new, :create] 
    
    has_permission_on :people, :to => [:edit, :update, :destroy] do
      if_attribute :bands => contains { user }
    end

    has_permission_on :bands, :to => [:edit, :update, :add_member, :remove_member] do
      if_attribute :login => is { user.login }
    end

    has_permission_on :agendas, :to => [:new, :create]

    has_permission_on :agendas, :to => [:add_equip, :remove_equip, :cancel] do
      if_attribute :band => is { user }
    end

    has_permission_on :agendas, :to => [:edit, :update] do
      if_attribute :band => is { user }, :status => "reserved"
    end
  end

  role :client do
    includes :guest

    has_permission_on :clients, :to => [:edit, :update] do
      if_attribute :login => is { user.login }
    end

    has_permission_on :external_rents, :to => [:new, :create]

    has_permission_on :external_rents, :to => :show do
      if_attribute :client => is { user }
    end

    has_permission_on :external_rents, :to => :cancel do
      if_attribute :client => is { user }, :status => "reserved"
    end
  end
end
