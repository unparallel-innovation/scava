<jsp:include page="header.jsp" />

<main role="main" id="app">

<section class="jumbotron text-center">
	<div class="container">
		<h1 class="jumbotron-heading">{{ experiment.title }}</h1>
		<p class="lead text-muted">{{ experiment.summary }}</p>

		<div class="btn-group" v-if="experiment.status == 'stopped'">
			<button type="button" class="btn btn-success"
				v-on:click="startExperiment">Start</button>
			<button type="button"
				class="btn btn-success dropdown-toggle dropdown-toggle-split"
				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="#" v-on:click="startExperiment">Master
					and worker</a> <a class="dropdown-item" href="#"
					v-on:click="startExperimentMasterOnly">Master only</a>
			</div>
		</div>

		<button v-on:click="stopExperiment"
			v-if="experiment.status == 'running'" class="btn btn-danger my-2">Stop</button>
		<button v-on:click="resetExperiment"
			v-if="experiment.status != 'running' && (experiment.cached || experiment.executed)"
			class="btn btn-information my-2">Reset</button>
	</div>
</section>

<section>
	<div class="container">
		<div class="row">
			<div class="col-sm-12 col-md-12 py-12">
			
				<!-- TAB SPECS -->
				<ul class="nav nav-tabs" id="myTab" role="tablist">
				
					<!-- CUSTOM FILE DESCRIPTOR TABS -->
					<li class="nav-item"
						v-for="(fileDescriptor,index) in experiment.fileDescriptors">
						<a class="nav-link" :id="'tab' + index" data-toggle="tab"
						:href="'#file' + index" role="tab" :aria-controls="'file'+index"
						aria-selected="true">{{ fileDescriptor.title }}</a>
					</li>
					
					<!-- ADVANCED TAB -->
					<li class="nav-item"><a class="nav-link active"
						id="advanced-tab" data-toggle="tab" href="#advanced" role="tab"
						aria-controls="advanced" aria-selected="false">Advanced</a></li>
						
					<!-- MODEL TAB -->
					<li class="nav-item"><a class="nav-link" id="model-tab"
						data-toggle="tab" href="#model" role="tab" aria-controls="model"
						aria-selected="false">Model</a></li>
						
					<!-- LOG TAB -->
					<li class="nav-item"><a class="nav-link" id="log-tab"
						data-toggle="tab" href="#log" role="tab" aria-controls="log"
						aria-selected="false">Log</a></li>
				
				</ul>
				
				<!-- TAB CONTENTS -->
				<div class="tab-content" id="myTabContent">
				
					<!-- CUSTOM FILE DESCRIPTORS -->
					<div class="tab-pane fade show"
						v-for="(fileDescriptor,index) in experiment.fileDescriptors"
						:id="'file'+index" role="tabpanel"
						:aria-labelledby="'file'+index+'-tab'">
						<p />
						<table class="table table-striped table-bordered"
							v-if="fileDescriptor.table">
							<thead v-if="fileDescriptor.table.header" class="thead-dark">
								<tr>
									<th width="50px"><span class="badge badge-secondary">#</span></th>
									<th v-for="cell in fileDescriptor.table.header.cells">{{
										cell }}</th>
								</tr>
							</thead>
							<tr v-for="(row,index) in fileDescriptor.table.rows">
								<td><span class="badge badge-secondary">{{ index+1
										}}</span></td>
								<td v-for="cell in row.cells">{{ cell }}</td>
							</tr>
						</table>
						<div class="alert alert-info" role="alert"
							v-if="(!fileDescriptor.table || !fileDescriptor.table.header) && !fileDescriptor.input && !experiment.executed">
							Not what you were hoping for? <a href="#"
								v-on:click="startExperiment">Start the experiment</a> and data
							will appear here soon.
						</div>
						<div class="alert alert-warning" role="alert"
							v-if="!fileDescriptor.table && !fileDescriptor.input && experiment.executed">
							The experiment produced no data here.</div>

					</div>
					
					<!-- ADVANCED -->
					<div class="tab-pane fade show active" id="advanced"
						role="tabpanel" aria-labelledby="advanced-tab">
						<p>
						<table class="table table-striped table-bordered">
							<tr>
								<td>Auto-refresh</td>
								<td><input type="checkbox" id="refresh" checked></td>
							</tr>
							<tr>
								<td>Broker</td>
								<td><span class="badge badge-success"
									v-if="diagnostics.brokerRunning">running</span> <span
									class="badge badge-danger" v-if="!diagnostics.brokerRunning">stopped</span>
								</td>
							</tr>
							<tr>
								<td>Executed</td>
								<td><span class="badge badge-success"
									v-if="experiment.executed">yes</span> <span
									class="badge badge-dark" v-if="!experiment.executed">no</span>
								</td>
							</tr>
							<tr>
								<td>Cached</td>
								<td><span class="badge badge-success"
									v-if="experiment.cached">yes</span> <span
									class="badge badge-dark" v-if="!experiment.cached">no</span></td>
							</tr>
							<tr>
								<td>Serving from</td>
								<td><code>{{ diagnostics.rootDirectory }}</code></td>
							</tr>
							<tr>
								<td>Workflow class</td>
								<td><code>{{ experiment.className }}</code></td>
							</tr>
							<tr>
								<td>Input/output directories</td>
								<td><code>{{ experiment.inputDirectory }} / {{
										experiment.outputDirectory }}</code></td>
							</tr>

						</table>
						</p>
					</div>
					
					<!-- MODEL -->
					<div class="tab-pane fade show" id="model" role="tabpanel"
						aria-labelledby="model-tab">
						<div id="graphContainer"
							style="position: relative; overflow: scroll; width: 100%; height: 100%; cursor: default;">
						</div>
						<p></p>
					</div>
					
					<!-- LOG -->
					<div class="tab-pane fade show" id="log" role="tabpanel"
						aria-labelledby="log-tab">
						<!-- TODO: LOG TAB CONTENT -->
						<div id="log0" role="tabpanel" aria-labelledby="log0-tab" class="tab-pane fade active show">
						   <p></p>
						   <table class="table table-striped table-bordered" id="log-table">
						      <thead class="thead-dark">
						         <tr>
						            <th>Creation</th>
						            <th><span class="badge badge-secondary">Severity</span></th>
						            <th>Message</th>
						         </tr>
						      </thead>
						      <tbody id="log-table-body">
						      </tbody>
						   </table>
						   <!----> <!---->
						</div>
						
						
						<p></p>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</section>

