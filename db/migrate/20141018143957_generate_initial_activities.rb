class GenerateInitialActivities < ActiveRecord::Migration
  def change
  	Activity.create :name => 'Work', :description => "You are actually doing some real work that matters to you", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Learn', :description => "You are studying / training / learning", creator_id: nil, is_public: true, is_live: true
   	Activity.create :name => 'Help', :description => "You are helping someone else", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Distraction', :description => "You are checking out Facebook, Buzzfeed or generally procrastinating", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Drink', :description => "You are getting a coffee, tea or water", creator_id: nil, is_public: true, is_live: true
 	Activity.create :name => 'Smoke', :description => "You are going out for a smoke", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Eat', :description => "It's breakfast, lunch or dinner time - or just a snack", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Exercise', :description => "You are working out", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Socialise', :description => "You are chatting with people or going out with friends", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Relax', :description => "You are watching a movie, reading a book, or plain doing nothing", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Travel', :description => "You are on the move from A to B", creator_id: nil, is_public: true, is_live: true
  	Activity.create :name => 'Sleep', :description => "Sweet dreams young prince/princess", creator_id: nil, is_public: true, is_live: true
  end
end
