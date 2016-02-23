/*******************************************************************************
 * Copyright 2016 Observational Health Data Sciences and Informatics
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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.ohdsi.jCdmBuilder.utilities.CodeToConceptMap;
import org.ohdsi.jCdmBuilder.utilities.CodeToConceptMap.CodeData;
import org.ohdsi.jCdmBuilder.utilities.CodeToDomainConceptMap;
import org.ohdsi.jCdmBuilder.utilities.CodeToDomainConceptMap.CodeDomainData;
import org.ohdsi.jCdmBuilder.utilities.CodeToDomainConceptMap.TargetConcept;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.collections.CountingSet;
import org.ohdsi.utilities.collections.IntegerComparator;
import org.ohdsi.utilities.collections.OneToManyList;
import org.ohdsi.utilities.files.MultiRowIterator.MultiRowSet;

/**
 * Class for creating an ETL report with details of the ETL, including any errors. Two types of report can be generated: The ETL report itself contains
 * high-level statistics, the Problem report contains patient-specific error messages.
 * 
 * @author MSCHUEMI
 * 
 */
public class EtlReport {

	public static long				MAX_REPORT_PROBLEM		= 1000;

	private Map<String, Problem>	problems				= new HashMap<String, Problem>();
	private CountingSet<String>		incomingTableRowCounts	= new CountingSet<String>();
	private CountingSet<String>		outgoingTableRowCounts	= new CountingSet<String>();
	private String					folder;
	private long					totalProblemCount		= 0;

	/**
	 * 
	 * @param folder
	 *            Folder where the ETL and Problem report will be generated
	 */
	public EtlReport(String folder) {
		this.folder = folder;
	}

	/**
	 * Report a problem to be mentioned in the ETL and Problem report
	 * 
	 * @param table
	 *            Name of the relevant table
	 * @param problemType
	 *            Type of problem. Error counts will be aggregated by problemType in the ETL report
	 * @param personId
	 *            The person_id for which the problem was found
	 */
	public void reportProblem(String table, String problemType, String personId) {
		totalProblemCount++;
		Problem problem = problems.get(table + "\t" + problemType);
		if (problem == null) {
			problem = new Problem();
			problem.problemType = problemType;
			problem.table = table;
			problems.put(table + "\t" + problemType, problem);
		}
		problem.count++;
		if (problem.count < MAX_REPORT_PROBLEM)
			problem.personId.add(personId);
		if (problem.count == MAX_REPORT_PROBLEM)
			System.out.println("Warning: encountered " + MAX_REPORT_PROBLEM + " problems of type '" + problemType + "' in table " + table);
	}

	/**
	 * 
	 * @return the total number of problems reported during the ETL
	 */
	public long getTotalProblemCount() {
		return totalProblemCount;
	}

