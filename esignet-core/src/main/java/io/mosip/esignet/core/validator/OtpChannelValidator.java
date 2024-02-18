package io.mosip.esignet.core.validator;

import io.mosip.esignet.api.spi.Authenticator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;


@Component
public class OtpChannelValidator implements ConstraintValidator<OtpChannel, String> {

    @Autowired
    private List<Authenticator> authenticationWrappers;

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        // TODO: Validate based on the authenticator.
        // For now this validates against all authenticator backends.
        boolean valid = true;
        for (Authenticator authenticator: authenticationWrappers){
            valid &= authenticator.isSupportedOtpChannel(s);
        }
        return valid;
    }
}
