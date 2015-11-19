DEFAUT=tests_attributs
#DEFAUT=tests_associations
#DEFAUT=tests_array
#DEFAUT=tests_valide
#DEFAUT=tests

# Cible par defaut.
default: $(DEFAUT)

# Les tests unitaires.
tests: tests_attributs tests_associations tests_array tests_valide

tests_attributs:
	ruby open_record_attributs_spec.rb

tests_associations:
	ruby open_record_associations_spec.rb

tests_array:
	ruby array_spec.rb

tests_valide:
	ruby valide_spec.rb

# Nettoyage du repertoire.
clean:
	rm -f *~
