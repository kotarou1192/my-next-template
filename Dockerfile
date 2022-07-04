FROM node:18 AS deps

ENV NODE_ENV production

EXPOSE 3000

WORKDIR /usr/src/app
COPY ["package.json", "yarn.lock", "./"]

RUN yarn install --frozen-lockfile

FROM node:18 as build
WORKDIR /usr/src/app

COPY . .
COPY --from=deps /usr/src/app/node_modules ./node_modules
ENV NODE_ENV production

RUN yarn build

FROM node:18 AS prod
WORKDIR /usr/src/app
ENV NODE_ENV production

COPY --from=build /usr/src/app/public ./public
COPY --from=build /usr/src/app/.next ./.next
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

CMD [ "yarn", "start" ]