</main>




<script>
	var app = new Vue({
		el : '#app',
		data : {
			message : 'Hello Vue!',
			experimentId : null,
			experiment : new Experiment(),
			diagnostics : new Diagnostics()
		},
		methods : {
			startExperimentMasterOnly : function(event) {
				crossflow.startExperiment(this.experimentId, false);
			},
			startExperiment : function(event) {
				crossflow.startExperiment(this.experimentId, true);
			},
			stopExperiment : function(event) {
				crossflow.stopExperiment(this.experimentId);
			},
			resetExperiment : function(event) {
				crossflow.resetExperiment(this.experimentId);
			}
		}
	})

	var transport = new Thrift.TXHRTransport(
			"/org.eclipse.scava.crossflow.web/crossflow");
	var protocol = new Thrift.TJSONProtocol(transport);
	var crossflow = new CrossflowClient(protocol);

	var url = new URL(window.location.href);
	app.experimentId = url.searchParams.get("id");

	refresh();

	setInterval(function() {
		if (document.getElementById("refresh").checked) {
			refresh();
		}
	}, 3000);

	function refresh() {
		app.experiment = crossflow.getExperiment(app.experimentId);
		app.experiment.fileDescriptors.forEach(function(fileDescriptor) {
			fileDescriptor.table = crossflow.getContent(fileDescriptor);
		});
		app.diagnostics = crossflow.getDiagnostics();
		
	}
	
