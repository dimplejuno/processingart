import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

import org.jsoup.*;
import org.jsoup.nodes.*;
import org.jsoup.select.*;

int index = 0;
PImage currentImage = null;
ArrayList<String> urls = new ArrayList<String>();

boolean isStarted = false;
long startedTime = 0;

void setup() {
  //size(1920, 1038);
  size(960, 519);
  
  
  try {
    Document doc = Jsoup.connect("http://www.ghibli.jp/info/013344/").get();
    println(doc.title());
    
    
    Elements items = doc.select(".panelarea");  // .class
    
    for (Element item : items) {
      // println(item.attr("title"), item.attr("href"));
      Document page = Jsoup.connect(item.attr("href")).get();
      Elements imgs = page.select(".panelarea");  // .class
        for (Element img : imgs) {
          println(img.attr("href"), img.attr("title"));
          urls.add(img.attr("href"));
      }
    }
    
  } catch (Exception e) {
    
  }
  imageMode(CENTER);
}


void draw(){
  background(0);
  
  if(currentImage == null && isStarted == false){
    currentImage = loadImage(urls.get(index));
    println("loadImage : " + urls.get(index));
    currentImage.resize(currentImage.width/2, currentImage.height/2);
  }
  
  if(currentImage != null && isStarted == false){
      isStarted = true;
      startedTime = millis();
  }
  
  if(currentImage != null){
    image(currentImage, width/2, height/2);
  }


  if(millis() - startedTime > 1000){
    String name = urls.get(index);
    String splited[] = name.split("/");
    String fileName = splited[splited.length-1];
    String folderName = fileName.substring(0, fileName.length()-7);
    save(folderName + "/" + splited[splited.length-1] );
    index++;
    if(index >= urls.size()) { noLoop(); index = 0; }
    currentImage = null;
    isStarted = false;
    startedTime = millis();
  }
  
}
