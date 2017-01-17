package org.ohdsi.jCdmBuilder.etls.cdm;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.ohdsi.databases.RichConnection;
import org.ohdsi.jCdmBuilder.DbSettings;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.files.ReadCSVFileWithHeader;
import org.ohdsi.utilities.files.Row;

public class CdmEtl {
	
	public void process(String folder, DbSettings dbSettings, int maxPersons, int versionId) {
		RichConnection connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		connection.use(dbSettings.database);
		
		Set<String> tables = new HashSet<String>();
		for (String table : connection.getTableNames(dbSettings.database))
			tables.add(table.toLowerCase());
		
		connection.execute("TRUNCATE TABLE _version");
		String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		connection.execute("INSERT INTO _version (version_id, version_date) VALUES (" + versionId + ", '" + date + "')");
		
		for (File file : new File(folder).listFiles()) {
			if (file.getName().toLowerCase().endsWith(".csv")) {
				String table = file.getName().substring(0, file.getName().length() - 4);
				if (tables.contains(table.toLowerCase())) {
					StringUtilities.outputWithTime("Inserting data for table " + table);
					connection.execute("TRUNCATE " + table);
					Iterator<Row> iterator = new ReadCSVFileWithHeader(file.getAbsolutePath()).iterator();
					Iterator<Row> filteredIterator = new RowFilterIterator(iterator, connection.getFieldNames(table), table);
					connection.insertIntoTable(filteredIterator, table, false, true);
				}
			}
		}
		System.out.println("Finished inserting tables");
	}
	
	private static class RowFilterIterator implements Iterator<Row> {
		
		private Set<String>		allowedFields;
		private Iterator<Row>	iterator;
		private Set<String>		ignoredFields;
		
		public RowFilterIterator(Iterator<Row> iterator, Collection<String> allowedFields, String tableName) {
			this.allowedFields = new HashSet<String>();
			for (String field : allowedFields)
				this.allowedFields.add(field.toLowerCase());
			this.iterator = iterator;
			ignoredFields = new HashSet<String>();
		}
		
		@Override
		public boolean hasNext() {
			return iterator.hasNext();
		}
		
		@Override
		public Row next() {
			Row row = iterator.next();
			Row filteredRow = new Row();
			for (String fieldName : row.getFieldNames()) {
				String normFieldName = fieldName.toLowerCase().trim();
				if (allowedFields.contains(normFieldName))
					filteredRow.add(normFieldName, row.get(fieldName));
				else if (ignoredFields.add(fieldName))
					System.err.println("Ignoring field " + fieldName);
			}
			return filteredRow;
		}
		
		@Override
		public void remove() {
			throw new RuntimeException("Calling unimplemented method");
		}
	}
}
