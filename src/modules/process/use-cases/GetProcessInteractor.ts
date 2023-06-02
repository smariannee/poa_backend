import {UseCase} from "../../../kernel/contracts";
import {Process} from "../entities/process";
import {ProcessRepository} from "./port/process.repository";


export class GetProcessInteractor implements UseCase<number, Process> {
    constructor(private readonly processRepository: ProcessRepository) {
    }

    execute(id: number): Promise<Process> {
        return this.processRepository.findById(id);
    }
}
