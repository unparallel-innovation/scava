package org.eclipse.scava.crossflow.runtime;

import java.io.Serializable;
import java.util.UUID;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class Job implements Serializable {

	private static final long serialVersionUID = 431981L;

	public Job() {
		this.id = UUID.randomUUID().toString();
	}

	public String toString() {
		return id + " " + correlationId + " " + destination + " " + cacheable + " " + failures;
	}

	protected String id;
	protected String correlationId;
	protected String destination;
	protected boolean cached = false;
	protected int failures = 0;
	protected boolean cacheable = true;
	// sets whether this job requires a transactional level of caching (usually due
	// to being created multiple times per single task)
	protected boolean transactional = true;
	// denotes that this job is a simple message denoting success of a transaction
	// (with this correlationId and to totalOutputs # of channels)
	private boolean isTransactionSuccessMessage = false;	
	private int totalOutputs = 0; 

	public boolean isTransactional() {
		return transactional;
	}

	public void setTransactional(boolean transactional) {
		this.transactional = transactional;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setCorrelationId(String correlationId) {
		this.correlationId = correlationId;
	}

	public String getCorrelationId() {
		return correlationId;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getDestination() {
		return destination;
	}

	public boolean isCached() {
		return cached;
	}

	public void setCached(boolean cached) {
		this.cached = cached;
	}

	public boolean isCacheable() {
		return cacheable;
	}

	public void setCacheable(boolean cacheable) {
		this.cacheable = cacheable;
	}

	public int getFailures() {
		return failures;
	}

	public void setFailures(int failures) {
		this.failures = failures;
	}

	public String getXML() {
		String id = this.id;
		int failures = this.getFailures();
		String correlationId = this.correlationId;
		boolean cached = this.cached;
		boolean cacheable = this.cacheable;

		this.id = null;
		this.correlationId = null;
		this.failures = 0;
		this.cached = false;
		this.cacheable = true;

		String xml = new XStream(new DomDriver()).toXML(this);

		this.id = id;
		this.correlationId = correlationId;
		this.cached = cached;
		this.failures = failures;
		this.cacheable = cacheable;

		return xml;
	}

	public String getHash() {
		// FIXME if two outputs have the same signature (aka if a task outputs two
		// identical elements) then duplicates are lost!
		return UUID.nameUUIDFromBytes(getXML().getBytes()).toString();
	}

	public boolean isTransactionSuccessMessage() {
		return isTransactionSuccessMessage;
	}

	public void setIsTransactionSuccessMessage(boolean isTransactionSuccessMessage) {
		this.isTransactionSuccessMessage = isTransactionSuccessMessage;
	}

	public int getTotalOutputs() {
		return totalOutputs;
	}

	public void setTotalOutputs(int totalOutputs) {
		this.totalOutputs = totalOutputs;
	}
	
}
