JSONArray values; //<>//
JSONObject fiche;
PImage[] trombinoscope;
Boolean ok = true;
String[] listePhotos = new String [1];
String[] listeDesNoms = new String [1];
String url = "http://www2.assemblee-nationale.fr/static/tribun/14/photos/";


void setup() {
  size(150, 193);
  background(255);
  values = loadJSONArray("2014_reserve.json");
  String idEnCours = "rien";

  for (int i = 0; i < values.size(); i++) {
    fiche = values.getJSONObject(i);
    String idDepute = fiche.getString("ID_Acteur");
    String nomDepute = fiche.getString("Nom");
    nomDepute = nomDepute + "_" + fiche.getString("Prénom");
    
    if (idDepute.equals(idEnCours) == false ) {
      if (idDepute.equals("NULL") == false ) {
        String idPhotoDepute = idDepute.substring(2, idDepute.length())+".jpg";

        listePhotos = append(listePhotos, idPhotoDepute);
        listeDesNoms = append(listeDesNoms, nomDepute);
      }
      idEnCours = idDepute;
    }
  }
  //printArray(listePhotos);

  trombinoscope = new PImage[listePhotos.length-1];

  for (int k=0; k < trombinoscope.length; k++) {

    trombinoscope[k]=loadImage(url+listePhotos[k+1]);
    println("image " + listePhotos[k+1] + " "+listeDesNoms[k+1]);
  }
}

void draw() {
  frameRate(1);
  if (ok) {
    for (int i=0; i < trombinoscope.length; i++) {

      image(trombinoscope[i], 0, 0);
      redraw();
      //save(listePhotos[i+1]);
      save(listePhotos[i+1]+" "+listeDesNoms[i+1]+".jpg");
      //save(listeDesNoms[i+1]+" "+listePhotos[i+1]);
    }
    ok = false;
    println("trombinoscope: "+ trombinoscope.length);
    println("listePhotos: "+listePhotos.length);
  }
}