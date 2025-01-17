/*
 * generated by Xtext 2.16.0
 */
package org.eclipse.scava.crossflow.language.xtext.ide

import com.google.inject.Guice
import org.eclipse.scava.crossflow.language.xtext.CrossflowRuntimeModule
import org.eclipse.scava.crossflow.language.xtext.CrossflowStandaloneSetup
import org.eclipse.xtext.util.Modules2

/**
 * Initialization support for running Xtext languages as language servers.
 */
class CrossflowIdeSetup extends CrossflowStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new CrossflowRuntimeModule, new CrossflowIdeModule))
	}
	
}
