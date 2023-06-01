import {ResponseApi} from "../../../kernel/types";
import {AreaRepository} from "../use-cases/ports/area.repository";
import {AreaStorageGateway} from "./area.storage.gateway";
import {Request, Response} from "express";
import {Area} from "../entities/area";
import {
    CreateAreaInteractor,
    ExistAreaByName,
    GetAllAreasInteractor,
    GetAreaInteractor,
    UpdateAreaInteractor,
    UpdateStatusAreaInteractor
} from "../use-cases";
import {SaveAreaDto, UpdateAreaDto, UpdateStatusAreaDto} from "../entities/areaDto";


export class AreaController {

    // Error Message initialize
    static getError(): ResponseApi<Area> {
        return {
            code: 500,
            error: true,
            message: 'SOMETHING BROKE 😢!',
            cause: ''
        } as ResponseApi<Area>
    }


    static findAreas = async (req: Request, res: Response): Promise<Response> => {
        try {


            const repo: AreaRepository = new AreaStorageGateway();
            const interact: GetAllAreasInteractor = new GetAllAreasInteractor(repo);
            const areas: Area[] = await interact.execute();

            let body: ResponseApi<Area> = {
                code: 200,
                error: false,
                message: 'OK',
                data: areas
            }

            return res.status(body.code).json(body)

        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }

    }

    static createArea = async (req: Request, res: Response): Promise<Response> => {
        try {
            const payload: SaveAreaDto = {...req.body} as SaveAreaDto;
            const repo: AreaRepository = new AreaStorageGateway();
            const check: ExistAreaByName = new ExistAreaByName(repo);
            const checkName = check.execute(payload.area);

            if (!await checkName) {

                const interact: CreateAreaInteractor = new CreateAreaInteractor(repo);
                const area: Area = await interact.execute(payload);
                const body: ResponseApi<Area> = {
                    code: 201,
                    error: false,
                    message: 'CREATED',
                    data: area,
                }

                return res.status(body.code).json(body)

            } else return res.status(400).json({message: 'Name not available ', error: true});


        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }

    static findById = async (req: Request, res: Response): Promise<Response> => {
        try {
            /**
             * Validation by number
             */
            const id: number = parseInt(req.params.id)

            const repo: AreaRepository = new AreaStorageGateway();
            const interact: GetAreaInteractor = new GetAreaInteractor(repo);
            const area: Area = await interact.execute(id);

            let body: ResponseApi<Area> = {
                code: 200,
                error: false,
                message: 'OK',
                data: area
            }

            if (!area) body = {...this.getError(), message: 'NOT FOUND USER', code: 404, error: false}
            return res.status(body.code).json(body)

        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }

    }

    static updateArea = async (req: Request, res: Response): Promise<Response> => {
        try {
            const id: number = parseInt(req.params.id)
            const payload: UpdateAreaDto = {id, ...req.body} as UpdateAreaDto;
            const repo: AreaRepository = new AreaStorageGateway();
            const check: ExistAreaByName = new ExistAreaByName(repo);
            const checkName = check.execute(payload.area);

            if (!await checkName) {

                const interact: UpdateAreaInteractor = new UpdateAreaInteractor(repo);
                const area: Area = await interact.execute(payload);
                const body: ResponseApi<Area> = {
                    code: 200,
                    error: false,
                    message: 'UPDATED',
                    data: area,
                }

                return res.status(body.code).json(body)

            } else return res.status(400).json({message: 'Email not available ', error: true});


        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }

    static updateStatusArea = async (req: Request, res: Response): Promise<Response> => {
        try {

            const id: number = parseInt(req.params.id)
            const payload: UpdateStatusAreaDto = {id, ...req.body} as UpdateStatusAreaDto;
            const repo: AreaRepository = new AreaStorageGateway();
            const interact: UpdateStatusAreaInteractor = new UpdateStatusAreaInteractor(repo);

            const area: Area = await interact.execute(payload);
            let body: ResponseApi<Area> = {
                code: 201,
                error: false,
                message: 'CREATED',
                data: area,
            }

            if (!area) body = {...this.getError(), message: 'NOT FOUND USER', code: 404, error: false}
            return res.status(body.code).json(body)


        } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }


}