FactoryBot.define do
  factory :category do
    # id { 5 }
    name { "その他" }
    # name { "category" }
    ancestry { nil }


    # factory :child_category do |f|
    #   f.parent create { :category }
    # end

  end
end
