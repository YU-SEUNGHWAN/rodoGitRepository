package project2.scmaster.rodo.util;


import java.io.File;
import java.util.ArrayList;

import javax.xml.parsers.*;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import project2.scmaster.rodo.vo.GPX;

public class Parsing {

	private final String GPX_FILE_PATH = "D:\\test.gpx";

	
	public ArrayList<GPX> GpxParse(){
		
		ArrayList<GPX> gpxList= new ArrayList();

		File xmlFile = new File(GPX_FILE_PATH);

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

		System.out.printf("Root element : %s\n", doc.getDocumentElement().getNodeName());
		NodeList itemNodeList = doc.getElementsByTagName("trkseg");

		for (int s = 0; s < itemNodeList.getLength(); s++) {

			Node itemNode = itemNodeList.item(s);

			if (itemNode.getNodeType() == Node.ELEMENT_NODE) {

				Element itemElement = (Element) itemNode;
				NodeList trkptNodeList = itemElement.getElementsByTagName("trkpt");
				NodeList eleNodeList = itemElement.getElementsByTagName("ele");
				NodeList timeNodeList = itemElement.getElementsByTagName("time");

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
					
					GPX gpx = new GPX(lat, lon, ele, time);
					gpxList.add(gpx);
				}
			}
		}
		return gpxList;
	}
}
