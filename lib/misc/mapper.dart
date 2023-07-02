/*
Qui creeremo la classe ASTRATTA DTOMapper
che useremo come base per definire i futuri mapper 
per trasformare i dati da DTO a classi di tipo model e viceversa


questa classe ha 2 parametri di tipo geneico:
- il primo parametro "D" è un oggetto di tipo DTO, il POJO essenzialmente
- il secondo parametro sarà l'oggetto target di destinazione. Dato che questo oggetto è di tipo model
utilizzaimo la "M" come nome della variabile

All'interno di questa classe astratta definiamo 2 metodi:
- il primo per trasformare oggetti da DTO a Model
- il secondo per trasformare oggetti da Model a DTO
*/

abstract class DTOMapper<D, M> {
  M toModel(D dto); // il metodo "toModel" prende in input un "dto" di tipo D e lo trasforma in un oggetto model di tipo M

  D toTransferObject(M model);
}
