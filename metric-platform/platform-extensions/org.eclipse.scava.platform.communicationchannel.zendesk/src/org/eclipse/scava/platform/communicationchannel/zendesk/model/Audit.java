/*******************************************************************************
 * Copyright (c) 2018 University of York
 * 
 * This program and the accompanying materials are made
 * available under the terms of the Eclipse Public License 2.0
 * which is available at https://www.eclipse.org/legal/epl-2.0/
 * 
 * SPDX-License-Identifier: EPL-2.0
 ******************************************************************************/
package org.eclipse.scava.platform.communicationchannel.zendesk.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import org.eclipse.scava.platform.communicationchannel.zendesk.model.events.Event;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author stephenc
 * @since 05/04/2013 10:22
 */
public class Audit {
    private Long id;
    private Long ticketId;
    private Map<String, Object> metadata;
    private Via via;
    private Date createdAt;
    private Long authorId;
    private List<Event> events;

    @JsonProperty("author_id")
    public Long getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Long authorId) {
        this.authorId = authorId;
    }

    @JsonProperty("created_at")
    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public List<Event> getEvents() {
        return events;
    }

    public void setEvents(List<Event> events) {
        this.events = events;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Map<String, Object> getMetadata() {
        return metadata;
    }

    public void setMetadata(Map<String, Object> metadata) {
        this.metadata = metadata;
    }

    @JsonProperty("ticket_id")
    public Long getTicketId() {
        return ticketId;
    }

    public void setTicketId(Long ticketId) {
        this.ticketId = ticketId;
    }

    public Via getVia() {
        return via;
    }

    public void setVia(Via via) {
        this.via = via;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder();
        sb.append("Audit");
        sb.append("{authorId=").append(authorId);
        sb.append(", id=").append(id);
        sb.append(", ticketId=").append(ticketId);
        sb.append(", metadata=").append(metadata);
        sb.append(", via=").append(via);
        sb.append(", createdAt=").append(createdAt);
        sb.append(", events=").append(events);
        sb.append('}');
        return sb.toString();
    }

}
