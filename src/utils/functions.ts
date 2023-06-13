export const createPassword = (name: string, lastname1: string, lastname2: string) => {
    const pwd = name.charAt(0).toUpperCase() + lastname1.charAt(0).toLowerCase() + lastname2.charAt(0).toLowerCase() + '1234.';
    return pwd;
}