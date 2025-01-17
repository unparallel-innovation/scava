package org.eclipse.scava.crossflow.restmule.client.stackexchange.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ReputationHistory {

	public ReputationHistory(){}

	@JsonProperty("post_id") 
	private Integer postId;
	
	@JsonProperty("reputation_history_type") 
	private String reputationHistoryType;
	
	@JsonProperty("user_id") 
	private Integer userId;
	
	@JsonProperty("reputation_change") 
	private Integer reputationChange;
	
	@JsonProperty("creation_date") 
	private Integer creationDate;
	
	public Integer getPostId() {
		return this.postId;
	}
	
	public String getReputationHistoryType() {
		return this.reputationHistoryType;
	}
	
	public Integer getUserId() {
		return this.userId;
	}
	
	public Integer getReputationChange() {
		return this.reputationChange;
	}
	
	public Integer getCreationDate() {
		return this.creationDate;
	}
	
	@Override
	public String toString() {
		return "ReputationHistory [ "
			+ "postId = " + this.postId + ", "
			+ "reputationHistoryType = " + this.reputationHistoryType + ", "
			+ "userId = " + this.userId + ", "
			+ "reputationChange = " + this.reputationChange + ", "
			+ "creationDate = " + this.creationDate + ", "
			+ "]"; 
	}	
}	
