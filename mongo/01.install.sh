# Doc
## https://www.mongodb.com/ko-kr/docs/manual/tutorial/install-mongodb-on-os-x/

#xcode install 
xcode-select --install

# add repository to brew
brew tap mongodb/brew

# brew update
brew update

# brew install mongodb
brew install mongodb-community@7.0

# start mongod
brew services start mongodb-community@7.0

# stop mongod
brew services stop mongodb-community@7.0

# service check
mongod --config /usr/local/etc/mongod.conf --fork # intel

mongod --config /opt/homebrew/etc/mongod.conf --fork # silicon


brew services list

ps aux | grep -v grep | grep mongod

mongosh

