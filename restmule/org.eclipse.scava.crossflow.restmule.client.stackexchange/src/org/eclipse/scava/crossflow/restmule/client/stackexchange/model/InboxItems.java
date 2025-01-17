package org.eclipse.scava.crossflow.restmule.client.stackexchange.model;

import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class InboxItems {

	public InboxItems(){}

	@JsonProperty("item_type") 
	private String itemType;
	
	@JsonProperty("is_unread") 
	private Boolean isUnread;
	
	@JsonProperty("link") 
	private String link;
	
	@JsonProperty("creation_date") 
	private Integer creationDate;
	
	@JsonProperty("body") 
	private String body;
	
	@JsonProperty("comment_id") 
	private Integer commentId;
	
	@JsonProperty("title") 
	private String title;
	
	@JsonProperty("answer_id") 
	private Integer answerId;
	
	@JsonProperty("question_id") 
	private Integer questionId;
	
	@JsonProperty("site") 
	private Site site;
	
	public String getItemType() {
		return this.itemType;
	}
	
	public Boolean getIsUnread() {
		return this.isUnread;
	}
	
	public String getLink() {
		return this.link;
	}
	
	public Integer getCreationDate() {
		return this.creationDate;
	}
	
	public String getBody() {
		return this.body;
	}
	
	public Integer getCommentId() {
		return this.commentId;
	}
	
	public String getTitle() {
		return this.title;
	}
	
	public Integer getAnswerId() {
		return this.answerId;
	}
	
	public Integer getQuestionId() {
		return this.questionId;
	}
	
	public Site getSite() {
		return this.site;
	}
	
	@Override
	public String toString() {
		return "InboxItems [ "
			+ "itemType = " + this.itemType + ", "
			+ "isUnread = " + this.isUnread + ", "
			+ "link = " + this.link + ", "
			+ "creationDate = " + this.creationDate + ", "
			+ "body = " + this.body + ", "
			+ "commentId = " + this.commentId + ", "
			+ "title = " + this.title + ", "
			+ "answerId = " + this.answerId + ", "
			+ "questionId = " + this.questionId + ", "
			+ "site = " + this.site + ", "
			+ "]"; 
	}	
	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class Site {
	
		public Site(){}
	
		@JsonProperty("icon_url") 
		private String iconUrl;
		
		@JsonProperty("audience") 
		private String audience;
		
		@JsonProperty("favicon_url") 
		private String faviconUrl;
		
		@JsonProperty("site_type") 
		private String siteType;
		
		@JsonProperty("logo_url") 
		private String logoUrl;
		
		@JsonProperty("api_site_parameter") 
		private String apiSiteParameter;
		
		@JsonProperty("open_beta_date") 
		private Integer openBetaDate;
		
		@JsonProperty("site_state") 
		private String siteState;
		
		@JsonProperty("closed_beta_date") 
		private Integer closedBetaDate;
		
		@JsonProperty("site_url") 
		private String siteUrl;
		
		@JsonProperty("name") 
		private String name;
		
		@JsonProperty("high_resolution_icon_url") 
		private String highResolutionIconUrl;
		
		@JsonProperty("twitter_account") 
		private String twitterAccount;
		
		@JsonProperty("launch_date") 
		private Integer launchDate;
		
		@JsonProperty("styling") 
		private Styling styling;
		
		@JsonProperty("aliases") 
		private List<Object> aliases = new ArrayList<Object>();
		
		@JsonProperty("related_sites") 
		private List<Object> relatedSites = new ArrayList<Object>();
		
		@JsonProperty("markdown_extensions") 
		private List<Object> markdownExtensions = new ArrayList<Object>();
		
		public String getIconUrl() {
			return this.iconUrl;
		}
		
		public String getAudience() {
			return this.audience;
		}
		
		public String getFaviconUrl() {
			return this.faviconUrl;
		}
		
		public String getSiteType() {
			return this.siteType;
		}
		
		public String getLogoUrl() {
			return this.logoUrl;
		}
		
		public String getApiSiteParameter() {
			return this.apiSiteParameter;
		}
		
		public Integer getOpenBetaDate() {
			return this.openBetaDate;
		}
		
		public String getSiteState() {
			return this.siteState;
		}
		
		public Integer getClosedBetaDate() {
			return this.closedBetaDate;
		}
		
		public String getSiteUrl() {
			return this.siteUrl;
		}
		
		public String getName() {
			return this.name;
		}
		
		public String getHighResolutionIconUrl() {
			return this.highResolutionIconUrl;
		}
		
		public String getTwitterAccount() {
			return this.twitterAccount;
		}
		
		public Integer getLaunchDate() {
			return this.launchDate;
		}
		
		public Styling getStyling() {
			return this.styling;
		}
		
		public List<Object> getAliases() {
			return this.aliases;
		}
		
		public List<Object> getRelatedSites() {
			return this.relatedSites;
		}
		
		public List<Object> getMarkdownExtensions() {
			return this.markdownExtensions;
		}
		
		@Override
		public String toString() {
			return "Site [ "
				+ "iconUrl = " + this.iconUrl + ", "
				+ "audience = " + this.audience + ", "
				+ "faviconUrl = " + this.faviconUrl + ", "
				+ "siteType = " + this.siteType + ", "
				+ "logoUrl = " + this.logoUrl + ", "
				+ "apiSiteParameter = " + this.apiSiteParameter + ", "
				+ "openBetaDate = " + this.openBetaDate + ", "
				+ "siteState = " + this.siteState + ", "
				+ "closedBetaDate = " + this.closedBetaDate + ", "
				+ "siteUrl = " + this.siteUrl + ", "
				+ "name = " + this.name + ", "
				+ "highResolutionIconUrl = " + this.highResolutionIconUrl + ", "
				+ "twitterAccount = " + this.twitterAccount + ", "
				+ "launchDate = " + this.launchDate + ", "
				+ "styling = " + this.styling + ", "
				+ "aliases = " + this.aliases + ", "
				+ "relatedSites = " + this.relatedSites + ", "
				+ "markdownExtensions = " + this.markdownExtensions + ", "
				+ "]"; 
		}	
		@JsonIgnoreProperties(ignoreUnknown = true)
		public static class Styling {
		
			public Styling(){}
		
			@JsonProperty("tag_background_color") 
			private String tagBackgroundColor;
			
			@JsonProperty("link_color") 
			private String linkColor;
			
			@JsonProperty("tag_foreground_color") 
			private String tagForegroundColor;
			
			public String getTagBackgroundColor() {
				return this.tagBackgroundColor;
			}
			
			public String getLinkColor() {
				return this.linkColor;
			}
			
			public String getTagForegroundColor() {
				return this.tagForegroundColor;
			}
			
			@Override
			public String toString() {
				return "Styling [ "
					+ "tagBackgroundColor = " + this.tagBackgroundColor + ", "
					+ "linkColor = " + this.linkColor + ", "
					+ "tagForegroundColor = " + this.tagForegroundColor + ", "
					+ "]"; 
			}	
		}
		
	}
	
}	
