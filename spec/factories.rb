FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :game do
    association :white_player, factory: :user
    association :black_player, factory: :user
  end

  factory :move do |f|
    f.game_id 1
    f.piece_id 1
    f.rank 1
    f.file 1
    association :piece
  end

  factory :piece do
    sequence :id do |n|
      n
    end

    type "Pawn"
    rank 4
    file 4
    association :user, strategy: :build  ## To not save the associated object
    association :game, strategy: :build
  end

  factory :king, parent: :piece, class: King do
    type "King"
  end

  factory :pawn, parent: :piece, class: Pawn do
    type "Pawn"
  end

  factory :queen, parent: :piece, class: Queen do
    type "Queen"
  end

  factory :bishop, parent: :piece, class: Bishop do
    type "Bishop"
  end

  factory :rook, parent: :piece, class: Rook do
    type "Rook"
  end

  factory :knight, parent: :piece, class: Knight do
    type "Knight"
  end
end
