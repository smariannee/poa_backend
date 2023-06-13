export const validateEmail = (email: string): boolean => {
    const pattern = /^[\w-\.]+@utez\.edu\.mx$/;
    return pattern.test(email);
}

export const validatePassword = (password: string): boolean => {
    const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!"#$%&/()=?'¡¿*-.]).{8,}$/;
    return pattern.test(password);
}

export const validatePhoneNumber = (phoneNumber: string): boolean => {
    const pattern = /^[0-9]{10}$/;
    return pattern.test(phoneNumber);
}

export const validateExtensionNumber = (extensionNumber: string): boolean => {
    const pattern = /^[0-9]{3}$/;
    return pattern.test(extensionNumber);
}