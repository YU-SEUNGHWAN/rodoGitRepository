package project2.scmaster.rodo.util;


import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.xml.parsers.*;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import project2.scmaster.rodo.vo.GPX;

public class Parsing {
	
	public ArrayList<GPX> GpxParse(String gpx_file_path){
		
		System.out.println(gpx_file_path);
		
		ArrayList<GPX> gpxList= new ArrayList();

		File xmlFile = new File(gpx_file_path);

		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = null;
		Document doc = null;
	
		try{
			db = dbf.newDocumentBuilder();
			doc = db.parse(xmlFile);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		doc.getDocumentElement().normalize();

		NodeList itemNodeList = doc.getElementsByTagName("trkseg");

		for (int s = 0; s < itemNodeList.getLength(); s++) {

			Node itemNode = itemNodeList.item(s);

			if (itemNode.getNodeType() == Node.ELEMENT_NODE) {

				Element itemElement = (Element) itemNode;
				NodeList trkptNodeList = itemElement.getElementsByTagName("trkpt");
				NodeList eleNodeList = itemElement.getElementsByTagName("ele");
				NodeList timeNodeList = itemElement.getElementsByTagName("time");
				NodeList speedNodeList = itemElement.getElementsByTagName("gpx10:speed");
				
				for (int i = 0; i < eleNodeList.getLength(); i+=3) {
				
					Node trkptElement = trkptNodeList.item(i);
					String lat = trkptElement.getAttributes().getNamedItem("lat").getNodeValue();
					String lon = trkptElement.getAttributes().getNamedItem("lon").getNodeValue();

					Node eleElement = eleNodeList.item(i);
					NodeList childEleNodeList = eleElement.getChildNodes();
					String ele = childEleNodeList.item(0).getNodeValue();
					
					Node timeElement = timeNodeList.item(i);
					NodeList chilTimeNodeList = timeElement.getChildNodes();
					String time = chilTimeNodeList.item(0).getNodeValue();
					String d = time.substring(0, 10);
					String t = time.substring(11, 19);
					time = d+" "+t;

					SimpleDateFormat transForm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date date = null;
					try {
						date = transForm.parse(time);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					
					Node speedElement = speedNodeList.item(i);
					String speed=null;
					if(speedElement != null){
						NodeList chilSpeedNodeList = speedElement.getChildNodes();
						speed = chilSpeedNodeList.item(0).getNodeValue();
					}else{
						speed="0";
					}
					
					GPX gpx = new GPX(lat, lon, ele, date, speed);
					gpxList.add(gpx);
				}
			}
		}
		return gpxList;
	}
}