import {UseCase} from "@/kernel/contracts";
import {AuthRepository} from "@/modules/auth/use-cases/ports/auth.repository";
import {findByEmail, User} from "../boundary";
import {generateRandomString} from "../../../kernel/jwt";
import {sendEmailReset} from "../../../utils/functions";
import {ResetPwdUserDto} from "@/modules/auth/entities";

export class GenerateResetToken implements UseCase<string, boolean>{
    URL: string;
    constructor(private readonly  authRepository: AuthRepository) {
        const PORT = process.env.PORT || 3000;
        const HOST = process.env.HOST || 'localhosteer';
        this.URL = `http://${HOST}:${PORT}/poa/auth/new-pwd?token=`;
    }

    async execute(email: string): Promise<boolean> {
        if (!email) throw new Error(`Missing field`);
        const user = await findByEmail(email) as User
        if (!user) throw new Error(`Not found`);

        const token = generateRandomString(); //generate characters 15 random characters
        const url = this.URL + token;
        console.log(url);
        const result = sendEmailReset({email, url}); //send email
        if (!result) throw new Error(`Error sending email`);
        //insert token in database
        return  await this.authRepository.generateResetToken({id: user.id, token} as ResetPwdUserDto);
    }

}