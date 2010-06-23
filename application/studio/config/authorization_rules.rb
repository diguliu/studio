authorization do
  role :admin do
    # Generic actions
    has_permission_on [:people, :clients, :bands, :services, :equipments, :agendas, :equips],
      :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    # Specific actions
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
  end

  role :client do
    includes :guest
  end
end
