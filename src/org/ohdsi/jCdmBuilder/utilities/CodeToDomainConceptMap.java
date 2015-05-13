package org.ohdsi.jCdmBuilder.utilities;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ohdsi.utilities.collections.CountingSet;

public class CodeToDomainConceptMap {

	private String						name;
	private Map<String, CodeDomainData>	codeToData	= new HashMap<String, CodeDomainData>();
	private CountingSet<String>			codeCounts	= new CountingSet<String>();
	private CodeDomainData				unmappedData;

	public CodeToDomainConceptMap(String name, String defaultDomain) {
		this.name = name;
		unmappedData = new CodeDomainData();
		unmappedData.sourceConceptName = "";
		unmappedData.sourceConceptId = 0;
		TargetConcept targetConcept = new TargetConcept();
		targetConcept.conceptCode = "";
		targetConcept.conceptId = 0;
		targetConcept.conceptName = "";
		targetConcept.domainId = defaultDomain;
		unmappedData.targetConcepts.add(targetConcept);
	}

	public void add(String sourceConceptCode, String sourceConceptName, int sourceConceptId, int targetConceptId, String targetConceptCode,
			String targetConceptName, String targetDomainId) {
		CodeDomainData data = codeToData.get(sourceConceptCode);
		if (data == null) {
			data = new CodeDomainData();
			data.sourceConceptName = sourceConceptName;
			data.sourceConceptId = sourceConceptId;
			codeToData.put(sourceConceptCode, data);
		}
		TargetConcept targetConcept = new TargetConcept();
		targetConcept.conceptCode = targetConceptCode;
		targetConcept.conceptId = targetConceptId;
		targetConcept.conceptName = targetConceptName;
		targetConcept.domainId = targetDomainId;
		data.targetConcepts.add(targetConcept);

	}

	public String getName() {
		return name;
	}

	public CountingSet<String> getCodeCounts() {
		return codeCounts;
	}

	public CodeDomainData getCodeData(String code) {
		codeCounts.add(code);
		CodeDomainData data = codeToData.get(code);
		if (data == null) {
			return unmappedData;
		} else
			return data;
	}

	public class CodeDomainData {
		public String				sourceConceptName;
		public int					sourceConceptId;
		public List<TargetConcept>	targetConcepts	= new ArrayList<CodeToDomainConceptMap.TargetConcept>();
	}

	public class TargetConcept {
		public int		conceptId;
		public String	conceptCode;
		public String	conceptName;
		public String	domainId;
	}

	public boolean hasMapping(String code) {
		return codeToData.containsKey(code);
	}
}
