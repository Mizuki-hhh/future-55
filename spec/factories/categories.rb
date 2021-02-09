FactoryBot.define do
  factory :category do
    name { "その他" }
    ancestry { nil }


    # factory :child_category do |f|
    #   f.parent create { :category }
    # end

  end
end
