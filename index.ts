import express, {Express, Request, Response} from 'express'
import Router from "express-promise-router";
import fs from 'fs'
import { Module } from 'module';
import fetch from 'node-fetch'

const port = 9000
const app: express.Express = express()
const router = Router()
app.use(router)

router.get('/', handleRequest)
router.get('/fibo/js/:n', fiboJsController)
router.get('/fibo/wasm/:n', fiboWasmController)

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})

// ============================================================================

const wasmModule = require('./wasm_module')

async function handleRequest(req:Request, res:Response) {
  const a = Number(req.query.a)
  const b = Number(req.query.b)

  const result = wasmModule._multiply(a, b)
  const json = JSON.stringify({result: result})
  res.send(json)
}

function fiboJs(n:number):number{
  if(n < 2){
    return n
  }
  return fiboJs(n-2) + fiboJs(n-1)
}

async function fiboJsController(req:Request, res:Response){
  const n = Number(req.params['n'])
  let result: number[] = []
  for(let i=0;i<n;i++){
    result.push(
      fiboJs(i)
    )
  }
  res.send({result: result})
}

async function fiboWasmController(req:Request, res:Response){
  const n = Number(req.params['n'])
  let result: number[] = []
  for(let i=0;i<n;i++){
    result.push(
      wasmModule._fiboNim(i)
    )
  }
  res.send({result: result})
}
