/**
 *
 * $Id$
 */
package crossflow.validation;

import crossflow.Field;
import crossflow.Type;

import org.eclipse.emf.common.util.EList;

/**
 * A sample validator interface for {@link crossflow.Type}.
 * This doesn't really do anything, and it's not a real EMF artifact.
 * It was generated by the org.eclipse.emf.examples.generator.validator plug-in to illustrate how EMF's code generator can be extended.
 * This can be disabled with -vmargs -Dorg.eclipse.emf.examples.generator.validator=false.
 */
public interface TypeValidator {
	boolean validate();

	boolean validateName(String value);
	boolean validateIsMany(boolean value);
	boolean validateExtending(EList<Type> value);
	boolean validateFields(EList<Field> value);
}
