/*******************************************************************************
 * Copyright 2017 Observational Health Data Sciences and Informatics
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
package org.ohdsi.jCdmBuilder;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import org.ohdsi.databases.DbType;
import org.ohdsi.databases.RichConnection;
import org.ohdsi.jCdmBuilder.cdm.Cdm;
import org.ohdsi.jCdmBuilder.cdm.EraBuilder;
import org.ohdsi.jCdmBuilder.etls.ars.ARSETL;
import org.ohdsi.jCdmBuilder.etls.cdm.CdmEtl;
import org.ohdsi.jCdmBuilder.etls.hcup.HCUPETL;
import org.ohdsi.jCdmBuilder.etls.hcup.HCUPETLToV5;
import org.ohdsi.jCdmBuilder.vocabulary.CopyVocabularyFromSchema;
import org.ohdsi.jCdmBuilder.vocabulary.InsertVocabularyInServer;
import org.ohdsi.utilities.PropertiesManager;
import org.ohdsi.utilities.StringUtilities;

public class JCdmBuilderMain {
	private static String		SOURCEFOLDER					= "source folder";
	private static String		SOURCEDATABASE					= "source database";
	private static String		VOCABFOLDER						= "vocab folder";
	private static String		VOCABSCHEMA						= "vocab schema";
	private JFrame				frame;
	private JTabbedPane			tabbedPane;
	private JTextField			folderField;
	private JTextField			vocabFileField;
	private JTextField			vocabSchemaField;
	private JRadioButton		vocabFileTypeButton;
	private JRadioButton		vocabSchemaTypeButton;
	private JPanel				vocabCards;
	private JCheckBox			executeStructureCheckBox;
	private JCheckBox			executeVocabCheckBox;
	private JCheckBox			executeETLCheckBox;
	private JCheckBox			executeConditionErasCheckBox;
	private JCheckBox			executeDrugErasCheckBox;
	private JCheckBox			executeIndicesCheckBox;
	private JComboBox<String>	etlType;
	private JComboBox<String>	sourceType;
	private JComboBox<String>	targetType;
	private JTextField			versionIdField;
	private JTextField			targetUserField;
	private JTextField			targetPasswordField;
	private JTextField			targetServerField;
	private JTextField			targetDatabaseField;
	private JComboBox<String>	targetCdmVersion;
	private JTextField			sourceDelimiterField;
	private JTextField			sourceFolderField;
	private JTextField			sourceServerField;
	private JTextField			sourceUserField;
	private JTextField			sourcePasswordField;
	private JTextField			sourceDatabaseField;
	private JPanel				sourceCards;
	private boolean				executeCdmStructureWhenReady	= false;
	private boolean				executeVocabWhenReady			= false;
	private boolean				executeEtlWhenReady				= false;
	private boolean				executeDrugErasWhenReady		= false;
	private boolean				executeConditionErasWhenReady	= false;
	private boolean				executeIndicesWhenReady			= false;
	private boolean				idsToBigInt						= false;
	private PropertiesManager	propertiesManager				= new PropertiesManager();
	
	private List<JComponent>	componentsToDisableWhenRunning	= new ArrayList<JComponent>();
	
	public static void main(String[] args) {
		new JCdmBuilderMain(args);
	}
	
	public JCdmBuilderMain(String[] args) {
		if (args.length > 0 && (args[0].toLowerCase().equals("-usage") || args[0].toLowerCase().equals("-help") || args[0].toLowerCase().equals("?"))) {
			printUsage();
			return;
		}
		frame = new JFrame("JCDMBuilder");
		
		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				System.exit(0);
			}
		});
		frame.setLayout(new BorderLayout());
		
		JMenuBar menuBar = createMenu();
		
		JComponent tabsPanel = createTabsPanel();
		JComponent consolePanel = createConsolePanel();
		
		frame.add(consolePanel, BorderLayout.CENTER);
		frame.add(tabsPanel, BorderLayout.NORTH);
		frame.setJMenuBar(menuBar);
		
		frame.pack();
		frame.setVisible(true);
		ObjectExchange.frame = frame;
		executeParameters(args);
		if (executeCdmStructureWhenReady || executeVocabWhenReady || executeEtlWhenReady || executeConditionErasWhenReady || executeDrugErasWhenReady
				|| executeIndicesWhenReady) {
			//ObjectExchange.console.setDebugFile(folderField.getText() + "/Console.txt");
			AutoRunThread autoRunThread = new AutoRunThread();
			autoRunThread.start();
		}
		
	}
	
	private JMenuBar createMenu() {
		JMenuBar menuBar = new JMenuBar();
		JMenu file = new JMenu("File");
		
		JMenuItem loadMenuItem = new JMenuItem("Load settings");
		loadMenuItem.setToolTipText("Load Settings");
		loadMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				loadSettingsFile();
			}
		});
		file.add(loadMenuItem);
		
		JMenuItem saveMenuItem = new JMenuItem("Save settings");
		saveMenuItem.setToolTipText("Save Settings");
		saveMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				saveSettingsFile();
			}
		});
		file.add(saveMenuItem);
		
		JMenuItem exitMenuItem = new JMenuItem("Exit");
		exitMenuItem.setToolTipText("Exit application");
		exitMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		file.add(exitMenuItem);
		
		menuBar.add(file);
		return menuBar;
	}
	
	private JComponent createTabsPanel() {
		tabbedPane = new JTabbedPane();
		
		JPanel locationPanel = createLocationsPanel();
		tabbedPane.addTab("Locations", null, locationPanel, "Specify the location of the source data, the CDM, and the working folder");
		
		JPanel vocabPanel = createVocabPanel();
		tabbedPane.addTab("Vocabulary", null, vocabPanel, "Upload the vocabulary to the server");
		
		JPanel etlPanel = createEtlPanel();
		tabbedPane.addTab("ETL", null, etlPanel, "Extract, Transform and Load the data into the OMOP CDM");
		
		JPanel executePanel = createExecutePanel();
		tabbedPane.addTab("Execute", null, executePanel, "Run multiple steps automatically");
		
		return tabbedPane;
	}
	
	private JPanel createLocationsPanel() {
		JPanel panel = new JPanel();
		
		panel.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.BOTH;
		c.weightx = 0.5;
		
		JPanel folderPanel = new JPanel();
		folderPanel.setLayout(new BoxLayout(folderPanel, BoxLayout.X_AXIS));
		folderPanel.setBorder(BorderFactory.createTitledBorder("Working folder"));
		folderField = new JTextField();
		folderField.setText("");
		folderField.setToolTipText("The folder where all output will be written");
		folderPanel.add(folderField);
		JButton pickButton = new JButton("Select");
		pickButton.setToolTipText("Pick a different working folder");
		folderPanel.add(pickButton);
		pickButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				pickFile();
			}
		});
		componentsToDisableWhenRunning.add(pickButton);
		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 1;
		panel.add(folderPanel, c);
		
		JPanel targetPanel = new JPanel();
		targetPanel.setLayout(new GridLayout(0, 2));
		targetPanel.setBorder(BorderFactory.createTitledBorder("Target CDM location"));
		targetPanel.add(new JLabel("Data type"));
		targetType = new JComboBox<String>(new String[] { "PostgreSQL", "Oracle", "SQL Server" });
		targetType.setToolTipText("Select the type of server where the CDM and vocabulary will be stored");
		targetPanel.add(targetType);
		targetPanel.add(new JLabel("Server location"));
		targetServerField = new JTextField("");
		targetPanel.add(targetServerField);
		targetPanel.add(new JLabel("User name"));
		targetUserField = new JTextField("");
		targetPanel.add(targetUserField);
		targetPanel.add(new JLabel("Password"));
		targetPasswordField = new JPasswordField("");
		targetPanel.add(targetPasswordField);
		targetPanel.add(new JLabel("Database name"));
		targetDatabaseField = new JTextField("");
		targetPanel.add(targetDatabaseField);
		targetPanel.add(new JLabel("CDM version"));
		targetCdmVersion = new JComboBox<String>(new String[] { "4.0", "5.0.1" });
		targetCdmVersion.setToolTipText("Select the CMD version");
		targetCdmVersion.setSelectedIndex(1);
		
		targetType.addItemListener(new ItemListener() {
			
			@Override
			public void itemStateChanged(ItemEvent arg0) {
				
				if (arg0.getItem().toString().equals("Oracle")) {
					targetServerField.setToolTipText(
							"For Oracle servers this field contains the SID, servicename, and optionally the port: '<host>/<sid>', '<host>:<port>/<sid>', '<host>/<service name>', or '<host>:<port>/<service name>'");
					targetUserField.setToolTipText("For Oracle servers this field contains the name of the user used to log in");
					targetPasswordField.setToolTipText("For Oracle servers this field contains the password corresponding to the user");
					targetDatabaseField
							.setToolTipText("For Oracle servers this field contains the schema (i.e. 'user' in Oracle terms) containing the target tables");
				} else if (arg0.getItem().toString().equals("PostgreSQL")) {
					targetServerField.setToolTipText("For PostgreSQL servers this field contains the host name and database name (<host>/<database>)");
					targetUserField.setToolTipText("The user used to log in to the server");
					targetPasswordField.setToolTipText("The password used to log in to the server");
					targetDatabaseField.setToolTipText("For PostgreSQL servers this field contains the schema containing the target tables");
				} else {
					targetServerField.setToolTipText("This field contains the name or IP address of the database server");
					if (arg0.getItem().toString().equals("SQL Server"))
						targetUserField.setToolTipText(
								"The user used to log in to the server. Optionally, the domain can be specified as <domain>/<user> (e.g. 'MyDomain/Joe')");
					else
						targetUserField.setToolTipText("The user used to log in to the server");
					targetPasswordField.setToolTipText("The password used to log in to the server");
					targetDatabaseField.setToolTipText("The name of the database containing the target tables");
				}
			}
		});
		targetType.setSelectedIndex(1);
		targetPanel.add(targetCdmVersion);
		
		c.gridx = 0;
		c.gridy = 1;
		c.gridwidth = 1;
		panel.add(targetPanel, c);
		
		JPanel testConnectionButtonPanel = new JPanel();
		testConnectionButtonPanel.setLayout(new BoxLayout(testConnectionButtonPanel, BoxLayout.X_AXIS));
		testConnectionButtonPanel.add(Box.createHorizontalGlue());
		
		JButton testConnectionButton = new JButton("Test connection");
		testConnectionButton.setBackground(new Color(151, 220, 141));
		testConnectionButton.setToolTipText("Test the connection");
		testConnectionButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				testConnection(getTargetDbSettings());
			}
		});
		componentsToDisableWhenRunning.add(testConnectionButton);
		testConnectionButtonPanel.add(testConnectionButton);
		
		c.gridx = 0;
		c.gridy = 2;
		c.gridwidth = 1;
		panel.add(testConnectionButtonPanel, c);
		
		return panel;
	}
	
	private void testConnection(DbSettings dbSettings) {
		if (dbSettings.database == null || dbSettings.database.equals("")) {
			JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap("Please specify database name", 80), "Error connecting to server",
					JOptionPane.ERROR_MESSAGE);
			return;
		}
		if (dbSettings.server == null || dbSettings.server.equals("")) {
			JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap("Please specify the server", 80), "Error connecting to server",
					JOptionPane.ERROR_MESSAGE);
			return;
		}
		
		RichConnection connection;
		try {
			connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		} catch (Exception e) {
			String message = "Could not connect: " + e.getMessage();
			JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Error connecting to server", JOptionPane.ERROR_MESSAGE);
			return;
		}
		
		try {
			connection.getTableNames(dbSettings.database);
		} catch (Exception e) {
			String message = "Could not connect to database: " + e.getMessage();
			JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Error connecting to server", JOptionPane.ERROR_MESSAGE);
			return;
		}
		
		connection.close();
		String message = "Succesfully connected to " + dbSettings.database + " on server " + dbSettings.server;
		JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Connection succesful", JOptionPane.INFORMATION_MESSAGE);
	}
	
	private void loadSettings() {
		// locations
		folderField.setText(propertiesManager.get("WorkspaceFolder"));
		targetType.setSelectedItem(propertiesManager.get("TargetDataType"));
		targetServerField.setText(propertiesManager.get("TargetServerLocation"));
		targetUserField.setText(propertiesManager.get("TargetUserName"));
		targetDatabaseField.setText(propertiesManager.get("TargetDatabaseName"));
		targetCdmVersion.setSelectedItem(propertiesManager.get("TargetCdmVersion"));
		
		// ETL
		versionIdField.setText(propertiesManager.get("VersionIdField"));
		etlType.setSelectedItem(propertiesManager.get("EtlType"));
		sourceType.setSelectedItem(propertiesManager.get("SourceDataType"));
		sourceServerField.setText(propertiesManager.get("SourceServerLocation"));
		sourceUserField.setText(propertiesManager.get("SourceUserName"));
		sourceDatabaseField.setText(propertiesManager.get("SourceDatabaseName"));
		sourceDelimiterField.setText(propertiesManager.get("SourceDelimiter"));
		sourceFolderField.setText(propertiesManager.get("SourceFolder"));
		
		// vocabulary
		vocabFileField.setText(propertiesManager.get("VocabFileField"));
		vocabSchemaField.setText(propertiesManager.get("VocabSchemaField"));
		if (propertiesManager.get("VocabType").equals("ATHENA CSV files in folder"))
			vocabFileTypeButton.doClick();
		else
			vocabSchemaTypeButton.doClick();
		
	}
	
	private void saveSettings(String fileName) {
		// locations
		propertiesManager.set("WorkspaceFolder", folderField.getText());
		propertiesManager.set("TargetDataType", targetType.getSelectedItem().toString());
		propertiesManager.set("TargetServerLocation", targetServerField.getText());
		propertiesManager.set("TargetUserName", targetUserField.getText());
		propertiesManager.set("TargetDatabaseName", targetDatabaseField.getText());
		propertiesManager.set("TargetCdmVersion", targetCdmVersion.getSelectedItem().toString());
		
		// ETL
		propertiesManager.set("VersionIdField", versionIdField.getText());
		propertiesManager.set("EtlType", etlType.getSelectedItem().toString());
		propertiesManager.set("SourceDataType", sourceType.getSelectedItem().toString());
		propertiesManager.set("SourceServerLocation", sourceServerField.getText());
		propertiesManager.set("SourceUserName", sourceUserField.getText());
		propertiesManager.set("SourceDatabaseName", sourceDatabaseField.getText());
		propertiesManager.set("SourceDelimiter", sourceDelimiterField.getText());
		propertiesManager.set("SourceFolder", sourceFolderField.getText());
		
		// vocabulary
		propertiesManager.set("VocabFileField", vocabFileField.getText());
		propertiesManager.set("VocabSchemaField", vocabSchemaField.getText());
		if (vocabFileTypeButton.isSelected())
			propertiesManager.set("VocabType", "ATHENA CSV files in folder");
		else
			propertiesManager.set("VocabType", "Database schema");
		
		propertiesManager.save(fileName);
	}
	
	private JPanel createVocabPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
		
		JPanel vocabSourceTypePanel = new JPanel();
		vocabSourceTypePanel.setLayout(new BoxLayout(vocabSourceTypePanel, BoxLayout.X_AXIS));
		vocabSourceTypePanel.setBorder(BorderFactory.createTitledBorder("Vocabulary source type"));
		ButtonGroup buttonGroup = new ButtonGroup();
		vocabFileTypeButton = new JRadioButton("ATHENA CSV files in folder");
		vocabSourceTypePanel.add(vocabFileTypeButton);
		buttonGroup.add(vocabFileTypeButton);
		vocabFileTypeButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				((CardLayout) vocabCards.getLayout()).show(vocabCards, VOCABFOLDER);
			}
		});
		vocabSourceTypePanel.add(Box.createHorizontalGlue());
		vocabSchemaTypeButton = new JRadioButton("Database schema");
		vocabSourceTypePanel.add(vocabSchemaTypeButton);
		buttonGroup.add(vocabSchemaTypeButton);
		vocabFileTypeButton.setSelected(true);
		vocabSchemaTypeButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				((CardLayout) vocabCards.getLayout()).show(vocabCards, VOCABSCHEMA);
			}
		});
		panel.add(vocabSourceTypePanel);
		
		vocabCards = new JPanel(new CardLayout());
		
		JPanel vocabFilePanel = new JPanel();
		vocabFilePanel.setLayout(new BoxLayout(vocabFilePanel, BoxLayout.X_AXIS));
		vocabFilePanel.setBorder(BorderFactory.createTitledBorder("Vocabulary data folder"));
		vocabFileField = new JTextField();
		vocabFileField.setText("");
		vocabFileField.setToolTipText("Specify the name of the folder containing the vocabulary CSV files here");
		vocabFilePanel.add(vocabFileField);
		JButton pickButton = new JButton("Pick file");
		pickButton.setToolTipText("Select the folder containing the vocabulary CSV files");
		vocabFilePanel.add(pickButton);
		pickButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				pickVocabFile();
			}
		});
		vocabCards.add(vocabFilePanel, VOCABFOLDER);
		
		JPanel vocabSchemaPanel = new JPanel();
		vocabSchemaPanel.setLayout(new BoxLayout(vocabSchemaPanel, BoxLayout.Y_AXIS));
		vocabSchemaPanel.setBorder(BorderFactory.createTitledBorder("Vocabulary schema"));
		vocabSchemaField = new JTextField();
		vocabSchemaField.setText("");
		vocabSchemaField.setToolTipText("Specify the name of the schema containing the vocabulary tables here");
		vocabSchemaPanel.add(vocabSchemaField);
		vocabCards.add(vocabSchemaPanel, VOCABSCHEMA);
		
		panel.add(vocabCards);
		vocabCards.setMaximumSize(new Dimension(Integer.MAX_VALUE, vocabCards.getPreferredSize().height));
		panel.add(Box.createVerticalGlue());
		return panel;
	}
	
	private JPanel createEtlPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.BOTH;
		c.weightx = 0.5;
		
		JPanel etlTypePanel = new JPanel();
		etlTypePanel.setLayout(new BoxLayout(etlTypePanel, BoxLayout.X_AXIS));
		etlTypePanel.setBorder(BorderFactory.createTitledBorder("ETL type"));
		etlType = new JComboBox<String>(
				new String[] { "1. Load CSV files in CDM format to server", "2. ARS -> OMOP CDM V4", "3. HCUP -> OMOP CDM V4", "4. HCUP -> OMOP CDM V5" });
		etlType.setToolTipText("Select the appropriate ETL process");
		etlType.addItemListener(new ItemListener() {
			
			@Override
			public void itemStateChanged(ItemEvent arg0) {
				String selection = arg0.getItem().toString();
				if (selection.equals("1. Load CSV files in CDM format to server") || selection.equals("2. ARS -> OMOP CDM V4"))
					((CardLayout) sourceCards.getLayout()).show(sourceCards, SOURCEFOLDER);
				else
					((CardLayout) sourceCards.getLayout()).show(sourceCards, SOURCEDATABASE);
			}
		});
		etlTypePanel.add(etlType);
		etlTypePanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, etlTypePanel.getPreferredSize().height));
		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 1;
		panel.add(etlTypePanel, c);
		
		// Ugly but needed for ETLs at JnJ: Allow user to specify a version ID to insert into _version table:
		JPanel versionIdPanel = new JPanel();
		versionIdPanel.setLayout(new BoxLayout(versionIdPanel, BoxLayout.X_AXIS));
		versionIdPanel.setBorder(BorderFactory.createTitledBorder("Version ID"));
		versionIdField = new JTextField("1");
		versionIdField.setToolTipText("(Optionally:) Specify a version ID (integer) to insert into the unofficial _version table");
		versionIdPanel.add(versionIdField);
		versionIdPanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, versionIdPanel.getPreferredSize().height));
		c.gridx = 1;
		c.gridy = 0;
		c.gridwidth = 1;
		panel.add(versionIdPanel, c);
		
		JPanel sourceFolderPanel = new JPanel();
		sourceFolderPanel.setLayout(new GridLayout(5, 2));
		sourceFolderPanel.setBorder(BorderFactory.createTitledBorder("Source folder location"));
		sourceFolderPanel.add(new JLabel("Folder"));
		
		JPanel sourceFolderFieldPanel = new JPanel();
		sourceFolderFieldPanel.setLayout(new BoxLayout(sourceFolderFieldPanel, BoxLayout.X_AXIS));
		sourceFolderField = new JTextField();
		sourceFolderField.setText("");
		sourceFolderField.setToolTipText("Specify the name of the folder containing the CSV files here");
		sourceFolderFieldPanel.add(sourceFolderField);
		JButton pickButton = new JButton("Pick file");
		pickButton.setToolTipText("Select the folder containing the source CSV files");
		sourceFolderFieldPanel.add(pickButton);
		pickButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				pickSourceFolder();
			}
		});
		sourceFolderPanel.add(sourceFolderFieldPanel);
		sourceFolderPanel.add(new JLabel("Delimiter"));
		sourceDelimiterField = new JTextField(",");
		sourceDelimiterField.setToolTipText("The delimiter that separates values. Enter 'tab' for tab.");
		sourceFolderPanel.add(sourceDelimiterField);
		sourceFolderPanel.add(Box.createHorizontalGlue());
		sourceFolderPanel.add(Box.createHorizontalGlue());
		sourceFolderPanel.add(Box.createHorizontalGlue());
		sourceFolderPanel.add(Box.createHorizontalGlue());
		
		JPanel sourceDatabasePanel = new JPanel();
		sourceDatabasePanel.setLayout(new GridLayout(0, 2));
		sourceDatabasePanel.setBorder(BorderFactory.createTitledBorder("Source database location"));
		sourceDatabasePanel.add(new JLabel("Data type"));
		sourceType = new JComboBox<String>(new String[] { "Oracle", "SQL Server", "PostgreSQL" });
		sourceType.setToolTipText("Select the source database platform");
		sourceType.addItemListener(new ItemListener() {
			
			@Override
			public void itemStateChanged(ItemEvent arg0) {
				if (arg0.getItem().toString().equals("Oracle")) {
					sourceServerField.setToolTipText(
							"For Oracle servers this field contains the SID, servicename, and optionally the port: '<host>/<sid>', '<host>:<port>/<sid>', '<host>/<service name>', or '<host>:<port>/<service name>'");
					sourceUserField.setToolTipText("For Oracle servers this field contains the name of the user used to log in");
					sourcePasswordField.setToolTipText("For Oracle servers this field contains the password corresponding to the user");
					sourceDatabaseField
							.setToolTipText("For Oracle servers this field contains the schema (i.e. 'user' in Oracle terms) containing the source tables");
				} else if (arg0.getItem().toString().equals("PostgreSQL")) {
					sourceServerField.setToolTipText("For PostgreSQL servers this field contains the host name and database name (<host>/<database>)");
					sourceUserField.setToolTipText("The user used to log in to the server");
					sourcePasswordField.setToolTipText("The password used to log in to the server");
					sourceDatabaseField.setToolTipText("For PostgreSQL servers this field contains the schema containing the source tables");
				} else {
					sourceServerField.setToolTipText("This field contains the name or IP address of the database server");
					if (arg0.getItem().toString().equals("SQL Server"))
						sourceUserField.setToolTipText(
								"The user used to log in to the server. Optionally, the domain can be specified as <domain>/<user> (e.g. 'MyDomain/Joe')");
					else
						sourceUserField.setToolTipText("The user used to log in to the server");
					sourcePasswordField.setToolTipText("The password used to log in to the server");
					sourceDatabaseField.setToolTipText("The name of the database containing the source tables");
				}
			}
		});
		sourceDatabasePanel.add(sourceType);
		sourceDatabasePanel.add(new JLabel("Server location"));
		sourceServerField = new JTextField("");
		sourceDatabasePanel.add(sourceServerField);
		sourceDatabasePanel.add(new JLabel("User name"));
		sourceUserField = new JTextField("");
		sourceDatabasePanel.add(sourceUserField);
		sourceDatabasePanel.add(new JLabel("Password"));
		sourcePasswordField = new JPasswordField("");
		sourceDatabasePanel.add(sourcePasswordField);
		sourceDatabasePanel.add(new JLabel("Database name"));
		sourceDatabaseField = new JTextField("");
		sourceDatabasePanel.add(sourceDatabaseField);
		
		sourceCards = new JPanel(new CardLayout());
		sourceCards.add(sourceFolderPanel, SOURCEFOLDER);
		sourceCards.add(sourceDatabasePanel, SOURCEDATABASE);
		
		c.gridx = 0;
		c.gridy = 1;
		c.gridwidth = 2;
		panel.add(sourceCards, c);
		sourceCards.setMaximumSize(new Dimension(Integer.MAX_VALUE, sourceCards.getPreferredSize().height));
		
		JPanel etlButtonPanel = new JPanel();
		etlButtonPanel.setLayout(new BoxLayout(etlButtonPanel, BoxLayout.X_AXIS));
		etlButtonPanel.add(Box.createHorizontalGlue());
		
		JButton etl10kButton = new JButton("Perform 10k persons ETL");
		etl10kButton.setBackground(new Color(151, 220, 141));
		etl10kButton.setToolTipText("Perform the ETL for the first 10,000 persons");
		etl10kButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				etlRun(10000);
			}
		});
		componentsToDisableWhenRunning.add(etl10kButton);
		etlButtonPanel.add(etl10kButton);
		
		return panel;
	}
	
	private JPanel createExecutePanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.HORIZONTAL;
		c.weightx = 0.5;
		
		JPanel checkboxPanel = new JPanel();
		checkboxPanel.setBorder(BorderFactory.createTitledBorder("Steps to execute"));
		checkboxPanel.setLayout(new BoxLayout(checkboxPanel, BoxLayout.Y_AXIS));
		
		executeStructureCheckBox = new JCheckBox("Create CDM Structure");
		checkboxPanel.add(executeStructureCheckBox);
		executeVocabCheckBox = new JCheckBox("Insert vocabulary");
		checkboxPanel.add(executeVocabCheckBox);
		executeETLCheckBox = new JCheckBox("Perform ETL");
		checkboxPanel.add(executeETLCheckBox);
		executeConditionErasCheckBox = new JCheckBox("Create condition eras");
		checkboxPanel.add(executeConditionErasCheckBox);
		executeDrugErasCheckBox = new JCheckBox("Create drug eras");
		checkboxPanel.add(executeDrugErasCheckBox);
		executeIndicesCheckBox = new JCheckBox("Create indices");
		checkboxPanel.add(executeIndicesCheckBox);
		c.gridy = 0;
		panel.add(checkboxPanel, c);
		
		JPanel buttonPanel = new JPanel();
		buttonPanel.setLayout(new BoxLayout(buttonPanel, BoxLayout.X_AXIS));
		buttonPanel.add(Box.createHorizontalGlue());
		
		JButton executeButton = new JButton("Execute");
		buttonPanel.add(executeButton);
		executeButton.setBackground(new Color(151, 220, 141));
		executeButton.setToolTipText("Execute all selected steps");
		executeButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				executeCdmStructureWhenReady = executeStructureCheckBox.isSelected();
				executeVocabWhenReady = executeVocabCheckBox.isSelected();
				executeEtlWhenReady = executeETLCheckBox.isSelected();
				executeConditionErasWhenReady = executeConditionErasCheckBox.isSelected();
				executeDrugErasWhenReady = executeDrugErasCheckBox.isSelected();
				executeIndicesWhenReady = executeIndicesCheckBox.isSelected();
				if (executeCdmStructureWhenReady || executeVocabWhenReady || executeEtlWhenReady || executeConditionErasWhenReady || executeDrugErasWhenReady
						|| executeIndicesWhenReady)
					runAll();
			}
		});
		componentsToDisableWhenRunning.add(executeButton);
		c.gridy = 1;
		panel.add(buttonPanel, c);
		
		return panel;
	}
	
	private JComponent createConsolePanel() {
		JTextArea consoleArea = new JTextArea();
		consoleArea.setToolTipText("General progress information");
		consoleArea.setEditable(false);
		Console console = new Console();
		console.setTextArea(consoleArea);
		// console.setDebugFile("c:/temp/debug.txt");
		System.setOut(new PrintStream(console));
		System.setErr(new PrintStream(console));
		JScrollPane consoleScrollPane = new JScrollPane(consoleArea);
		consoleScrollPane.setBorder(BorderFactory.createTitledBorder("Console"));
		consoleScrollPane.setPreferredSize(new Dimension(800, 200));
		consoleScrollPane.setAutoscrolls(true);
		ObjectExchange.console = console;
		return consoleScrollPane;
	}
	
	private void printUsage() {
		System.out.println("Usage: java -jar JCDMBuilder.jar [options]");
		System.out.println("");
		System.out.println("Options are:");
		System.out.println("-folder <folder>            Set working folder");
		System.out.println("-targettype <type>          Set target type, e.g. '-targettype \"SQL Server\"'");
		System.out.println("-targetserver <server>      Set target server, e.g. '-targetserver myserver.mycompany.com'");
		System.out.println("-targetdatabase <database>  Set target database, e.g. '-targetdatabase cdm_hcup'");
		System.out.println("-targetuser <user>          Set target database user");
		System.out.println("-targetpassword <password>  Set target database password");
		System.out.println("-vocabsourcetype <type>     Set vocab source type, e.g. '-vocabsourcetype files' or '-vocabsourcetype schema'");
		System.out.println("-vocabfolder <folder>       Set vocab folder when using file type");
		System.out.println("-vocabSchemaField <schema>  Set vocab schema name (assumed to be on target server)");
		System.out.println("-etlnumber <number>         Set ETL number, e.g. '-etlnumber 4' for HCUP ETL to CDM version 5'");
		System.out.println("-versionid <id>             Set version ID (integer) to be loaded into _version table");
		System.out.println("-sourcetype <type>          Set source type, e.g. '-sourcetype \"SQL Server\"'");
		System.out.println("-sourceserver <server>      Set source server, e.g. '-sourceserver myserver.mycompany.com'");
		System.out.println("-sourcedatabase <database>  Set source database, e.g. '-sourcedatabase [hcup-nis]'");
		System.out.println("-sourceuser <user>          Set source database user");
		System.out.println("-sourcepassword <password>  Set source database password");
		System.out.println("-sourcefolder <folder>      Set source folder containing CSV files");
		System.out.println("-idtobigint  				When creating the CDM structure, use BIGINT instead of INT for all IDs");
		System.out.println("");
		System.out.println("The following options allow the steps to be automatically executed. Steps are executed in order:");
		System.out.println("-executecdmstructure        Create default CDM structure on startup");
		System.out.println("-executevocab               Insert vocabulary on startup");
		System.out.println("-executeetl                 Execute ETL on startup");
		System.out.println("-executedrugeras            Create drug eras on startup");
		System.out.println("-executeconditioneras       Create condition eras on startup");
		System.out.println("-executeindices             Create required indices on startup");
	}
	
	private void executeParameters(String[] args) {
		String mode = null;
		for (String arg : args) {
			if (arg.startsWith("-")) {
				mode = arg.toLowerCase();
				if (mode.equals("-executecdmstructure"))
					executeCdmStructureWhenReady = true;
				if (mode.equals("-executevocab"))
					executeVocabWhenReady = true;
				if (mode.equals("-executeetl"))
					executeEtlWhenReady = true;
				if (mode.equals("-executedrugeras"))
					executeDrugErasWhenReady = true;
				if (mode.equals("-executeconditioneras"))
					executeConditionErasWhenReady = true;
				if (mode.equals("-executeindices"))
					executeIndicesWhenReady = true;
				if (mode.equals("-idstobigint")) {
					idsToBigInt = true;
					System.out.println("IDs will be converted to BIGINT");
				}
			} else {
				if (mode.equals("-folder"))
					folderField.setText(arg);
				if (mode.equals("-targetpassword"))
					targetPasswordField.setText(arg);
				if (mode.equals("-targetserver"))
					targetServerField.setText(arg);
				if (mode.equals("-targettype"))
					targetType.setSelectedItem(arg);
				if (mode.equals("-targetdatabase"))
					targetDatabaseField.setText(arg);
				if (mode.equals("-targetuser"))
					targetUserField.setText(arg);
				if (mode.equals("-sourceserver"))
					sourceServerField.setText(arg);
				if (mode.equals("-sourcetype"))
					sourceType.setSelectedItem(arg);
				if (mode.equals("-sourcedatabase"))
					sourceDatabaseField.setText(arg);
				if (mode.equals("-sourceuser"))
					sourceUserField.setText(arg);
				if (mode.equals("-sourcepassword"))
					sourcePasswordField.setText(arg);
				if (mode.equals("-vocabsourcetype")) {
					if (arg.toLowerCase().contains("database") || arg.toLowerCase().contains("schema"))
						vocabSchemaTypeButton.doClick();
					else
						vocabFileTypeButton.doClick();
				}
				if (mode.equals("-sourcefolder"))
					sourceFolderField.setText(arg);
				if (mode.equals("-vocabfolder")) {
					vocabFileField.setText(arg);
				}
				if (mode.equals("-vocabschema")) {
					vocabSchemaField.setText(arg);
				}
				if (mode.equals("-versionid")) {
					versionIdField.setText(arg);
				}
				if (mode.equals("-etlnumber")) {
					int etlNumber = Integer.parseInt(arg);
					etlType.setSelectedIndex(etlNumber - 1);
				}
				mode = null;
			}
		}
	}
	
	private void pickFile() {
		JFileChooser fileChooser = new JFileChooser(new File(folderField.getText()));
		fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		int returnVal = fileChooser.showDialog(frame, "Select folder");
		if (returnVal == JFileChooser.APPROVE_OPTION)
			folderField.setText(fileChooser.getSelectedFile().getAbsolutePath());
	}
	
	private void loadSettingsFile() {
		JFileChooser fileChooser = new JFileChooser();
		if (propertiesManager.getSettingFileName() == null)
			fileChooser.setSelectedFile(new File(System.getProperty("user.dir")));
		else
			fileChooser.setSelectedFile(new File(propertiesManager.getSettingFileName()));
		fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int returnVal = fileChooser.showDialog(frame, "Load");
		if (returnVal == JFileChooser.APPROVE_OPTION) {
			propertiesManager.load(fileChooser.getSelectedFile().getAbsolutePath());
			loadSettings();
		}
	}
	
	private void saveSettingsFile() {
		JFileChooser fileChooser = new JFileChooser();
		if (propertiesManager.getSettingFileName() == null)
			fileChooser.setSelectedFile(new File(System.getProperty("user.dir")));
		else
			fileChooser.setSelectedFile(new File(propertiesManager.getSettingFileName()));
		fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int returnVal = fileChooser.showDialog(frame, "Save");
		if (returnVal == JFileChooser.APPROVE_OPTION) {
			saveSettings(fileChooser.getSelectedFile().getAbsolutePath());
			propertiesManager.load(fileChooser.getSelectedFile().getAbsolutePath());
		}
	}
	
	private void pickVocabFile() {
		JFileChooser fileChooser = new JFileChooser(new File(folderField.getText()));
		fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		int returnVal = fileChooser.showDialog(frame, "Select vocabulary folder");
		if (returnVal == JFileChooser.APPROVE_OPTION)
			vocabFileField.setText(fileChooser.getSelectedFile().getAbsolutePath());
	}
	
	private void pickSourceFolder() {
		JFileChooser fileChooser = new JFileChooser(new File(folderField.getText()));
		fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		int returnVal = fileChooser.showDialog(frame, "Select source folder");
		if (returnVal == JFileChooser.APPROVE_OPTION)
			sourceFolderField.setText(fileChooser.getSelectedFile().getAbsolutePath());
	}
	
	private DbSettings getSourceDbSettings() {
		DbSettings dbSettings = new DbSettings();
		dbSettings.dataType = DbSettings.DATABASE;
		dbSettings.user = sourceUserField.getText();
		dbSettings.password = sourcePasswordField.getText();
		dbSettings.server = sourceServerField.getText();
		dbSettings.database = sourceDatabaseField.getText().trim().length() == 0 ? null : sourceDatabaseField.getText();
		if (sourceType.getSelectedItem().toString().equals("MySQL"))
			dbSettings.dbType = DbType.MYSQL;
		else if (sourceType.getSelectedItem().toString().equals("Oracle"))
			dbSettings.dbType = DbType.ORACLE;
		else if (sourceType.getSelectedItem().toString().equals("PostgreSQL"))
			dbSettings.dbType = DbType.POSTGRESQL;
		else if (sourceType.getSelectedItem().toString().equals("SQL Server")) {
			dbSettings.dbType = DbType.MSSQL;
			if (sourceUserField.getText().length() != 0) { // Not using windows authentication
				String[] parts = sourceUserField.getText().split("/");
				if (parts.length < 2) {
					dbSettings.user = sourceUserField.getText();
					dbSettings.domain = null;
				} else {
					dbSettings.user = parts[1];
					dbSettings.domain = parts[0];
				}
			}
		}
		if (dbSettings.database == null) {
			String message = "Please specify a name for the source database";
			JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Database error", JOptionPane.ERROR_MESSAGE);
			return null;
		}
		return dbSettings;
	}
	
	private void testConnection(DbSettings dbSettings, boolean testConnectionToDb) {
		RichConnection connection;
		try {
			connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		} catch (Exception e) {
			String message = "Could not connect to source server: " + e.getMessage();
			JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Error connecting to server", JOptionPane.ERROR_MESSAGE);
			return;
		}
		
		if (testConnectionToDb)
			try {
				connection.getTableNames(dbSettings.database);
			} catch (Exception e) {
				String message = "Could not connect to database: " + e.getMessage();
				JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Error connecting to server", JOptionPane.ERROR_MESSAGE);
				return;
			}
		
		connection.close();
	}
	
	private DbSettings getTargetDbSettings() {
		DbSettings dbSettings = new DbSettings();
		dbSettings.dataType = DbSettings.DATABASE;
		dbSettings.user = targetUserField.getText();
		dbSettings.password = targetPasswordField.getText();
		dbSettings.server = targetServerField.getText();
		dbSettings.database = targetDatabaseField.getText();
		if (targetType.getSelectedItem().toString().equals("MySQL"))
			dbSettings.dbType = DbType.MYSQL;
		else if (targetType.getSelectedItem().toString().equals("Oracle"))
			dbSettings.dbType = DbType.ORACLE;
		else if (targetType.getSelectedItem().toString().equals("PostgreSQL"))
			dbSettings.dbType = DbType.POSTGRESQL;
		else if (targetType.getSelectedItem().toString().equals("SQL Server")) {
			dbSettings.dbType = DbType.MSSQL;
			if (targetUserField.getText().length() != 0) { // Not using windows authentication
				String[] parts = targetUserField.getText().split("/");
				if (parts.length < 2) {
					dbSettings.user = targetUserField.getText();
					dbSettings.domain = null;
				} else {
					dbSettings.user = parts[1];
					dbSettings.domain = parts[0];
				}
			}
		}
		
		if (dbSettings.database.trim().length() == 0) {
			String message = "Please specify a name for the target database";
			JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Database error", JOptionPane.ERROR_MESSAGE);
			return null;
		}
		
		return dbSettings;
	}
	
	private void etlRun(int maxPersons) {
		EtlThread etlThread = new EtlThread(maxPersons);
		etlThread.start();
	}
	
	private class AutoRunThread extends Thread {
		public void run() {
			if (executeCdmStructureWhenReady) {
				StructureThread structureThread = new StructureThread();
				structureThread.run();
			}
			if (executeVocabWhenReady) {
				VocabRunThread vocabRunThread = new VocabRunThread();
				vocabRunThread.run();
			}
			if (executeEtlWhenReady) {
				EtlThread etlThread = new EtlThread(Integer.MAX_VALUE);
				etlThread.run();
			}
			if (executeConditionErasWhenReady) {
				EraThread eraThread = new EraThread(EraThread.CONDITIONS);
				eraThread.run();
			}
			if (executeDrugErasWhenReady) {
				EraThread eraThread = new EraThread(EraThread.DRUGS);
				eraThread.run();
			}
			if (executeIndicesWhenReady) {
				IndexThread indexThread = new IndexThread();
				indexThread.run();
			}
		}
	}
	
	private class EtlThread extends Thread {
		
		private int maxPersons;
		
		public EtlThread(int maxPersons) {
			this.maxPersons = maxPersons;
		}
		
		public void run() {
			for (JComponent component : componentsToDisableWhenRunning)
				component.setEnabled(false);
			
			try {
				if (etlType.getSelectedItem().equals("1. Load CSV files in CDM format to server")) {
					CdmEtl etl = new CdmEtl();
					DbSettings dbSettings = getTargetDbSettings();
					testConnection(dbSettings, false);
					if (dbSettings != null)
						etl.process(sourceFolderField.getText(), dbSettings, maxPersons, Integer.parseInt(versionIdField.getText()));
				}
				if (etlType.getSelectedItem().equals("2. ARS -> OMOP CDM V4")) {
					ARSETL etl = new ARSETL();
					DbSettings dbSettings = getTargetDbSettings();
					testConnection(dbSettings, false);
					if (dbSettings != null)
						etl.process(sourceFolderField.getText(), dbSettings, maxPersons);
				}
				if (etlType.getSelectedItem().equals("3. HCUP -> OMOP CDM V4")) {
					HCUPETL etl = new HCUPETL();
					DbSettings sourceDbSettings = getSourceDbSettings();
					DbSettings targetDbSettings = getTargetDbSettings();
					if (sourceDbSettings != null && targetDbSettings != null) {
						testConnection(sourceDbSettings, true);
						testConnection(targetDbSettings, false);
						etl.process(folderField.getText(), sourceDbSettings, targetDbSettings, maxPersons);
					}
				}
				if (etlType.getSelectedItem().equals("4. HCUP -> OMOP CDM V5")) {
					HCUPETLToV5 etl = new HCUPETLToV5();
					DbSettings sourceDbSettings = getSourceDbSettings();
					DbSettings targetDbSettings = getTargetDbSettings();
					if (sourceDbSettings != null && targetDbSettings != null) {
						testConnection(sourceDbSettings, true);
						testConnection(targetDbSettings, false);
						etl.process(folderField.getText(), sourceDbSettings, targetDbSettings, maxPersons, Integer.parseInt(versionIdField.getText()));
					}
				}
				
			} catch (Exception e) {
				handleError(e);
			} finally {
				for (JComponent component : componentsToDisableWhenRunning)
					component.setEnabled(true);
				
			}
		}
		
	}
	
	private class VocabRunThread extends Thread {
		
		public void run() {
			for (JComponent component : componentsToDisableWhenRunning)
				component.setEnabled(false);
			try {
				if (vocabFileTypeButton.isSelected()) {
					InsertVocabularyInServer process = new InsertVocabularyInServer();
					DbSettings dbSettings = getTargetDbSettings();
					if (dbSettings != null)
						process.process(vocabFileField.getText(), dbSettings);
				} else {
					CopyVocabularyFromSchema process = new CopyVocabularyFromSchema();
					DbSettings dbSettings = getTargetDbSettings();
					if (dbSettings != null)
						process.process(vocabSchemaField.getText(), dbSettings);
				}
			} catch (Exception e) {
				handleError(e);
			} finally {
				for (JComponent component : componentsToDisableWhenRunning)
					component.setEnabled(true);
			}
			
		}
	}
	
	private class StructureThread extends Thread {
		
		public void run() {
			for (JComponent component : componentsToDisableWhenRunning)
				component.setEnabled(false);
			try {
				DbSettings dbSettings = getTargetDbSettings();
				int version = targetCdmVersion.getSelectedItem().equals("5.0.1") ? 5 : 4;
				Cdm.createStructure(dbSettings, version, idsToBigInt);
			} catch (Exception e) {
				handleError(e);
			} finally {
				for (JComponent component : componentsToDisableWhenRunning)
					component.setEnabled(true);
			}
		}
	}
	
	private class IndexThread extends Thread {
		
		public void run() {
			for (JComponent component : componentsToDisableWhenRunning)
				component.setEnabled(false);
			try {
				DbSettings dbSettings = getTargetDbSettings();
				int version = targetCdmVersion.getSelectedItem().equals("5.0.1") ? Cdm.VERSION_5 : Cdm.VERSION_4;
				Cdm.createIndices(dbSettings, version);
			} catch (Exception e) {
				handleError(e);
			} finally {
				for (JComponent component : componentsToDisableWhenRunning)
					component.setEnabled(true);
			}
		}
	}
	
	private class EraThread extends Thread {
		
		private int				type;
		
		public final static int	DRUGS		= 1;
		public final static int	CONDITIONS	= 2;
		
		public EraThread(int type) {
			this.type = type;
		}
		
		public void run() {
			for (JComponent component : componentsToDisableWhenRunning)
				component.setEnabled(false);
			try {
				DbSettings dbSettings = getTargetDbSettings();
				int version = targetCdmVersion.getSelectedItem().equals("5.0.1") ? EraBuilder.VERSION_5 : EraBuilder.VERSION_4;
				int domain = type == DRUGS ? EraBuilder.DRUG_ERA : EraBuilder.CONDITION_ERA;
				EraBuilder.buildEra(dbSettings, version, domain);
			} catch (Exception e) {
				handleError(e);
			} finally {
				for (JComponent component : componentsToDisableWhenRunning)
					component.setEnabled(true);
			}
		}
	}
	
	private void handleError(Exception e) {
		System.err.println("Error: " + e.getMessage());
		String errorReportFilename = ErrorReport.generate(folderField.getText(), e);
		String message = "Error: " + e.getLocalizedMessage();
		message += "\nAn error report has been generated:\n" + errorReportFilename;
		System.out.println(message);
		JOptionPane.showMessageDialog(frame, StringUtilities.wordWrap(message, 80), "Error", JOptionPane.ERROR_MESSAGE);
	}
	
	private void runAll() {
		ObjectExchange.console.setDebugFile(folderField.getText() + "/Console.txt");
		AutoRunThread autoRunThread = new AutoRunThread();
		autoRunThread.start();
	}
}