var cellTooltips = {};

loadStencils();

//container = document.getElementById('graphContainer');
experimentId = new URL(document.location).searchParams.get('id');

mxEvent.disableContextMenu(document.getElementById('graphContainer'));
//window.runtimeModelContainer = container;

window.runtimeModelGraph = new mxGraph(document.getElementById('graphContainer'));
window.runtimeModelGraph.getStylesheet().getDefaultEdgeStyle()['edgeStyle'] = 'orthogonalEdgeStyle';
window.runtimeModelGraph.setTooltips(true);
var oldGetPreferredSizeForCell = window.runtimeModelGraph.getPreferredSizeForCell;
window.runtimeModelGraph.getPreferredSizeForCell = function(cell)
{
	var result = oldGetPreferredSizeForCell.apply(this, arguments);
	if (result != null)
	{
		result.width = result.width + 20;
		result.height = 40;

	}
	return result;
};

window.runtimeModelGraph.getTooltipForCell = function(cell, evt) {
	
	//console.log('getTooltipForCell triggered');
	
	streamTopicXmlDoc = window.streamTopicXmlDoc;
	taskTopicXmlDoc = window.taskTopicXmlDoc;
	
	size = "n/a";
	sizeUnit = "";

	preSize = "n/a";
	preSizeUnit = "";
	
	postSize = "n/a";
	postSizeUnit = "";
	
	destSize = "n/a";
	destSizeUnit = "";
	
	inFlight = "n/a";
	subscribers = "n/a";
	taskStatus = "n/a";

	//console.log(streamTopicXmlDoc);
	if ( cell.id.includes('task_') ) {
		modelElement = cell.id.substr('task_'.length);
		/* if ( taskTopicXmlDoc == null ) {
			return;
		} */
		// derive status from current cell style for consistency
		cellStyle = cell.getStyle().substring(cell.getStyle().indexOf('fillColor='), cell.getStyle().length);
		taskStatusCellTooltip = "<table border=1><tr><td>";
		
		if ( cellStyle.includes('lightcyan') )
			taskStatusCellTooltip += "STARTED";
		
		else if ( cellStyle.includes('skyblue') )
			taskStatusCellTooltip += "WAITING";
		
		else if ( cellStyle.includes('palegreen') )
			taskStatusCellTooltip += "INPROGRESS";
		
		else if ( cellStyle.includes('salmon') )
			taskStatusCellTooltip += "BLOCKED";
		
		else if ( cellStyle.includes('slategray') )
			taskStatusCellTooltip += "FINISHED";
		
		else if ( cellStyle.includes('#fffff') )
			taskStatusCellTooltip += "N/A";
			
		taskStatusCellTooltip += "</td></tr></table>";
		return taskStatusCellTooltip;
	}// if task tooltip 
	
	else if ( cell.id.includes('stream_') ) {
		modelElement = cell.id.substr('stream_'.length);
		if ( streamTopicXmlDoc == null ) {
			return;
		}
		
		for ( i=0; i < streamTopicXmlDoc.childNodes[0].children.length; i++ ) {
			if ( streamTopicXmlDoc.childNodes[0].children[i] != null ) {
				//console.log("streams encountered");
				for ( j=0; j < streamTopicXmlDoc.childNodes[0].children[i].children.length; j++ ) {
					//console.log("i="+i+";  j="+j);
				
					// handle pre-queue
					if ( streamTopicXmlDoc.childNodes[0].children[i].children[j] != null &&
							streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML != null &&
							streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML.includes(modelElement + 'Pre.') ) {
					
						//console.log("i="+i+";  j="+j);
						name = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML;
						//console.log('name='+name);
						
						// size
						preSize = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[1].innerHTML;
						//console.log('preSize='+preSize);
						
						// inFlight
						inFlight = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[2].innerHTML;
						//console.log('inFlight='+inFlight);

						// numberOfSubscribers
						subscribers = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[4].innerHTML;
						//console.log('subscribers='+subscribers);
						
					}// handle pre-queue
					
					// handle post-queue
					if ( streamTopicXmlDoc.childNodes[0].children[i].children[j] != null &&
							streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML != null &&
							streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML.includes(modelElement + 'Post.') ) {
					
						//console.log("i="+i+";  j="+j);
						name = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML;
						//console.log('name='+name);
						
						// size
						postSize = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[1].innerHTML;
						//console.log('postSize='+postSize);
						
						// inFlight
						inFlight = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[2].innerHTML;
						//console.log('inFlight='+inFlight);

						// numberOfSubscribers
						subscribers = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[4].innerHTML;
						//console.log('subscribers='+subscribers);
			
					}// handle post-queue
					
					// handle destination-queue
					if ( streamTopicXmlDoc.childNodes[0].children[i].children[j] != null &&
							streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML != null &&
							streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML.includes(modelElement + 'Destination.') ) {
					
						//console.log("i="+i+";  j="+j);
						name = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[0].innerHTML;
						//console.log('name='+name);
						
						// size
						destSize = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[1].innerHTML;
						//console.log('destSize='+destSize);
						
						// inFlight
						inFlight = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[2].innerHTML;
						//console.log('inFlight='+inFlight);

						// numberOfSubscribers
						subscribers = streamTopicXmlDoc.childNodes[0].children[i].children[j].children[4].innerHTML;
						//console.log('subscribers='+subscribers);
			
					}// handle destination-queue
					
			}// for
			
		}// if
		
	}// for streamTopicXmlDoc
					
	// sum up size of pre-queue, post-queue, and destination-queue
	size = 0;
	if ( preSize!='n/a' && preSize!='0' )
		size += parseInt(preSize, 10);
	if ( postSize!='n/a' && postSize!='0' )
		size += parseInt(postSize, 10);
	if ( destSize!='n/a' && destSize!='0' )
		size += parseInt(destSize, 10);
	
	// add unit to size and make size human-readable
	if ( size >= 1000 && size <= 999999 ) {
		sizeUnit = "K";
		size = size / 1000;
	} else if ( size >= 1000000 ) {
		sizeUnit = "M";
		size = size / 1000000;
	} else {
		sizeUnit = ""; // no unit
	}
	// rounding size
	size = Math.round(size);
	//console.log('size='+size);
	
	// add unit to preSize and make size human-readable
	if ( preSize >= 1000 && preSize <= 999999 ) {
		preSizeUnit = "K";
		preSize = preSize / 1000;
	} else if ( postSize >= 1000000 ) {
		preSizeUnit = "M";
		preSize = preSize / 1000000;
	} else {
		preSizeUnit = ""; // no unit
	}
	// rounding preSize
	preSize = Math.round(preSize);
	//console.log('preSize='+preSize);
	
	// add unit to postSize and make size human-readable
	if ( postSize >= 1000 && postSize <= 999999 ) {
		postSizeUnit = "K";
		postSize = postSize / 1000;
	} else if ( postSize >= 1000000 ) {
		postSizeUnit = "M";
		postSize = postSize / 1000000;
	} else {
		postSizeUnit = ""; // no unit
	}
	// rounding postSize
	postSize = Math.round(postSize);
	//console.log('postSize='+postSize);
	
	// add unit to destSize and make size human-readable
	if ( destSize >= 1000 && destSize <= 999999 ) {
		destSizeUnit = "K";
		destSize = destSize / 1000;
	} else if ( destSize >= 1000000 ) {
		destSizeUnit = "M";
		destSize = destSize / 1000000;
	} else {
		destSizeUnit = ""; // no unit
	}
	// rounding destSize
	destSize = Math.round(destSize);
	//console.log('destSize='+destSize);
	
	// also visible queue size for consistency
	cell.value = Math.round(size) + sizeUnit;
				
	cellTooltip = "<table border=1>" + "<tr><td>" + PRE_SIZE_LABEL_PRE + "</td><td>" + preSize + preSizeUnit + "</td></tr>" + "<tr><td>" + POST_SIZE_LABEL_PRE + "</td><td>" + postSize + postSizeUnit + "</td></tr>" + "<tr><td>" + DEST_SIZE_LABEL_PRE + "</td><td>" + destSize + destSizeUnit + "</td></tr>" + "<tr><td>" + SIZE_LABEL_PRE + "</td><td>" + size + sizeUnit + "</td></tr>" + "<tr><td>" + IN_FLIGHT_LABEL_PRE + "</td><td>" + inFlight + "</td></tr>" + "<tr><td>" + SUBSCRIBER_LABEL_PRE + "</td><td>" + subscribers + "</td></tr></table>";		
	if ( cellTooltip.includes("n/a") ) {
		// return latest known status
		return cellTooltips[modelElement];
	} 
	
	cellTooltips[modelElement] = cellTooltip;
	
	return cellTooltip;
		
	}// if stream tooltip
	else {
		// unknown cell
		return;
	}
	
};// CELL TOOLTIPS

