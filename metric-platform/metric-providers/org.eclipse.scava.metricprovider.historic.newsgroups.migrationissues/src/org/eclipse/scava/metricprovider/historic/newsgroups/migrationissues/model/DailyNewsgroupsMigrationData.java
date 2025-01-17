package org.eclipse.scava.metricprovider.historic.newsgroups.migrationissues.model;

import java.util.List;

import com.googlecode.pongo.runtime.Pongo;
import com.googlecode.pongo.runtime.PrimitiveList;
import com.googlecode.pongo.runtime.querying.ArrayQueryProducer;
import com.googlecode.pongo.runtime.querying.NumericalQueryProducer;
import com.googlecode.pongo.runtime.querying.StringQueryProducer;
import com.mongodb.BasicDBList;


public class DailyNewsgroupsMigrationData extends Pongo {
	
	protected List<Integer> threadsId = null;
	
	
	public DailyNewsgroupsMigrationData() { 
		super();
		dbObject.put("threadsId", new BasicDBList());
		NEWSGROUPNAME.setOwningType("org.eclipse.scava.metricprovider.historic.newsgroups.migrationissues.model.DailyNewsgroupsMigrationData");
		THREADSID.setOwningType("org.eclipse.scava.metricprovider.historic.newsgroups.migrationissues.model.DailyNewsgroupsMigrationData");
		NUMBEROFISSUES.setOwningType("org.eclipse.scava.metricprovider.historic.newsgroups.migrationissues.model.DailyNewsgroupsMigrationData");
	}
	
	public static StringQueryProducer NEWSGROUPNAME = new StringQueryProducer("newsgroupName"); 
	public static NumericalQueryProducer NUMBEROFISSUES = new NumericalQueryProducer("numberOfIssues");
	public static ArrayQueryProducer THREADSID = new ArrayQueryProducer("threadsId");
	
	
	public String getNewsgroupName() {
		return parseString(dbObject.get("newsgroupName")+"", "");
	}
	
	public DailyNewsgroupsMigrationData setNewsgroupName(String newsgroupName) {
		dbObject.put("newsgroupName", newsgroupName);
		notifyChanged();
		return this;
	}
	public int getNumberOfIssues() {
		return parseInteger(dbObject.get("numberOfIssues")+"", 0);
	}
	
	public DailyNewsgroupsMigrationData setNumberOfIssues(int numberOfIssues) {
		dbObject.put("numberOfIssues", numberOfIssues);
		notifyChanged();
		return this;
	}
	
	public List<Integer> getThreadsId() {
		if (threadsId == null) {
			threadsId = new PrimitiveList<Integer>(this, (BasicDBList) dbObject.get("threadsId"));
		}
		return threadsId;
	}
	
	
	
}