import {UseCase} from "../../../kernel/contracts";
import {AreaRepository} from "./ports/area.repository";
export class ExistAreaByName implements UseCase<string, boolean> {
    constructor(private readonly areaRepository: AreaRepository) {
    }
    execute(name: string): Promise<boolean> {
        return this.areaRepository.existByName(name);
    }
}
