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
		#On crée un array vide pour stocker tous les potins
	  all_gossips = []
	  #On selectionne le fichier et on parcourt chaque ligne 
	  CSV.read("./db/gossip.csv").each do |csv_line|
	  #On stocke dans notre array chaque ligne et pour chacune
	  #les deux premières colonnes correspondantes à l'autheur 
	  #et au contenu du potin et on crée une instance de gossip avec
	    all_gossips << Gossip.new(csv_line[0], csv_line[1])
	  end
	  return all_gossips
	end

	def self.find (id)
		# On va chercher le fichier CSV
		# On le stocke dans une variable sous forme d'array
		# il contient un array par ligne
		db_content = CSV.read("./db/gossip.csv")
		# On selectionne le commentaire par son index qui va correspondre à l'id de la page
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



