Game.destroy_all
User.destroy_all

# create p1 test account for easy login
p1 = User.create!(email:"p1@test.com", password:"secret", password_confirmation:"secret")

5.times do
  random_user = User.create!(
    email:                 Faker::Internet.free_email,
    password:              "secret",
    password_confirmation: "secret"
  )
  
  # create five available games to join 
  Game.create!(white_player_id: random_user.id, black_player_id: nil, game_state:"pending")

  # create five games in progress
  inprogress_game = Game.create!(white_player_id: p1.id, black_player_id: random_user.id, game_state:"inprogress")
  inprogress_game.populate_board
end