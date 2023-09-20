FROM node:10.17.0

RUN git clone https://github.com/openaccounting/oa-web.git
WORKDIR oa-web

RUN sed -i 's/wss:/ws:/' src/app/core/session.service.ts

RUN npm install

EXPOSE 4200

CMD ["npm", "run", "--", "ng", "serve", "--host", "0.0.0.0"]

