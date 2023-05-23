# poa_backend Clean Architecture Node TypeScript Express

---

###### Example .env added

### About 

It´s a test server to learn tsc and mainly clean architecure

#### Collaborators

- Herrera Hernandez Joel Alejandro

### Documentation

[DB notSQL Scheme]() 

[Environment PostMan]()

## First steps to set up the project with npm 

---



**Dependencies project**

  + Create dates about the project -`npm init --yes`
  + Framework _Express.js_ to create server - `npm i express`
  + Allows to communicate between servers - `npm i cors`
  + Create environment variables - `npm i dotenv`
  + DB Postgres - `npm i pg`
  + Generate a token - `npm i jsonwebtoken`
  + Codification - `npm i bcryptjs`

  **Dependencies developers**

 + Just see the client request  - `npm i morgan  -D`
 + Install environment typescript -`npm i typescript -D`
 + Create tsc configuration file -`npx tsc --init`
 + Run project `npm i -D ts-node-dev`
 + Compatibility  `npm i @types/express @types/cors @types/pg @types/jsonwebtoken @types/bcryptjs -D`

Remove dependencies `npm uninstall <package>`

## Structure folders 

- src
  - kernel
  - modules
    - adapters
    - entities
    - use-cases
      - ports
  - utils
  - index
- test
  - collection postman
  - db
- .env
- .gitignore
- tsconfig.json


### DevNotes

You can start the back-end with `npm run dev` this command it's on package.json
In yours script you should to use: 
`"dev": "concurrently \"tsc --watch\" \"nodemon dist/index.js\""`


### ProjectNotes

1. It's better to do a modulation as Clean Architecture
2. We try to handle exceptions
3. There are three ways of sending values (Request)

   -  **uriParams** ~ Link /api/**:data** > request.params.{data}
   
   -  **queryParams** ~ api?name={data}&age={age} > req.query
   
   -  **paylod** ~ POST > req.body
   
4. Do destruction 
5. add authenticantion


###### Resources

- https://merlino.agency/blog/clean-architecture-in-express-js-applications
- https://www.npmjs.com/package/express _framework_
- https://developer.mozilla.org/es/docs/Web/HTTP/Status _Investigate Status Codes_
- https://www.npmjs.com/package/cors  _middleware_
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
- https://blogs.itemis.com/en/the-deployment-pipeline-the-basis-for-successful-software-development _pipeline_
-  https://stackoverflow.com/questions/39632667/how-do-i-kill-the-process-currently-using-a-port-on-localhost-in-windows -killPort process-




