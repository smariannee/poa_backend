import {transporter} from "@/utils/emailconfig";
import {ResponseEmail} from "@/kernel/types";
import {templateResetPwd} from "@/utils/templateEmail/templateResetPwd";

export const sendEmailReset = async (payload: ResponseEmail ): Promise<boolean> => {
    try {
        await transporter.sendMail({
            from: `Alexx Joel <${process.env.EMAIL_ADDRESS}>`,
            to: payload['email'],
            subject: 'Olvidaste tu contraseña',
            html: templateResetPwd(payload['url']!)
        });
        transporter.close();
        return true;
    }catch (e) {
        return false
    }
}
export const createPassword = (name: string, lastname1: string, lastname2: string) => {
    const pwd = name.charAt(0).toUpperCase() + lastname1.charAt(0).toLowerCase() + lastname2.charAt(0).toLowerCase() + '1234.';
    return pwd;
}