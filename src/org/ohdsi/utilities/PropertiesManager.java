/*******************************************************************************
 * Copyright 2017 Observational Health Data Sciences and Informatics
 * 
 * This file is part of JCDMBuilder
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
package org.ohdsi.utilities;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Properties;

/**
 * This class contains all the methods necessary to manipulate the properties file of the application.
 * 
 *
 */
public class PropertiesManager {

	//the application properties
	public  HashMap<String, String> listProperties;
	
	private Properties properties = new Properties();
	private String settingsFileName;

	/**
	 * Basic constructor.
	 */
	public PropertiesManager() {
		listProperties = new HashMap<String, String>();
	}
	
	//GETTERS AND SETTERS

	public String get(String property){
		return  properties.getProperty(property);
	}

	/**
	 * Set an existing property in the properties file.
	 * @param key - the name of the property to be updated
	 * @param value - the new value of the property
	 */
	public void set(String key, String value){
		properties.put(key, value);
	}

	public void load(String fileName){
		try {
			settingsFileName = fileName;
			File file = new File(fileName);
			FileInputStream fileInput = new FileInputStream(file);
			properties.load(fileInput);
			fileInput.close();
		}catch (IOException e) {
			System.out.println("Unable to read properties file." +
					"\nCheck if the file exists or is not in use.");
		}
	}	
	public void save(String fileName){
		try {
			settingsFileName = fileName;
			File file = new File(settingsFileName);
			OutputStream fileOut = new FileOutputStream(file);
			properties.store(fileOut, "JCDMBuilder settings");
			fileOut.close();
		}catch (IOException e) {
			System.out.println("Unable to update properties file." +
					"\nCheck if the file exists or is not in use.");
		}
	}
	
	public String getSettingFileName(){
		return settingsFileName;
	}
	
}