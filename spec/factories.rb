FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
  
  factory :game do
  end
  
  factory :move do |f|
#     f.game_id "1"
#     f.piece_id "1"
#     f.rank "1"
#     f.file "1"
  end

  factory :piece do     
#    user
#    game
#    type     ["pawn","rook","knight","bishop","king","queen"].sample
#    rank     (1..8).to_a.sample
#    file     ('a'..'f').to_a.sample
  end
end
