import {Request, Response} from "express";
import {Process} from "../entities/process";
import {ResponseApi} from "../../../kernel/types";

export class ProcessController {

    static getError(): ResponseApi<Process> {
        return {
            code: 500,
            error: true,
            message: 'SOMETHING BROKE 😢!',
            cause: 'ERROR_INTERNAL_SEVER'
        } as ResponseApi<Process>
    }

    static findUsers = async (req: Request, res: Response): Promise<Response> => {
        try{
            throw Error ('NOT IMPLEMENT FUNCTION')
         } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }
    static findById = async (req: Request, res: Response): Promise<Response> => {
        try{
            throw Error ('NOT IMPLEMENT FUNCTION')
         } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }
    static createUser = async (req: Request, res: Response): Promise<Response> => {
        try{
            throw Error ('NOT IMPLEMENT FUNCTION')
         } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }
    static updateUser = async (req: Request, res: Response): Promise<Response> => {
        try{
            throw Error ('NOT IMPLEMENT FUNCTION')
         } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }
    static updateStatusUser = async (req: Request, res: Response): Promise<Response> => {
        try{
            throw Error ('NOT IMPLEMENT FUNCTION')
         } catch (e) {
            return res.status(500).json({...this.getError(), cause: (<Error>e).message});
        }
    }
}