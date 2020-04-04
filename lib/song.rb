class Song

	attr_accessor :title, :artist, :tunefind_id, :episode_id, :season, :episode_num, :id

	@@all = []

	# def initialize(attrs)
	# 	attrs.each do |k, v|
	# 		self.send("#{k}=", v)
	# 	end
	# 	# save
	# 	insert
	# end

	def self.all1
		@@all
	end

	def save
		self.class.all1 << self
	end

	def self.all
		sql = <<-SQL
			SELECT * FROM songs
		SQL
		rows = DB[:conn].execute(sql)
		self.new_from_rows(rows)
	end

	def self.new_from_rows(rows)
		rows.collect do |row|
			self.new_from_db(row)
		end
	end

	def self.new_from_db(row)
		self.new.tap do |song|
			song.id = row[0]
			song.artist = row[1]
			song.title = row[2]
			song.season = row[3]
			song.episode_id = row[4]
			song.episode_num = row[5]
			song.tunefind_id = row[6]
		end
	end

	def self.reset
		self.all.clear
	end

	def self.create_table
		sql = <<-SQL
			CREATE TABLE IF NOT EXISTS songs (
				id INTEGER PRIMARY KEY,
				artist TEXT,
				title TEXT,
				season INTEGER,
				episode_id INTEGER,
				episode_num INTEGER,
				tunefind_id INTEGER
			)
		SQL
		DB[:conn].execute(sql)
	end

	def self.drop_table
		DB[:conn].execute("DROP TABLE songs")
	end

	def insert
		sql = <<-SQL
			INSERT INTO songs (artist, title, season, episode_id, episode_num, tunefind_id)
			VALUES (?, ?, ?, ?, ?, ?)
		SQL
		DB[:conn].execute(sql, self.artist, self.title, self.season, self.episode_id, self.episode_num, self.tunefind_id)
		@id = DB[:conn].execute("SELECT last_insert_rowid() from songs")[0][0]
	end


end