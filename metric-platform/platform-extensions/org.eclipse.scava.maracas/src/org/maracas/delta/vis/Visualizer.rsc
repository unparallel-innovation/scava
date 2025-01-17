module org::maracas::delta::vis::Visualizer

import IO;
import Set;
import Node;
import String;

import lang::html5::DOM;

import org::maracas::delta::Delta;
import org::maracas::m3::Core;

str renderHtml(Delta delta) {
	kws = getKeywordParameters(delta);

	list[value] blocks = [
		h3("Statistics"),
		table(class("striped"), HTML5Attr::style("width:auto;"),
			thead(tr(th("Type"), th("Count"))),
			tbody(
				[tr(td(friendlyNames[relName]), td(size(r))) |
					relName <- kws, rel[loc, Mapping[&T]] r := kws[relName]]
			)
		)
	];

	for (str relName <- kws) {
		value v = kws[relName];

		if (rel[loc, Mapping[&T]] relation := v) {
			blocks += h4(friendlyNames[relName]);
			
			if (size(relation) > 0)
				blocks +=
					table(class("striped"), HTML5Attr::style("width:auto;"),
						thead(tr(th("Old"), th("From"), th("To"), th("Score"))),
						tbody(
							[tableRow(delta, change) | change <- relation]
						)
					);
			else
				blocks += p("No changes");
		}
	}

	return lang::html5::DOM::toString(html(
			head(
				title("Delta model between <delta.id[0].file> and <delta.id[1].file>"),
				link(\rel("stylesheet"), href("https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css")),
				script(src("https://cdn.jsdelivr.net/gh/google/code-prettify@master/loader/run_prettify.js"))
			),
			body(
				h2("Delta model between <delta.id[0].file> and <delta.id[1].file>") +
				blocks
			)
		)
	);
}

HTML5Node tableRow(Delta delta, tuple[loc, Mapping[&T]] change) {
	loc v1 = delta.id[0];
	loc v2 = delta.id[1];

	if (<l, <loc src, loc tgt, score, _>> := change)
		return tr(td(sourceCodeDiv(v1, l)), td(sourceCodeDiv(v1, src)), td(sourceCodeDiv(v2, tgt)), td(score));
	else if (<l, <src, tgt, score, _>> := change)
		return tr(td(sourceCodeDiv(v1, l)), td(src), td(tgt), td(score));

	return div();
}

HTML5Node sourceCodeDiv(loc sources, loc l) {
	list[value] firstCol = [l];
	str source = sourceCode(sources, l);

	if (!isEmpty(source)) {
		firstCol += [br(), pre(class("prettyprint"), HTML5Attr::style("font-size:.75em;"), toHtml(source[..200] + (size(source) > 200 ? "\n[truncated]" : "")))];
	}

	return div(firstCol);
}

void writeHtml(loc out, Delta delta) {
	writeFile(out, renderHtml(delta));
}

str toHtml(str code) {
	return replaceAll(code, "\n", "\<br\>");
}

map[str, str] friendlyNames = (
	"accessModifiers"   : "Access modifiers changed",
	"finalModifiers"    : "Final modifiers changed",
	"staticModifiers"   : "Static modifiers changed",
	"abstractModifiers" : "Abstract modifiers changed",
	"paramLists"        : "Method parameters changed",
	"types"             : "Field and method types changed",
	"extends"           : "Class extension changed",
	"implements"        : "Class/Interface implementation changed",
	"deprecated"        : "Deprecated elements",
	"renamed"           : "Renamed elements",
	"moved"             : "Moved elements",
	"removed"           : "Removed elements",
	"added"             : "Added elements"
);
