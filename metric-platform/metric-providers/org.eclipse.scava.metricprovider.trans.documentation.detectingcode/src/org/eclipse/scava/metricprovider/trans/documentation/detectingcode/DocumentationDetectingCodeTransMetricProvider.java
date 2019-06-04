package org.eclipse.scava.metricprovider.trans.documentation.detectingcode;

import java.util.Arrays;
import java.util.List;
import org.eclipse.scava.metricprovider.trans.documentation.DocumentationTransMetricProvider;
import org.eclipse.scava.metricprovider.trans.documentation.detectingcode.model.DocumentationDetectingCodeTransMetric;
import org.eclipse.scava.metricprovider.trans.documentation.detectingcode.model.DocumentationEntryDetectingCode;
import org.eclipse.scava.metricprovider.trans.documentation.model.DocumentationEntry;
import org.eclipse.scava.metricprovider.trans.documentation.model.DocumentationTransMetric;
import org.eclipse.scava.metricprovider.trans.indexing.preparation.IndexPreparationTransMetricProvider;
import org.eclipse.scava.metricprovider.trans.indexing.preparation.model.IndexPrepTransMetric;
import org.eclipse.scava.nlp.classifiers.codedetector.CodeDetector;
import org.eclipse.scava.nlp.tools.predictions.singlelabel.SingleLabelPredictionCollection;
import org.eclipse.scava.platform.IMetricProvider;
import org.eclipse.scava.platform.ITransientMetricProvider;
import org.eclipse.scava.platform.MetricProviderContext;
import org.eclipse.scava.repository.model.CommunicationChannel;
import org.eclipse.scava.repository.model.Project;
import org.eclipse.scava.repository.model.VcsRepository;
import org.eclipse.scava.repository.model.documentation.gitbased.DocumentationGitBased;
import org.eclipse.scava.repository.model.documentation.systematic.DocumentationSystematic;
import org.eclipse.scava.platform.delta.ProjectDelta;
import org.eclipse.scava.platform.delta.communicationchannel.PlatformCommunicationChannelManager;
import org.eclipse.scava.platform.delta.vcs.PlatformVcsManager;

import com.mongodb.DB;

public class DocumentationDetectingCodeTransMetricProvider implements ITransientMetricProvider<DocumentationDetectingCodeTransMetric> {

	
	protected PlatformVcsManager platformVcsManager;
	protected PlatformCommunicationChannelManager communicationChannelManager;
	
	protected List<IMetricProvider> uses;
	protected MetricProviderContext context;
	
	@Override
	public String getIdentifier() {
		return DocumentationDetectingCodeTransMetricProvider.class.getCanonicalName();
	}

	@Override
	public String getShortIdentifier() {
		return "trans.documentation.detectingcode";
	}

	@Override
	public String getFriendlyName() {
		return "Documentation detection of code";
	}

	@Override
	public String getSummaryInformation() {
		return "This metric process the plain text from documentation and detects the portions corresponding to code and antural language.";
	}

	@Override
	public boolean appliesTo(Project project) {
		for(VcsRepository repository : project.getVcsRepositories())
			if(repository instanceof DocumentationGitBased) return true;
		for (CommunicationChannel communicationChannel: project.getCommunicationChannels())
			if (communicationChannel instanceof DocumentationSystematic) return true;
		return false;
	}

	@Override
	public void setUses(List<IMetricProvider> uses) {
		this.uses=uses;
		
	}

	@Override
	public List<String> getIdentifiersOfUses() {
		return Arrays.asList(IndexPreparationTransMetricProvider.class.getCanonicalName(),DocumentationTransMetricProvider.class.getCanonicalName());
	}

	@Override
	public void setMetricProviderContext(MetricProviderContext context) {
		this.context=context;
		this.communicationChannelManager= context.getPlatformCommunicationChannelManager();
		this.platformVcsManager=context.getPlatformVcsManager();
	}

	@Override
	public DocumentationDetectingCodeTransMetric adapt(DB db) {
		return new DocumentationDetectingCodeTransMetric(db);
	}

	@Override
	public void measure(Project project, ProjectDelta delta, DocumentationDetectingCodeTransMetric db) {
		
		db.getDocumentationEntriesDetectingCode().getDbCollection().drop();
		db.sync();
		
		//This is for the indexing
		IndexPrepTransMetric indexPrepTransMetric = ((IndexPreparationTransMetricProvider)uses.get(0)).adapt(context.getProjectDB(project));	
		indexPrepTransMetric.getExecutedMetricProviders().first().getMetricIdentifiers().add(getIdentifier());
		indexPrepTransMetric.sync();
		
		DocumentationTransMetric documentationProcessor = ((DocumentationTransMetricProvider)uses.get(1)).adapt(context.getProjectDB(project));
		
		Iterable<DocumentationEntry> documentationEntries = documentationProcessor.getDocumentationEntries();
		
		SingleLabelPredictionCollection predictions;
		
		for(DocumentationEntry documentationEntry : documentationEntries)
		{
			DocumentationEntryDetectingCode documentationEntryDetectingCode = findDocumentationEntryDetectingCode(db, documentationEntry);
			if(documentationEntryDetectingCode==null)
			{
				documentationEntryDetectingCode= new DocumentationEntryDetectingCode();
				documentationEntryDetectingCode.setDocumentationId(documentationEntry.getDocumentationId());
				documentationEntryDetectingCode.setEntryId(documentationEntry.getEntryId());
				db.getDocumentationEntriesDetectingCode().add(documentationEntryDetectingCode);
			}
			predictions = CodeDetector.predict(documentationEntry.getPlainText());
			
			documentationEntryDetectingCode.setCode(String.join("\n", predictions.getTextsPredictedWithLabel("__label__Code")));
			
			documentationEntryDetectingCode.setNaturalLanguage(String.join(" ", predictions.getTextsPredictedWithLabel("__label__English")));
			
			db.sync();
		}
		
	}
	
	private DocumentationEntryDetectingCode findDocumentationEntryDetectingCode (DocumentationDetectingCodeTransMetric db, DocumentationEntry documentationEntry)
	{
		DocumentationEntryDetectingCode documentationEntryDetectingCode = null;
		Iterable<DocumentationEntryDetectingCode> documentationEntryDCIt = db.getDocumentationEntriesDetectingCode().
				find(DocumentationEntry.DOCUMENTATIONID.eq(documentationEntry.getDocumentationId()),
						DocumentationEntry.ENTRYID.eq(documentationEntry.getEntryId()));
		for(DocumentationEntryDetectingCode dedc : documentationEntryDCIt)
			documentationEntryDetectingCode=dedc;
		return documentationEntryDetectingCode;
	}

}