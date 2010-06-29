authorization do
  role :admin do
    has_permission_on [:people, :clients, :bands, :services, :equipments, :agendas, :equips],
      :to => [:index, :show, :new, :edit, :create, :update, :destroy]

    has_permission_on :clients, :to => [:show_rent, :new_rent, :create_rent, :cancel_rent] 
    has_permission_on :bands, :to => [:add_member, :remove_member] 
    has_permission_on :agendas, :to => [:add_equip, :remove_equip, :cancel] 
  end

  role :guest do
    has_permission_on [:people, :clients, :bands, :services, :equipments, :agendas, :equips],
      :to => [:index, :show]
  end

  role :band do
    includes :guest
    has_permission_on :bands, :to => [:edit, :update, :destroy, :add_member, :remove_member] do
      if_attribute :login => is {user.login}
    end
    has_permission_on :agendas, :to => [:new, :create]
    has_permission_on :agendas, :to => [:add_equip, :remove_equip, :cancel] do
      if_attribute :band => is {user}
    end
    has_permission_on :agendas, :to => [:edit, :update] do
      if_attribute :band => is {user}, :status => "reserved"
    end
  end

  role :client do
    includes :guest
  end
end
