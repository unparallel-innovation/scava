package org.eclipse.scava.plugin.usermonitoring.metric.basicmetrics;

import org.apache.tinkerpop.gremlin.process.traversal.dsl.graph.GraphTraversal;
import org.apache.tinkerpop.gremlin.structure.Vertex;

public class FileAccesRateBasicMetric implements IBasicMetric {
	
	private static final String DESCRIPTION = "Average rate of file access";

	@Override
	public double process(GraphTraversal<Vertex, Vertex> vertices) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getDiscription() {
		
		return DESCRIPTION;
	}

}
