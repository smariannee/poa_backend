import {UseCase} from "@/kernel/contracts";

export class ResetPwd implements UseCase<any, any> {
    execute(request: any): Promise<any> {
        throw new Error("Method not implemented.");
    }
}