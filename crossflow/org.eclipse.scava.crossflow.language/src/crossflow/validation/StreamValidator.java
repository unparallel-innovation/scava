/**
 *
 * $Id$
 */
package crossflow.validation;

import crossflow.Type;

/**
 * A sample validator interface for {@link crossflow.Stream}.
 * This doesn't really do anything, and it's not a real EMF artifact.
 * It was generated by the org.eclipse.emf.examples.generator.validator plug-in to illustrate how EMF's code generator can be extended.
 * This can be disabled with -vmargs -Dorg.eclipse.emf.examples.generator.validator=false.
 */
public interface StreamValidator {
	boolean validate();

	boolean validateName(String value);
	boolean validateType(Type value);
}
