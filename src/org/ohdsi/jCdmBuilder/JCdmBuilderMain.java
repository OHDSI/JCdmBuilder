/*******************************************************************************
 * Copyright 2015 Observational Health Data Sciences and Informatics
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
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import org.ohdsi.jCdmBuilder.cdm.Cdm;
import org.ohdsi.jCdmBuilder.cdm.EraBuilder;
import org.ohdsi.jCdmBuilder.etls.ars.ARSETL;
import org.ohdsi.jCdmBuilder.etls.cdm.CdmEtl;
import org.ohdsi.jCdmBuilder.etls.hcup.HCUPETL;
import org.ohdsi.jCdmBuilder.etls.hcup.HCUPETLToV5;
import org.ohdsi.jCdmBuilder.vocabulary.InsertVocabularyInServer;
import org.ohdsi.utilities.DirectoryUtilities;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.databases.DbType;
import org.ohdsi.databases.RichConnection;

public class JCdmBuilderMain {

	private JFrame				frame;
	private JTextField			folderField;
	private JTextField			vocabFileField;

	private JComboBox<String>	etlType;
	private JComboBox<String>	cdmVersion;
	private JComboBox<String>	cdmVersionForIndices;
	private JComboBox<String>	cdmVersionForEras;
	private JComboBox<String>	domainForEras;
	private JComboBox<String>	sourceType;
	private JComboBox<String>	targetType;
	private JTextField			targetUserField;
	private JTextField			targetPasswordField;
	private JTextField			targetServerField;
	private JTextField			targetDatabaseField;
	private JTextField			sourceDelimiterField;
	private JTextField			sourceServerField;
	private JTextField			sourceUserField;
	private JTextField			sourcePasswordField;
	private JTextField			sourceDatabaseField;
	private boolean				sourceIsFiles					= true;
	private boolean				executeEtlWhenReady				= false;

	private List<JComponent>	componentsToDisableWhenRunning	= new ArrayList<JComponent>();

	public static void main(String[] args) {
		new JCdmBuilderMain(args);
	}

	public JCdmBuilderMain(String[] args) {
		frame = new JFrame("JCDMBuilder");

		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				System.exit(0);
			}
		});
		frame.setLayout(new BorderLayout());

		JComponent tabsPanel = createTabsPanel();
		JComponent consolePanel = createConsolePanel();

		frame.add(consolePanel, BorderLayout.CENTER);
		frame.add(tabsPanel, BorderLayout.NORTH);

		frame.pack();
		frame.setVisible(true);
		ObjectExchange.frame = frame;
		executeParameters(args);
		if (executeEtlWhenReady)
			etlRun(Integer.MAX_VALUE);
	}

	private JComponent createTabsPanel() {
		JTabbedPane tabbedPane = new JTabbedPane();

		JPanel locationPanel = createLocationsPanel();
		tabbedPane.addTab("Locations", null, locationPanel, "Specify the location of the source data, the CDM, and the working folder");

		JPanel structurePanel = createStructurePanel();
		tabbedPane.addTab("CDM structure", null, structurePanel, "Create the empty CDM data structure");

		JPanel vocabPanel = createVocabPanel();
		tabbedPane.addTab("Vocabulary", null, vocabPanel, "Upload the vocabulary to the server");

		JPanel etlPanel = createEtlPanel();
		tabbedPane.addTab("ETL", null, etlPanel, "Extract, Transform and Load the data into the OMOP CDM");

		JPanel erasPanel = createErasPanel();
		tabbedPane.addTab("Eras", null, erasPanel, "Populate the condition_era and drug_era tables");

		JPanel indicesPanel = createIndicesPanel();
		tabbedPane.addTab("Indices", null, indicesPanel, "Create recommended indices to improve performance");

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
		folderField.setText((new File("").getAbsolutePath()));
		folderField.setToolTipText("The folder where all output will be written");
		folderPanel.add(folderField);
		JButton pickButton = new JButton("Pick folder");
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
		c.gridwidth = 2;
		panel.add(folderPanel, c);

		JPanel sourcePanel = new JPanel();
		sourcePanel.setLayout(new GridLayout(0, 2));
		sourcePanel.setBorder(BorderFactory.createTitledBorder("Source data location"));
		sourcePanel.add(new JLabel("Data type"));
		sourceType = new JComboBox<String>(new String[] { "Delimited text files", "Oracle", "SQL Server", "PostgreSQL" });
		sourceType.setToolTipText("Select the type of source data available");
		sourceType.addItemListener(new ItemListener() {

			@Override
			public void itemStateChanged(ItemEvent arg0) {
				sourceIsFiles = arg0.getItem().toString().equals("Delimited text files");
				sourceServerField.setEnabled(!sourceIsFiles);
				sourceUserField.setEnabled(!sourceIsFiles);
				sourcePasswordField.setEnabled(!sourceIsFiles);
				sourceDatabaseField.setEnabled(!sourceIsFiles);
				sourceDelimiterField.setEnabled(sourceIsFiles);

				if (!sourceIsFiles && arg0.getItem().toString().equals("Oracle")) {
					sourceServerField
							.setToolTipText("For Oracle servers this field contains the SID, servicename, and optionally the port: '<host>/<sid>', '<host>:<port>/<sid>', '<host>/<service name>', or '<host>:<port>/<service name>'");
					sourceUserField.setToolTipText("For Oracle servers this field contains the name of the user used to log in");
					sourcePasswordField.setToolTipText("For Oracle servers this field contains the password corresponding to the user");
					sourceDatabaseField
							.setToolTipText("For Oracle servers this field contains the schema (i.e. 'user' in Oracle terms) containing the source tables");
				} else if (!sourceIsFiles && arg0.getItem().toString().equals("PostgreSQL")) {
					sourceServerField.setToolTipText("For PostgreSQL servers this field contains the host name and database name (<host>/<database>)");
					sourceUserField.setToolTipText("The user used to log in to the server");
					sourcePasswordField.setToolTipText("The password used to log in to the server");
					sourceDatabaseField.setToolTipText("For PostgreSQL servers this field contains the schema containing the source tables");
				} else if (!sourceIsFiles) {
					sourceServerField.setToolTipText("This field contains the name or IP address of the database server");
					if (arg0.getItem().toString().equals("SQL Server"))
						sourceUserField
								.setToolTipText("The user used to log in to the server. Optionally, the domain can be specified as <domain>/<user> (e.g. 'MyDomain/Joe')");
					else
						sourceUserField.setToolTipText("The user used to log in to the server");
					sourcePasswordField.setToolTipText("The password used to log in to the server");
					sourceDatabaseField.setToolTipText("The name of the database containing the source tables");
				}
			}
		});
		sourcePanel.add(sourceType);

		sourcePanel.add(new JLabel("Server location"));
		sourceServerField = new JTextField("127.0.0.1");
		sourceServerField.setEnabled(false);
		sourcePanel.add(sourceServerField);
		sourcePanel.add(new JLabel("User name"));
		sourceUserField = new JTextField("");
		sourceUserField.setEnabled(false);
		sourcePanel.add(sourceUserField);
		sourcePanel.add(new JLabel("Password"));
		sourcePasswordField = new JPasswordField("");
		sourcePasswordField.setEnabled(false);
		sourcePanel.add(sourcePasswordField);
		sourcePanel.add(new JLabel("Database name"));
		sourceDatabaseField = new JTextField("");
		sourceDatabaseField.setEnabled(false);
		sourcePanel.add(sourceDatabaseField);

		sourcePanel.add(new JLabel("Delimiter"));
		sourceDelimiterField = new JTextField(",");
		sourceDelimiterField.setToolTipText("The delimiter that separates values. Enter 'tab' for tab.");
		sourcePanel.add(sourceDelimiterField);

		c.gridx = 0;
		c.gridy = 1;
		c.gridwidth = 1;
		panel.add(sourcePanel, c);

		JPanel targetPanel = new JPanel();
		targetPanel.setLayout(new GridLayout(0, 2));
		targetPanel.setBorder(BorderFactory.createTitledBorder("Target data location"));
		targetPanel.add(new JLabel("Data type"));
		targetType = new JComboBox<String>(new String[] { "PostgreSQL", "Oracle", "SQL Server" });
		targetType.setToolTipText("Select the type of server where the CDM and vocabulary will be stored");
		targetPanel.add(targetType);
		targetPanel.add(new JLabel("Server location"));
		targetServerField = new JTextField("localhost/ars");
		targetPanel.add(targetServerField);
		targetPanel.add(new JLabel("User name"));
		targetUserField = new JTextField("");
		targetPanel.add(targetUserField);
		targetPanel.add(new JLabel("Password"));
		targetPasswordField = new JPasswordField("");
		targetPanel.add(targetPasswordField);
		targetPanel.add(new JLabel("CDM database name"));
		targetDatabaseField = new JTextField("cdmv4");
		targetPanel.add(targetDatabaseField);
		targetPanel.add(new JLabel(""));
		targetPanel.add(new JLabel(""));

		c.gridx = 1;
		c.gridy = 1;
		c.gridwidth = 1;
		panel.add(targetPanel, c);

		return panel;
	}

	private JPanel createVocabPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

		JPanel vocabFilePanel = new JPanel();
		vocabFilePanel.setLayout(new BoxLayout(vocabFilePanel, BoxLayout.X_AXIS));
		vocabFilePanel.setBorder(BorderFactory.createTitledBorder("Vocabulary data file"));

		vocabFileField = new JTextField();
		vocabFileField.setText("Vocabulary.zip");
		vocabFileField.setToolTipText("Specify the name of the file containing the vocabulary here");
		vocabFilePanel.add(vocabFileField);
		JButton pickButton = new JButton("Pick file");
		pickButton.setToolTipText("Select a different vocabulary file");
		vocabFilePanel.add(pickButton);
		pickButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				pickVocabFile();
			}
		});
		vocabFilePanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, vocabFilePanel.getPreferredSize().height));
		panel.add(vocabFilePanel);

		panel.add(Box.createVerticalGlue());

		JPanel vocabButtonPanel = new JPanel();
		vocabButtonPanel.setLayout(new BoxLayout(vocabButtonPanel, BoxLayout.X_AXIS));

		vocabButtonPanel.add(Box.createHorizontalGlue());
		JButton vocabButton = new JButton("Insert vocabulary");
		vocabButton.setBackground(new Color(151, 220, 141));
		vocabButton.setToolTipText("Insert the vocabulary database into the server");
		vocabButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				vocabRun();
			}
		});
		componentsToDisableWhenRunning.add(vocabButton);
		vocabButtonPanel.add(vocabButton);

		panel.add(vocabButtonPanel);

		return panel;
	}

	private JPanel createEtlPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

		JPanel etlTypePanel = new JPanel();
		etlTypePanel.setLayout(new BoxLayout(etlTypePanel, BoxLayout.X_AXIS));
		etlTypePanel.setBorder(BorderFactory.createTitledBorder("ETL type"));
		etlType = new JComboBox<String>(new String[] { "Load CSV files in CDM format to server", "ARS -> OMOP CDM V4", "HCUP -> OMOP CDM V4",
				"HCUP -> OMOP CDM V5" });
		etlType.setToolTipText("Select the appropriate ETL process");
		etlTypePanel.add(etlType);
		etlTypePanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, etlTypePanel.getPreferredSize().height));
		panel.add(etlTypePanel);

		panel.add(Box.createVerticalGlue());

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

		JButton etlButton = new JButton("Perform ETL");
		etlButton.setBackground(new Color(151, 220, 141));
		etlButton.setToolTipText("Extract, Transform and Load the data into the OMOP CDM");
		etlButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				etlRun(Integer.MAX_VALUE);
			}
		});
		componentsToDisableWhenRunning.add(etlButton);
		etlButtonPanel.add(etlButton);
		panel.add(etlButtonPanel);

		return panel;
	}

	private JPanel createStructurePanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

		JPanel cdmVersionPanel = new JPanel();
		cdmVersionPanel.setLayout(new BoxLayout(cdmVersionPanel, BoxLayout.X_AXIS));
		cdmVersionPanel.setBorder(BorderFactory.createTitledBorder("CDM version"));
		cdmVersion = new JComboBox<String>(new String[] { "Version 4", "Version 5" });
		cdmVersion.setToolTipText("Select the appropriate CDM version");
		cdmVersionPanel.add(cdmVersion);
		cdmVersionPanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, cdmVersionPanel.getPreferredSize().height));
		panel.add(cdmVersionPanel);

		panel.add(Box.createVerticalGlue());

		JPanel structureButtonPanel = new JPanel();
		structureButtonPanel.setLayout(new BoxLayout(structureButtonPanel, BoxLayout.X_AXIS));
		structureButtonPanel.add(Box.createHorizontalGlue());

		JButton structureButton = new JButton("Create structure");
		structureButton.setBackground(new Color(151, 220, 141));
		structureButton.setToolTipText("Create the table structures for the CDM");
		structureButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				createStructure();
			}
		});
		componentsToDisableWhenRunning.add(structureButton);
		structureButtonPanel.add(structureButton);
		panel.add(structureButtonPanel);

		return panel;
	}

	private JPanel createErasPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

		JPanel cdmVersionPanel = new JPanel();
		cdmVersionPanel.setLayout(new BoxLayout(cdmVersionPanel, BoxLayout.X_AXIS));
		cdmVersionPanel.setBorder(BorderFactory.createTitledBorder("CDM version"));
		cdmVersionForEras = new JComboBox<String>(new String[] { "Version 4", "Version 5" });
		cdmVersionForEras.setToolTipText("Select the appropriate CDM version");
		cdmVersionPanel.add(cdmVersionForEras);
		cdmVersionPanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, cdmVersionPanel.getPreferredSize().height));
		panel.add(cdmVersionPanel);

		JPanel domainPanel = new JPanel();
		domainPanel.setLayout(new BoxLayout(domainPanel, BoxLayout.X_AXIS));
		domainPanel.setBorder(BorderFactory.createTitledBorder("Domain"));
		domainForEras = new JComboBox<String>(new String[] { "Drugs", "Conditions" });
		domainForEras.setToolTipText("Select the appropriate domain");
		domainPanel.add(domainForEras);
		domainPanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, cdmVersionPanel.getPreferredSize().height));
		panel.add(domainPanel);

		panel.add(Box.createVerticalGlue());

		JPanel indicesButtonPanel = new JPanel();
		indicesButtonPanel.setLayout(new BoxLayout(indicesButtonPanel, BoxLayout.X_AXIS));
		indicesButtonPanel.add(Box.createHorizontalGlue());

		JButton erasButton = new JButton("Create eras");
		erasButton.setBackground(new Color(151, 220, 141));
		erasButton.setToolTipText("Create the eras for the CDM");
		erasButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				createEras();
			}
		});
		componentsToDisableWhenRunning.add(erasButton);
		indicesButtonPanel.add(erasButton);
		panel.add(indicesButtonPanel);

		return panel;
	}

	private JPanel createIndicesPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

		JPanel cdmVersionPanel = new JPanel();
		cdmVersionPanel.setLayout(new BoxLayout(cdmVersionPanel, BoxLayout.X_AXIS));
		cdmVersionPanel.setBorder(BorderFactory.createTitledBorder("CDM version"));
		cdmVersionForIndices = new JComboBox<String>(new String[] { "Version 4", "Version 5" });
		cdmVersionForIndices.setToolTipText("Select the appropriate CDM version");
		cdmVersionPanel.add(cdmVersionForIndices);
		cdmVersionPanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, cdmVersionPanel.getPreferredSize().height));
		panel.add(cdmVersionPanel);

		panel.add(Box.createVerticalGlue());

		JPanel indicesButtonPanel = new JPanel();
		indicesButtonPanel.setLayout(new BoxLayout(indicesButtonPanel, BoxLayout.X_AXIS));
		indicesButtonPanel.add(Box.createHorizontalGlue());

		JButton indicesButton = new JButton("Create indices");
		indicesButton.setBackground(new Color(151, 220, 141));
		indicesButton.setToolTipText("Create the recommended indices for the CDM");
		indicesButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				createIndices();
			}
		});
		componentsToDisableWhenRunning.add(indicesButton);
		indicesButtonPanel.add(indicesButton);
		panel.add(indicesButtonPanel);

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

	private void executeParameters(String[] args) {
		String mode = null;
		for (String arg : args) {
			if (arg.startsWith("-")) {
				mode = arg.toLowerCase();
				if (mode.equals("-executeetl"))
					executeEtlWhenReady = true;
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

	private void pickVocabFile() {
		JFileChooser fileChooser = new JFileChooser(new File(folderField.getText()));
		fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int returnVal = fileChooser.showDialog(frame, "Select vocabulary file");
		if (returnVal == JFileChooser.APPROVE_OPTION)
			vocabFileField.setText(DirectoryUtilities.getRelativePath(new File(folderField.getText()), fileChooser.getSelectedFile()));
	}

	private DbSettings getSourceDbSettings() {
		DbSettings dbSettings = new DbSettings();
		if (sourceType.getSelectedItem().equals("Delimited text files")) {
			dbSettings.dataType = DbSettings.CSVFILES;
			if (sourceDelimiterField.getText().length() == 0) {
				JOptionPane.showMessageDialog(frame, "Delimiter field cannot be empty for source database", "Error connecting to server",
						JOptionPane.ERROR_MESSAGE);
				return null;
			}
			if (sourceDelimiterField.getText().toLowerCase().equals("tab"))
				dbSettings.delimiter = '\t';
			else
				dbSettings.delimiter = sourceDelimiterField.getText().charAt(0);
		} else {
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

	private void createStructure() {
		StructureThread structureThread = new StructureThread();
		structureThread.start();
	}

	private void createIndices() {
		IndexThread indexThread = new IndexThread();
		indexThread.start();
	}

	private void createEras() {
		EraThread eraThread = new EraThread();
		eraThread.start();
	}

	private void vocabRun() {
		VocabRunThread thread = new VocabRunThread();
		thread.start();
	}

	private class EtlThread extends Thread {

		private int	maxPersons;

		public EtlThread(int maxPersons) {
			this.maxPersons = maxPersons;
		}

		public void run() {
			for (JComponent component : componentsToDisableWhenRunning)
				component.setEnabled(false);

			try {
				if (etlType.getSelectedItem().equals("Load CSV files in CDM format to server")) {
					CdmEtl etl = new CdmEtl();
					DbSettings dbSettings = getTargetDbSettings();
					testConnection(dbSettings, false);
					if (dbSettings != null)
						etl.process(folderField.getText(), dbSettings, maxPersons);
				}
				if (etlType.getSelectedItem().equals("ARS -> OMOP CDM V4")) {
					ARSETL etl = new ARSETL();
					DbSettings dbSettings = getTargetDbSettings();
					testConnection(dbSettings, false);
					if (dbSettings != null)
						etl.process(folderField.getText(), dbSettings, maxPersons);
				}
				if (etlType.getSelectedItem().equals("HCUP -> OMOP CDM V4")) {
					HCUPETL etl = new HCUPETL();
					DbSettings sourceDbSettings = getSourceDbSettings();
					DbSettings targetDbSettings = getTargetDbSettings();
					if (sourceDbSettings != null && targetDbSettings != null) {
						testConnection(sourceDbSettings, true);
						testConnection(targetDbSettings, false);
						etl.process(folderField.getText(), sourceDbSettings, targetDbSettings, maxPersons);
					}
				}
				if (etlType.getSelectedItem().equals("HCUP -> OMOP CDM V5")) {
					HCUPETLToV5 etl = new HCUPETLToV5();
					DbSettings sourceDbSettings = getSourceDbSettings();
					DbSettings targetDbSettings = getTargetDbSettings();
					if (sourceDbSettings != null && targetDbSettings != null) {
						testConnection(sourceDbSettings, true);
						testConnection(targetDbSettings, false);
						etl.process(folderField.getText(), sourceDbSettings, targetDbSettings, maxPersons);
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
				InsertVocabularyInServer process = new InsertVocabularyInServer();
				DbSettings dbSettings = getTargetDbSettings();
				if (dbSettings != null)
					process.process(folderField.getText() + "/" + vocabFileField.getText(), dbSettings);
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
				int version = cdmVersion.getSelectedItem().equals("Version 5") ? 5 : 4;
				Cdm.createStructure(dbSettings, version);
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
				int version = cdmVersionForIndices.getSelectedItem().equals("Version 5") ? Cdm.VERSION_5 : Cdm.VERSION_4;
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

		public void run() {
			for (JComponent component : componentsToDisableWhenRunning)
				component.setEnabled(false);
			try {
				DbSettings dbSettings = getTargetDbSettings();
				int version = cdmVersionForEras.getSelectedItem().equals("Version 5") ? EraBuilder.VERSION_5 : EraBuilder.VERSION_4;
				int domain = domainForEras.getSelectedItem().equals("Drugs") ? EraBuilder.DRUG_ERA : EraBuilder.CONDITION_ERA;
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

}