//---------------
// CONTEXT MENU
window.runtimeModelGraph.popupMenuHandler.factoryMethod = function(menu, cell, evt)
{
	return createPopupMenu(window.runtimeModelGraph, menu, cell, evt);
};

function createPopupMenu(graph, menu, cell, evt) {
	if (cell != null)
	{
		if (cell.id.startsWith('stream_')) {
			menu.addItem('Clear cache of queue \"' + cell.id.substr('stream_'.length) + '\"?', 'src/images/warning.gif', function()
			{
				res = mxUtils.confirm('Are you sure about clearing the cache of queue \"'+ cell.id.substr('stream_'.length) + '\"?', false);
				if ( res ) {
					// trigger cache clearing of queue cell.id
					clearSuccess = crossflow.clearQueue(experimentId, cell.id);
					if ( clearSuccess ) {
						mxUtils.alert('Cache of queue \"' + cell.id.substr('stream_'.length) + '\" has been cleared.');						
					} else {
						mxUtils.alert('Failed to clear cache of queue \"' + cell.id.substr('stream_'.length) + '\". Has the experiment been started yet?');		
					}
				}
			})
		}
	} else {
		menu.addItem('Clear cache of all queues?', 'src/images/warning.gif', function()
		{
			res = mxUtils.confirm('Are you sure about clearing the cache of all queues?', false);
			if ( res ) {
				// trigger cache clearing of all queues
				clearSuccess = crossflow.clearQueue(experimentId, "");
				if ( clearSuccess ) {
					mxUtils.alert('Cache of all queues has been cleared.');
				} else {
					mxUtils.alert('Failed to clear cache of all queues. Has the experiment been started yet?');		
				}
			}
		});	
	}
};// CONTEXT MENU

// ---------------
<%
String graphPath = "experiments/" + request.getParameter("id") + "/abstract.graph";
//new File(servlet.getServletContext().getRealPath("experiments/" + experimentId + "/" + experiment.getOutputDirectory())));

%>
try {
window.runtimeModelGraph.getModel().beginUpdate();
<jsp:include page="<%= graphPath %>" flush="true" />

var layout = new mxCompactTreeLayout(window.runtimeModelGraph, true);
layout.execute(window.runtimeModelGraph.getDefaultParent());
window.runtimeModelGraph.enabled = false; // de-activate graph editing

} finally {
	// Updates the display
	window.runtimeModelGraph.getModel().endUpdate();
}

</script>

<jsp:include page="footer.jsp" />
