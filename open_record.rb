require_relative 'dbc'

class OpenRecord
  #
  # Cree un objet avec les attributs indiques et, si un bloc est
  # specifie, avec les associations indiquees.
  #
  def initialize( attributs = Hash.new, &block )
    self
  end

  #
  # Definit le setter/getter lors d'une premiere affectation.
  #
  def method_missing( id, *args )
    #puts(id)
    if id.to_s =~ /=$/
    then
      tmp = id.to_s.chop
      definir_reader_et_writer(tmp.to_sym)
    else  
      raise NoMethodError, id.to_s
    end
      #puts(id)
  end

  #
  # Ajoute les deux methodes (getter et setter) pour un attribut ou
  # une association.
  #
  def definir_reader_et_writer( id )
    DBC.require( id.class == Symbol,
                 "*** Les attributs ou associations doivent etre definis via des symboles: id = #{id}" )
    define_singleton_method id do
      instance_eval "@#{id}"
    end
    
    define_singleton_method "#{id}=" do |v|
      instance_eval "@#{id} = #{v}"
    end
  end
  private :definir_reader_et_writer


  #
  # Ajout d'une association unique.
  #
  def a_une( klass, arg = nil )
    DBC.require( klass.class == Class,
                 "*** L'argument a a_une doit etre une classe:
                      klas = #{klass} (.class = #{klass.class}) " )


    self
  end

  alias :a_un :a_une

  #
  # Ajout d'une association multiple.
  #
  def a_plusieurs( klass, *args )
    DBC.require( klass.class == Class,
                 "*** L'argument a a_plusieurs doit etre une classe:
                      klass = #{klass} (.class = #{klass.class}) " )


    self
  end

  alias :a_un_ou_plusieurs :a_plusieurs

  #
  # Est-ce que toutes les associations sont definies correctement?
  #
  def valide?
    nil
  end

  #
  # Retourne le nom d'une association qui n'est pas definie
  # correctement, s'il en existe une, sinon nil.
  #
  # Utile pour le debogage, pour comprendre pourquoi un objet n'est
  # pas valide?.
  #
  def association_invalide
    nil
  end

end
