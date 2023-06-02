import {UseCase} from "../../../kernel/contracts";
import {ProcessRepository} from "./port/process.repository";

export class ExistProcessByName implements UseCase<string, boolean> {
    constructor(private readonly processRepository: ProcessRepository) {
    }
    execute(name: string): Promise<boolean> {
        return this.processRepository.existByName(name);
    }
}
