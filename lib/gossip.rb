require 'csv'
class Gossip
	 attr_reader :author, :content

	 
	def initialize (author, content)
    @author = author
    @content = content
  end


	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
   	 	csv << [@author,  @content]
  	end
	end

	def self.all
	  all_gossips = []
	  CSV.read("./db/gossip.csv").each do |csv_line|
	    all_gossips << Gossip.new(csv_line[0], csv_line[1])
	  end
	  return all_gossips
	end

	def self.find (id)
		db_content = CSV.read("./db/gossip.csv")
		db_content[id]
	end

	def self.update(id, author, content) 
		# On va chercher le fichier CSV
		# On le stocke dans une variable sous forme d'array
		# il contient un array par ligne
		rows_array = CSV.read('./db/gossip.csv')
		#on parcourt l'array, each_with_index renvoie 
		#l'index de chaque ligne du CSV 
		rows_array.each_index do |index| 
			# si l'index correspond à l'index du potin à modifier
	  if  index == id.to_i
	    # on modifie la première colonne, correspondante à l'auteur
	    rows_array[index][0] = author
	    # on modifie la deuxième colonne, correspondante au contenu
	    rows_array[index][1] = content
	  end
	
		# On reprend la ligne de la version modifiée
		# On met à jour la ligne modifiée
		CSV.open("./db/gossip.csv", 'wb') do |csv| 
			rows_array.each do |row| 
				csv << row
			end
		end

		end

	end

	


end



