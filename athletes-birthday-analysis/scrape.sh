#!/bin/zsh

ruby scrape2.rb data_soccer_player.txt > output/soccer_player_birthday.txt
ruby scrape2.rb data_baseball_player.txt > output/baseball_player_birthday.txt
ruby scrape2.rb data_basketball_player.txt > output/basketball_player_birthday.txt