	/**
	 * Generates the patient-specific Problem report
	 * 
	 * @return The full path to the generated Problem report
	 */
	public String generateProblemReport() {
		StringUtilities.outputWithTime("Generating ETL problem list");
		String filename = generateETLProblemListFilename(folder);
		XSSFWorkbook workbook = new XSSFWorkbook();

		XSSFSheet sheet = workbook.createSheet("Problems");
		addRow(sheet, "Table", "Problem", "Person_id");
		for (Problem problem : problems.values()) {
			for (String personId : problem.personId)
				addRow(sheet, problem.table, problem.problemType, personId);
			// for (int i = 0; i < Math.min(MAX_REPORT_PROBLEM, problem.count); i++)
			// addRow(sheet, problem.table, problem.problemType, problem.personId.get(i));
			if (problem.count > MAX_REPORT_PROBLEM)
				addRow(sheet, problem.table, problem.problemType, "in " + (problem.count - MAX_REPORT_PROBLEM) + " other persons");
		}
		try {
			FileOutputStream out = new FileOutputStream(new File(filename));
			workbook.write(out);
			out.close();
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
		return filename;
	}

	/**
	 * Generates the overall ETL report
	 * 
	 * @param codeToConceptMaps
	 *            the codeToConceptMaps used in the ETL
	 * @return the full path to the ETL report
	 */
	public String generateETLReport(CodeToConceptMap... codeToConceptMaps) {
		return generateETLReport(codeToConceptMaps, CodeToConceptMap.class);
	}

	public String generateETLReport(CodeToDomainConceptMap... codeToDomainConceptMaps) {
		return generateETLReport(codeToDomainConceptMaps, CodeToDomainConceptMap.class);
	}

	private String generateETLReport(Object codeData, Class<?> codeDataClass) {
		StringUtilities.outputWithTime("Generating ETL report");
		String filename = generateFilename(folder);
		XSSFWorkbook workbook = new XSSFWorkbook();

		XSSFSheet sheet = workbook.createSheet("Overview");
		addRow(sheet, "Source tables");
		addRow(sheet, "");
		addRow(sheet, "Table name", "Number of records");
		for (String table : incomingTableRowCounts)
			addRow(sheet, table, Integer.valueOf(incomingTableRowCounts.getCount(table)));
		addRow(sheet, "");

		addRow(sheet, "CDM tables");
		addRow(sheet, "");
		addRow(sheet, "Table name", "Number of records");
		for (String table : outgoingTableRowCounts)
			addRow(sheet, table, Integer.valueOf(outgoingTableRowCounts.getCount(table)));
		addRow(sheet, "");

		addRow(sheet, "Number of problems encountered", Long.valueOf(totalProblemCount));
		addRow(sheet, "");
		addRow(sheet, "Mapping", "Mapped unique codes", "Unmapped unique codes", "Mapped total codes", "Unmapped total codes");

		XSSFSheet problemSheet = workbook.createSheet("Problems");
		addRow(problemSheet, "Table", "Description", "Nr of rows");
		for (Problem problem : problems.values())
			addRow(problemSheet, problem.table, problem.problemType, Long.valueOf(problem.count));

		if (codeDataClass == CodeToDomainConceptMap.class)
			addCodeMappingInfo((CodeToDomainConceptMap[]) codeData, sheet, workbook);
		else
			addCodeMappingInfo((CodeToConceptMap[]) codeData, sheet, workbook);

		try {
			FileOutputStream out = new FileOutputStream(new File(filename));
			workbook.write(out);
			out.close();
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}

		return filename;
	}

	private void addCodeMappingInfo(CodeToConceptMap[] codeToConceptMaps, XSSFSheet sheet, XSSFWorkbook workbook) {
		for (CodeToConceptMap codeToConceptMap : codeToConceptMaps) {
			int uniqueMapped = 0;
			int uniqueUnmapped = 0;
			long totalMapped = 0;
			long totalUnmapped = 0;
			CountingSet<String> codeCounts = codeToConceptMap.getCodeCounts();
			for (String code : codeCounts) {
				if (!codeToConceptMap.getConceptId(code).equals(0)) {
					uniqueMapped++;
					totalMapped += codeCounts.getCount(code);
				} else {
					uniqueUnmapped++;
					totalUnmapped += codeCounts.getCount(code);
				}
			}
			addRow(sheet, codeToConceptMap.getName(), Integer.valueOf(uniqueMapped), Integer.valueOf(uniqueUnmapped), Long.valueOf(totalMapped),
					Long.valueOf(totalUnmapped));
		}

		sheet = workbook.createSheet("Problems");
		addRow(sheet, "Table", "Description", "Nr of rows");
		for (Problem problem : problems.values())
			addRow(sheet, problem.table, problem.problemType, Long.valueOf(problem.count));

		for (CodeToConceptMap codeToConceptMap : codeToConceptMaps) {
			sheet = workbook.createSheet(codeToConceptMap.getName());
			addRow(sheet, "Frequency", "Source code", "Source code description", "Target concept ID", "Target code", "Target concept description");
			CountingSet<String> codeCounts = codeToConceptMap.getCodeCounts();
			List<Map.Entry<String, CountingSet.Count>> codes = new ArrayList<Map.Entry<String, CountingSet.Count>>(codeCounts.key2count.entrySet());
			reverseFrequencySort(codes);
			for (Map.Entry<String, CountingSet.Count> code : codes) {
				CodeData codeData = codeToConceptMap.getCodeData(code.getKey());
				if (codeData == null)
					addRow(sheet, Integer.valueOf(code.getValue().count), code.getKey(), "", Integer.valueOf(0), "", "");
				else
					for (int i = 0; i < codeData.targetConceptIds.length; i++)
						addRow(sheet, Integer.valueOf(code.getValue().count), code.getKey(), codeData.description,
								Integer.valueOf(codeData.targetConceptIds[i]), codeData.targetCodes[i], codeData.targetDescriptions[i]);
			}
		}
	}

	private void addCodeMappingInfo(CodeToDomainConceptMap[] codeToDomainConceptMaps, XSSFSheet sheet, XSSFWorkbook workbook) {
		for (CodeToDomainConceptMap codeToDomainConceptMap : codeToDomainConceptMaps) {
			int uniqueMapped = 0;
			int uniqueUnmapped = 0;
			long totalMapped = 0;
			long totalUnmapped = 0;
			CountingSet<String> codeCounts = codeToDomainConceptMap.getCodeCounts();
			for (String code : codeCounts) {
				if (codeToDomainConceptMap.hasMapping(code)) {
					uniqueMapped++;
					totalMapped += codeCounts.getCount(code);
				} else {
					uniqueUnmapped++;
					totalUnmapped += codeCounts.getCount(code);
				}
			}
			addRow(sheet, codeToDomainConceptMap.getName(), Integer.valueOf(uniqueMapped), Integer.valueOf(uniqueUnmapped), Long.valueOf(totalMapped),
					Long.valueOf(totalUnmapped));
		}

		for (CodeToDomainConceptMap codeToDomainConceptMap : codeToDomainConceptMaps) {
			sheet = workbook.createSheet(codeToDomainConceptMap.getName());
			addRow(sheet, "Frequency", "Source code", "Source code description", "Target domain", "Target concept ID", "Target code",
					"Target concept description");
			CountingSet<String> codeCounts = codeToDomainConceptMap.getCodeCounts();
			List<Map.Entry<String, CountingSet.Count>> codes = new ArrayList<Map.Entry<String, CountingSet.Count>>(codeCounts.key2count.entrySet());
			reverseFrequencySort(codes);
			for (Map.Entry<String, CountingSet.Count> code : codes) {
				CodeDomainData codeData = codeToDomainConceptMap.getCodeData(code.getKey());
				for (TargetConcept targetConcept : codeData.targetConcepts)
					addRow(sheet, Integer.valueOf(code.getValue().count), code.getKey(), codeData.sourceConceptName, targetConcept.domainId,
							Integer.valueOf(targetConcept.conceptId), targetConcept.conceptCode, targetConcept.conceptName);
			}
		}
	}

	private void reverseFrequencySort(List<Entry<String, CountingSet.Count>> codes) {
		Collections.sort(codes, new Comparator<Entry<String, CountingSet.Count>>() {

			@Override
			public int compare(Entry<String, CountingSet.Count> o1, Entry<String, CountingSet.Count> o2) {
				return -IntegerComparator.compare(o1.getValue().count, o2.getValue().count);
			}
		});

	}

	private void addRow(XSSFSheet sheet, Object... values) {
		Row row = sheet.createRow(sheet.getPhysicalNumberOfRows());
		for (Object value : values) {
			Cell cell = row.createCell(row.getPhysicalNumberOfCells());

			if (value instanceof Integer && value instanceof Long && value instanceof Double)
				cell.setCellValue(Double.valueOf(value.toString()));
			else
				cell.setCellValue(value.toString());

		}
	}

	private String generateFilename(String folder) {
		String filename = folder + "/ETLReport.xlsx";
		int i = 1;
		while (new File(filename).exists())
			filename = folder + "/ETLReport" + (i++) + ".xlsx";
		return filename;
	}

	private String generateETLProblemListFilename(String folder) {
		String filename = folder + "/ETLProblems.xlsx";
		int i = 1;
		while (new File(filename).exists())
			filename = folder + "/ETLPRoblems" + (i++) + ".xlsx";
		return filename;
	}

	/**
	 * Register source data of 1 person. Use this function for datasets with 1 table, and 1 row per person.
	 * 
	 * @param table
	 *            Name of the source table
	 * @param row
	 *            Row in the source table containing all data for 1 person
	 */
	public void registerIncomingData(String table, org.ohdsi.utilities.files.Row row) {
		incomingTableRowCounts.add(table, 1);
	}

	/**
	 * Register source data of 1 person
	 * 
	 * @param multiRowSet
	 *            The set of rows in one or several tables containing all data for 1 person
	 */

	public void registerIncomingData(MultiRowSet data) {
		for (String table : data.keySet())
			incomingTableRowCounts.add(table, data.get(table).size());
	}

	public void registerOutgoingData(OneToManyList<String, org.ohdsi.utilities.files.Row> data) {
		for (String table : data.keySet())
			outgoingTableRowCounts.add(table, data.get(table).size());
	}

	private class Problem {
		public String		table;
		public String		problemType;
		public long			count		= 0;
		public List<String>	personId	= new ArrayList<String>();
	}
}
