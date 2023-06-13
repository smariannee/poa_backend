import {UseCase} from "@/kernel/contracts";
import {AuthRepository} from "@/modules/auth/use-cases/ports/auth.repository";
import {User} from "@/modules/auth/boundary";

export class GenerateResetToken implements UseCase<string, boolean>{

    constructor(private readonly  authRepository: AuthRepository) {
    }
    execute(email: string): Promise<boolean> {
        if (!email) throw new Error(`Missing field`);
        // const user:User = await

        throw new Error("Method not implemented.");
    }

}